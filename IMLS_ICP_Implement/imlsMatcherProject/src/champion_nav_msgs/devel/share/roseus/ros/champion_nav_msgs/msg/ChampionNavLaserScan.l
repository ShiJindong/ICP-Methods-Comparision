;; Auto-generated. Do not edit!


(when (boundp 'champion_nav_msgs::ChampionNavLaserScan)
  (if (not (find-package "CHAMPION_NAV_MSGS"))
    (make-package "CHAMPION_NAV_MSGS"))
  (shadow 'ChampionNavLaserScan (find-package "CHAMPION_NAV_MSGS")))
(unless (find-package "CHAMPION_NAV_MSGS::CHAMPIONNAVLASERSCAN")
  (make-package "CHAMPION_NAV_MSGS::CHAMPIONNAVLASERSCAN"))

(in-package "ROS")
;;//! \htmlinclude ChampionNavLaserScan.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass champion_nav_msgs::ChampionNavLaserScan
  :super ros::object
  :slots (_header _angle_min _angle_max _scan_time _time_increment _range_min _range_max _ranges _angles _intensities ))

(defmethod champion_nav_msgs::ChampionNavLaserScan
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:angle_min __angle_min) 0.0)
    ((:angle_max __angle_max) 0.0)
    ((:scan_time __scan_time) 0.0)
    ((:time_increment __time_increment) 0.0)
    ((:range_min __range_min) 0.0)
    ((:range_max __range_max) 0.0)
    ((:ranges __ranges) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:angles __angles) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:intensities __intensities) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _angle_min (float __angle_min))
   (setq _angle_max (float __angle_max))
   (setq _scan_time (float __scan_time))
   (setq _time_increment (float __time_increment))
   (setq _range_min (float __range_min))
   (setq _range_max (float __range_max))
   (setq _ranges __ranges)
   (setq _angles __angles)
   (setq _intensities __intensities)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:angle_min
   (&optional __angle_min)
   (if __angle_min (setq _angle_min __angle_min)) _angle_min)
  (:angle_max
   (&optional __angle_max)
   (if __angle_max (setq _angle_max __angle_max)) _angle_max)
  (:scan_time
   (&optional __scan_time)
   (if __scan_time (setq _scan_time __scan_time)) _scan_time)
  (:time_increment
   (&optional __time_increment)
   (if __time_increment (setq _time_increment __time_increment)) _time_increment)
  (:range_min
   (&optional __range_min)
   (if __range_min (setq _range_min __range_min)) _range_min)
  (:range_max
   (&optional __range_max)
   (if __range_max (setq _range_max __range_max)) _range_max)
  (:ranges
   (&optional __ranges)
   (if __ranges (setq _ranges __ranges)) _ranges)
  (:angles
   (&optional __angles)
   (if __angles (setq _angles __angles)) _angles)
  (:intensities
   (&optional __intensities)
   (if __intensities (setq _intensities __intensities)) _intensities)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _angle_min
    4
    ;; float32 _angle_max
    4
    ;; float32 _scan_time
    4
    ;; float32 _time_increment
    4
    ;; float32 _range_min
    4
    ;; float32 _range_max
    4
    ;; float32[] _ranges
    (* 4    (length _ranges)) 4
    ;; float32[] _angles
    (* 4    (length _angles)) 4
    ;; float32[] _intensities
    (* 4    (length _intensities)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _angle_min
       (sys::poke _angle_min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angle_max
       (sys::poke _angle_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _scan_time
       (sys::poke _scan_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _time_increment
       (sys::poke _time_increment (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _range_min
       (sys::poke _range_min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _range_max
       (sys::poke _range_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _ranges
     (write-long (length _ranges) s)
     (dotimes (i (length _ranges))
       (sys::poke (elt _ranges i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _angles
     (write-long (length _angles) s)
     (dotimes (i (length _angles))
       (sys::poke (elt _angles i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _intensities
     (write-long (length _intensities) s)
     (dotimes (i (length _intensities))
       (sys::poke (elt _intensities i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _angle_min
     (setq _angle_min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angle_max
     (setq _angle_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _scan_time
     (setq _scan_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _time_increment
     (setq _time_increment (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _range_min
     (setq _range_min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _range_max
     (setq _range_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _ranges
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ranges (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ranges i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _angles
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _angles (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _angles i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _intensities
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _intensities (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _intensities i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get champion_nav_msgs::ChampionNavLaserScan :md5sum-) "850289c5c3fc67d7436158ddcfd96432")
(setf (get champion_nav_msgs::ChampionNavLaserScan :datatype-) "champion_nav_msgs/ChampionNavLaserScan")
(setf (get champion_nav_msgs::ChampionNavLaserScan :definition-)
      "Header header
float32 angle_min
float32 angle_max
float32 scan_time
float32 time_increment
float32 range_min
float32 range_max
float32[] ranges
float32[] angles
float32[] intensities

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :champion_nav_msgs/ChampionNavLaserScan "850289c5c3fc67d7436158ddcfd96432")


