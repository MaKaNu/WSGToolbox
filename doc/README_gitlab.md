# Overview

![word-and-design-mark-logo](/logo/wsg-toolbox_word_and_design_mark.png)

This Class Folder includes (at the moment) the class wsg50. It provides the  user with everything needed to use the gripper-module with MATLAB. The complexity of the hardware interface is reduced, so the user can call directly the commands for the gripper-module.

The Class includes the following User-Functions:

### Connection Management

* [loop](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/loop)
* [disconnect](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/disconnect)

### Motion Control

* [reference](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/reference)
* [position](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/position)
* [stop](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/stop)
* [fast_stop](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/fast_stop)
* [ack](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/ack)
* [grasp](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/grasp)
* [release](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/release)

### Motion Configuration

* [set_acc](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/set_acc)
* [get_acc](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_acc)
* [set_force](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/set_force) (in progress) DON'T USE
* [get_force](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_force)
* [set_softlimits](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/set_softlimits)
* [get_softlimits](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_softlimits)
* [reset_softlimits](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/reset_softlimits)
* [overdirve](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/overdrive) (in progress) DON'T USE
* [tare_sensor](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/tare_sensor) (in dev)

### System States

* [sys_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/sys_state)
* [gripper_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/gripper_state)
* [gripper_statistic](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/gripper_statistic)
* [openwidth_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/openwidth_state)
* [fingerspeed_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/fingerspeed_state)
* [gripperforce_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/gripperforce_state)
* [temperature_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/temperature_state)

### System Configuration

* [sys_info](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/sys_info)
* [set_device_tag](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/set_device_tag)
* [get_device_tag](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_device_tag)
* [get_syslimits](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_syslimits)

### Finger Interface

* [get_finger1_info](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_finger1_info) (in dev)
* [get_finger1_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_finger1_state) (in dev)
* [power_finger1](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/power_finger1) (in dev)
* [get_finger1_data](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_finger1_data) (in dev)
* [get_finger2_info](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_finger2_info) (in dev)
* [get_finger2_state](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_finger2_state) (in dev)
* [power_finger2](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/power_finger2) (in dev)
* [get_finger2_data](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/wsg50/get_finger2_data) (in dev)

## Installation

The Installation-Guide is localized in the [WIKI](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home)

## Usage

The Complete explanation how to use the class is found in the [WIKI](https://git.lit.fh-dortmund.de/rvc/weiss_tools/wsg50/wikis/home/usage)

## Citing

@misc{wsg50.2019, title={WSG: A Gripper Class for MATLAB}, author={Kaupenjohann, Matti}, year={2019} }
