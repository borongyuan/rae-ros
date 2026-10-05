from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.substitutions import PathJoinSubstitution
from launch_ros.actions import Node
from launch_ros.substitutions import FindPackageShare


def generate_launch_description():

    rae_hw = IncludeLaunchDescription(
        PathJoinSubstitution([
            FindPackageShare('rae_hw'),
            'launch',
            'control.launch.py'
        ]),
        launch_arguments = {'enable_localization': False}.items(),
    )

    battery_status_node = Node(
        executable = 'battery_status.py',
        package = 'rae_bringup',
    )

    car_demo_node = Node(
        executable = 'led_test.py',
        package = 'rae_bringup',
    )

    return LaunchDescription([rae_hw, battery_status_node, car_demo_node])
