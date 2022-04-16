#include "imls_icp.h"
#include <csm/csm_all.h>
#include "ros/ros.h"
#include "tf/transform_listener.h"
#include "sensor_msgs/PointCloud.h"
#include "geometry_msgs/Point32.h"
#include "visualization_msgs/Marker.h"
#include "visualization_msgs/MarkerArray.h"
#include "champion_nav_msgs/ChampionNavLaserScan.h"
#include <nav_msgs/Odometry.h>
#include <nav_msgs/Path.h>
#include <rosbag/bag.h>
#include <rosbag/view.h>
#include <boost/foreach.hpp>

//pcl::visualization::CloudViewer g_cloudViewer("cloud_viewer");
//此处bag包的地址需要自行修改
std::string bagfile = ".../imlsMatcherProject/src/bag/imls_icp.bag";


class imlsDebug
{
public:
    imlsDebug()      // 构造函数
    {
        /*
         * 消息发送(最终在rviz中实时显示轨迹)的递进关系:
         *     Publisher(发布类型<nav_msgs::Path>)  发布  nav_msgs::Path（frame_id = "odom"),  包含  geometry_msgs::PoseStamped
         * bag内两种消息类型: 激光 champion_nav_msgs::ChampionNavLaserScan, 里程计 nav_msgs::Odometry
         */

        m_imlsPathPub = m_node.advertise<nav_msgs::Path>("imls_path_pub_",1,true);
        m_imlsPath.header.stamp = ros::Time::now();        // 点云中最后一点的采集时刻
        m_imlsPath.header.frame_id = "odom";               // 该点云坐标所属的坐标系
        m_odomPathPub = m_node.advertise<nav_msgs::Path>("odom_path_pub_",1,true);
        m_odomPath.header.stamp = ros::Time::now();
        m_odomPath.header.frame_id = "odom";

        m_isFirstFrame = true;

        // 使用rosbag读取消息可参考 => “ROS系列：九、rosbag使用” https://blog.csdn.net/hltt3838/article/details/107652555
        rosbag::Bag bag;
        bag.open(bagfile, rosbag::bagmode::Read);

        std::vector<std::string> topics;      // 创建存储 topics 的容器，压入话题名，话题名应该与写入bag文件时的话题名一致
        topics.push_back(std::string("/sick_scan"));
        topics.push_back(std::string("/odom"));
        rosbag::View view(bag, rosbag::TopicQuery(topics));    // 创建 rosbag::View类，用以查看bag

        //按顺序读取bag内激光的消息和里程计的消息
        // 头文件中需要调用<boost/foreach.hpp>来实现遍历，还有对应的需要查看的消息类型的头文件 "champion_nav_msgs/ChampionNavLaserScan.h"
        // m: 消息实例   view: 消息源    =>  类似遍历for循环
        BOOST_FOREACH(rosbag::MessageInstance const m, view)
        {
            champion_nav_msgs::ChampionNavLaserScanConstPtr scan = m.instantiate<champion_nav_msgs::ChampionNavLaserScan>();
            if(scan != NULL)
                championLaserScanCallback(scan);    // 执行对应的回调函数

            nav_msgs::OdometryConstPtr odom = m.instantiate<nav_msgs::Odometry>();
            if(odom != NULL)
                odomCallback(odom);                 // 执行对应的回调函数
            /*
             * see: https://blog.csdn.net/weixin_40215443/article/details/103793316  ros::spin()、ros::spinOnce()：使用细节、区别
             *
             * 当spinOnce函数被调用时，spinOnce就会调用回调函数队列中第一个callback函数，此时callback函数被执行。
             * spinOnce函数执行一次后，接着执行下面的语句。
             * 等到下次spinOnce函数又被调用时，回调函数队列中第二个callback函数就会被调用，以此类推
             * 由于程序不是实时执行，而是处理bag数据，所以这里未设置执行频率，即假设了，一旦有数据到达，就执行回调函数，而不进行睡眠
             * 也可以通过ros::Rate rate(100), while, ros::spinOnce(), rate.sleep()配合使用，来设置ros::subscriber的监听频率为100Hz
             */
            ros::spinOnce();
            if(!ros::ok())
                break;
        }
        // m_laserscanSub = m_nh.subscribe("sick_scan",5,&imlsDebug::championLaserScanCallback,this);
    }

