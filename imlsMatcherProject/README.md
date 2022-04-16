# IMLS Matcher
---
代码解析见 /ICP-Methods-Comparision/imlsMatcherProject/IMLS_Matcher_Code_Explain.pdf

编译条件:
     
     1. 安装Boost, Ceres, CSM, OpenCV, Eigen3
     
     2. 安装libnabo库，参考: 
     
        https://blog.csdn.net/qq_36501182/article/details/79043592
     
     3. 安装pcl点云库，根据你安装的版本，改变 src/imlsMatcher/CMakeLists.txt内的pcl版本，比如pcl-1.7, pcl-1.8等
        (注意，需要将src/imlsMatcher/CMakeLists.txt内的ros版本改成你安装的ros版本，比如melodic, kinetic等)
     
     4. 安装自定义消息到系统，执行src/champion_nav_msgs内的install.sh:     bash install.sh
        (注意，需要先将install.sh内的ros版本改成你安装的ros版本，比如melodic, kinetic等)
     
     5. 修改 src/imlsMatcher/src/main.cpp内bag包的路径为你的bag路径。
         
编译:
     
     将 imlsMatcherProject/src/bag/imls_icp_bag.zip 解压到 imlsMatcherProject/src/bag/
     
     cd .../imlsMatcherProject
     
     catkin_make

运行:
     
     新打开一个命令窗口后
     
     roscore
     
     cd .../imlsMatcherProject
     
     source devel/setup.bash
     
     rosrun imlsMatcher imlsMatcher_node
     
     打开rviz, add两个topic信息 /imls_path_pub_ 和 /odom_path_pub_，将坐标系改为odom
     
显示结果见 /ICP-Methods-Comparision/imlsMatcherProject/trajectory_in_rviz/result.png

     
     
     

