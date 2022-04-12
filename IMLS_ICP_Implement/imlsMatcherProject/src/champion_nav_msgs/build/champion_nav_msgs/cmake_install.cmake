# Install script for directory: /home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/src/champion_nav_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/opt/ros/melodic")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/champion_nav_msgs/msg" TYPE FILE FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/src/champion_nav_msgs/msg/ChampionNavLaserScan.msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/champion_nav_msgs/cmake" TYPE FILE FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/build/champion_nav_msgs/catkin_generated/installspace/champion_nav_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/devel/include/champion_nav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/devel/share/roseus/ros/champion_nav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/devel/share/common-lisp/ros/champion_nav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/devel/share/gennodejs/ros/champion_nav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/devel/lib/python2.7/dist-packages/champion_nav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/devel/lib/python2.7/dist-packages/champion_nav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/build/champion_nav_msgs/catkin_generated/installspace/champion_nav_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/champion_nav_msgs/cmake" TYPE FILE FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/build/champion_nav_msgs/catkin_generated/installspace/champion_nav_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/champion_nav_msgs/cmake" TYPE FILE FILES
    "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/build/champion_nav_msgs/catkin_generated/installspace/champion_nav_msgsConfig.cmake"
    "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/build/champion_nav_msgs/catkin_generated/installspace/champion_nav_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/champion_nav_msgs" TYPE FILE FILES "/home/jindong/Lidar_SLAM/Exercise/ch4/HW4/imlsMatcherProject/src/champion_nav_msgs/src/champion_nav_msgs/package.xml")
endif()