    //将激光消息转换为激光坐标系下的二维点云
    void ConvertChampionLaserScanToEigenPointCloud(const champion_nav_msgs::ChampionNavLaserScanConstPtr& msg,
                                                   std::vector<Eigen::Vector2d>& eigen_pts)
    {
        eigen_pts.clear();
        for(int i = 0; i < msg->ranges.size(); ++i)
        {
            if(msg->ranges[i] < msg->range_min || msg->ranges[i] > msg->range_max)
                continue;

            double lx = msg->ranges[i] * std::cos(msg->angles[i]);
            double ly = msg->ranges[i] * std::sin(msg->angles[i]);

            if(std::isnan(lx) || std::isinf(ly) ||
               std::isnan(ly) || std::isinf(ly))
                continue;

            eigen_pts.push_back(Eigen::Vector2d(lx,ly));
        }
    }

    void championLaserScanCallback(const champion_nav_msgs::ChampionNavLaserScanConstPtr& msg)
    {
        if(m_isFirstFrame == true)      // 区别处理第一帧点云
        {
            std::cout <<"First Frame"<<std::endl;
            m_isFirstFrame = false;
            m_prevLaserPose = Eigen::Vector3d(0, 0, 0);
            pubPath(m_prevLaserPose, m_imlsPath, m_imlsPathPub);                // 发布激光雷达在里程计坐标系下的路径信息
            ConvertChampionLaserScanToEigenPointCloud(msg, m_prevPointCloud);   // 将激光消息ranges+angles转换为激光坐标系下的二维点云
            return ;
        }

        std::vector<Eigen::Vector2d> nowPts;
        ConvertChampionLaserScanToEigenPointCloud(msg, nowPts);

        //调用imls进行icp匹配，并输出结果．
        m_imlsMatcher.setSourcePointCloud(nowPts);
        m_imlsMatcher.setTargetPointCloud(m_prevPointCloud);

        Eigen::Matrix3d rPose,rCovariance;
        if(m_imlsMatcher.Match(rPose,rCovariance))
        {
            std::cout <<"IMLS Match Successful:"<<rPose(0,2)<<","<<rPose(1,2)<<","<<atan2(rPose(1,0),rPose(0,0))*57.295<<std::endl;
            Eigen::Matrix3d lastPose;
            lastPose << cos(m_prevLaserPose(2)), -sin(m_prevLaserPose(2)), m_prevLaserPose(0),
                        sin(m_prevLaserPose(2)),  cos(m_prevLaserPose(2)), m_prevLaserPose(1),
                        0, 0, 1;
            // 右乘帧间相对位姿，因为: T_Odom_now = T_Odom_last * T_last_now = T_Odom_last * T_Odom_last.inverse() * T_Odom_now
            Eigen::Matrix3d nowPose = lastPose * rPose;
            m_prevLaserPose << nowPose(0, 2), nowPose(1, 2), atan2(nowPose(1,0), nowPose(0,0));
            pubPath(m_prevLaserPose, m_imlsPath, m_imlsPathPub);
        }
        else
        {
            std::cout <<"IMLS Match Failed!!!!"<<std::endl;
        }

        m_prevPointCloud = nowPts;
    }

    void odomCallback(const nav_msgs::OdometryConstPtr& msg)
    {
        if(m_isFirstFrame == true)
            return;

        pubPath(msg, m_odomPath, m_odomPathPub);
    }

