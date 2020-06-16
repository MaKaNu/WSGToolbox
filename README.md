# WSG50
    
![Weiss Robotics](/Logo.gif "Weiss Robotics Logo")

## Overview
This Class Folder includes (at the moment) the class wsg50. It provides the  user with everything needed to use the gripper-module with MATLAB. The complexity of the hardware interface is reduced, so the user can call directly the commands for the gripper-module.

The Class includes the following User-Functions:

### Connection Management
* loop
* disconnect

### Motion Control
* reference
* position
* stop
* fast_stop
* ack
* grasp
* release

### Motion Configuration
* set_acc
* get_acc
* set_force (in progress) DON'T USE
* get_force
* set_softlimits
* get_softlimits
* reset_softlimits
* overdirve (in progress) DON'T USE
* tare_sensor (in dev)

### System States
* sys_state
* gripper_state
* gripper_statistic
* openwidth_state
* fingerspeed_state
* gripperforce_state
* temperature_state

### System Configuration
* sys_info
* set_device_tag
* get_device_tag
* get_syslimits

### Finger Interface
* get_finger1_info
* get_finger1_state
* power_finger1
* get_finger1_data
* get_finger2_info
* get_finger2_state
* power_finger2
* get_finger2_data

## Installation
The Installation-Guide is localized in the [WIKI](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home)
## Usage
The Complete explanation how to use the class is found in the [WIKI](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/usage)

Greifer     | IP-Adress     | PORT
--------    | --------      | --------
WSG50_IP72  | 172.16.6.72   | 1000
WSG50_IP79  | 172.16.6.79   | 1002
## Citing
@misc{wsg50.2019, title={WSG: A Gripper Class for MATLAB}, author={Kaupenjohann, Matti}, year={2019} }
