
(cl:in-package :asdf)

(defsystem "champion_nav_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "ChampionNavLaserScan" :depends-on ("_package_ChampionNavLaserScan"))
    (:file "_package_ChampionNavLaserScan" :depends-on ("_package"))
  ))