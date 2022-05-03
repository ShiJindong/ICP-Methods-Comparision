# IMLS Matcher
---
The explain of the code, please see:  /ICP-Methods-Comparision/imlsMatcherProject/IMLS_Matcher_Code_Explain.pdf

Compile condition:
     
     1. install Boost, Eigen3, ROS
     
     2. install libnabo library，please see: 
     
        https://blog.csdn.net/qq_36501182/article/details/79043592
     
     3. install pcl library，w.r.t. the pcl version you have installed on your computer，please change the pcl version in src/imlsMatcher/CMakeLists.txt，for example pcl-1.7, pcl-1.8
        (Attention: you should also change the ros version in file   src/imlsMatcher/CMakeLists.txt to the ros version you have installed, e.g. melodic, kinetic)
     
     4. install messages to your linux system:
        cd src/champion_nav_msgs
        bash install.sh
        (Attention: you should change the ros version in file   src/champion_nav_msgs/install.sh to the ros version you have installed, e.g. melodic, kinetic)
        
     
     5. decompress rosbag file 
          imlsMatcherProject/src/bag/imls_icp_bag.zip 
          to 
          imlsMatcherProject/src/bag/
        change rosbag path in file src/imlsMatcher/src/main.cpp 
         
Compile:
     
     cd .../imlsMatcherProject
     
     catkin_make

Execute:
     
     roscore
     
     cd .../imlsMatcherProject
     
     source devel/setup.bash
     
     rosrun imlsMatcher imlsMatcher_node
     
open rviz, add two topic messages (/imls_path_pub_ and /odom_path_pub_)，set the fixed frame as "odom"

You will see the result as /ICP-Methods-Comparision/imlsMatcherProject/trajectory_in_rviz/result.png

     
     
     

