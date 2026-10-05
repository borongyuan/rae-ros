#!/bin/bash
set -e

# Check and export pwm channels if not already exported
for channel in 1 2; do
    pwm="/sys/class/pwm/pwmchip0/pwm${channel}/"
    if [ ! -d ${pwm} ]; then
        echo ${channel} > /sys/class/pwm/pwmchip0/export
    fi
    chmod -R a+rw ${pwm}
done

chmod -R a+rw /dev/gpiochip0

export COLCON_DEFAULT_EXECUTOR=sequential
export RMW_IMPLEMENTATION=rmw_zenoh_cpp

source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/ws/install/setup.bash"
source "$HOME/.bashrc"

export ZENOH_CONFIG_OVERRIDE='connect/endpoints=["tcp/192.168.100.21:7447"]'
ros2 run rmw_zenoh_cpp rmw_zenohd &

export ZENOH_CONFIG_OVERRIDE=''
ros2 launch rae_bringup hardware.launch.py

exec "$@"