    //发布激光雷达在全局里程计坐标系下的路径消息
    void pubPath(Eigen::Vector3d& pose, nav_msgs::Path &path, ros::Publisher &mcu_path_pub_)
    {
        /* 参考: 古月居 https://www.guyuehome.com/14553
         * ROS自己独特的message类型:  geometry_msgs::PoseStamped．
         * Pose 就是机器人的位姿(position and orientation)
         * Stamped 表示时间戳(timestamped)，这儿时间戳是指时间戳是指格林威治时间1970年01月01日00时00分00秒起至现在的总纳秒．几乎所有的计算机都可以使用这个时间，方便统一．
         * 所以PoseStamped记录的是机器人的位姿加上记录位姿的时间这么一种message
         *
         * 通过geometry_msgs::PoseStamped msg定义一个叫msg的对象，该对象拥有header,pose两个数据成员．
         * header.stamp, header.frame_id, pose.position, pose.orientation
         */

        ros::Time current_time = ros::Time::now();
        geometry_msgs::PoseStamped this_pose_stamped;
        this_pose_stamped.pose.position.x = pose(0);
        this_pose_stamped.pose.position.y = pose(1);

        geometry_msgs::Quaternion goal_quat = tf::createQuaternionMsgFromYaw(pose(2));
        this_pose_stamped.pose.orientation.x = goal_quat.x;
        this_pose_stamped.pose.orientation.y = goal_quat.y;
        this_pose_stamped.pose.orientation.z = goal_quat.z;
        this_pose_stamped.pose.orientation.w = goal_quat.w;

        this_pose_stamped.header.stamp = current_time;
        this_pose_stamped.header.frame_id = "odom";

        /*
         * 参考:  ROS在rviz中实时显示轨迹（nav_msgs/Path消息的使用） https://blog.csdn.net/ktigerhero3/article/details/70256437
         * nav_msgs::Path.msg包括两个数据成员:
         *    1. std_msgs::Header header (包括path.header.stamp ; path.header.frame_id)
         *    2. geometry_msgs::PoseStamped[] poses, 通过path.poses.push_back()压入geometry_msgs::PoseStamped类的消息
         */

        path.poses.push_back(this_pose_stamped);
        mcu_path_pub_.publish(path);    // 使用一个Publisher将轨迹消息发布出去
    }

    // 发布里程计在全局里程计坐标系下的路径消息
    void pubPath(const nav_msgs::OdometryConstPtr& msg, nav_msgs::Path &path, ros::Publisher &mcu_path_pub_)
    {
        /*
         * 参考: 古月居 如何发布里程计消息  https://www.guyuehome.com/332
         * nav_msgs/Odometry消息包含有机器人在自由空间中的位置 pose 和速度估算值 twist:
         *      Header header
         *      string child_frame_id
         *      geometry_msgs/PoseWithCovariance pose
         *      geometry_msgs/TwistWithCovariance twist
         */

        ros::Time current_time = ros::Time::now();
        geometry_msgs::PoseStamped this_pose_stamped;
        this_pose_stamped.pose.position.x = msg->pose.pose.position.x;
        this_pose_stamped.pose.position.y = msg->pose.pose.position.y;

        this_pose_stamped.pose.orientation.x = msg->pose.pose.orientation.x;
        this_pose_stamped.pose.orientation.y = msg->pose.pose.orientation.y;
        this_pose_stamped.pose.orientation.z = msg->pose.pose.orientation.z;
        this_pose_stamped.pose.orientation.w = msg->pose.pose.orientation.w;

        this_pose_stamped.header.stamp = current_time;
        this_pose_stamped.header.frame_id = "odom";
        path.poses.push_back(this_pose_stamped);
        mcu_path_pub_.publish(path);
    }

    bool m_isFirstFrame;
    ros::NodeHandle m_nh;
    IMLSICPMatcher m_imlsMatcher;
    Eigen::Vector3d m_prevLaserPose;
    std::vector<Eigen::Vector2d> m_prevPointCloud;
    nav_msgs::Path m_imlsPath;
    nav_msgs::Path m_odomPath;

    tf::TransformListener m_tfListener;
    ros::NodeHandle m_node;

    ros::Subscriber m_laserscanSub;
    ros::Publisher m_imlsPathPub;
    ros::Publisher m_odomPathPub;
};


int main(int argc, char** argv)
{
    ros::init(argc, argv, "imls_debug");

    imlsDebug imls_debug;

    ros::spin();

    return (0);
}

