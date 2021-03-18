# Overview

![word-and-design-mark-logo](/logo/wsg-toolbox_word_and_design_mark.png)

## Installation

It is possible to use three different ways to install wsg-toolbox for MATLAB

1. Toolbox installation file
   1. Download the ```.mtlbx```-File from the wanted version [release page](link_release) or [MATLAB Central](link0_matlab_central).
   2. [Install the toolbox](link_install_tb) by executing the file with MATLAB
2. Source installation
   1. [clone](link_clone) the repository to a user specific directory
   2. include the path of the repository to the [MATLAB path](link_include_path)

## Usage

The Usage of the toolbox described in this README is a small getting started explanation for more informations call the [doc](link_doc) function for wsg-toolbox.

The goal of the following example is to check the gripper options for a wsg50 gripper and grasp a ball that is laying between a small gap. Afterwards the gripper will be moved (by a robot) to a box. Before releasing the ball, the user wants to check the value of the gripping force.

### Initialization

Before using the gripper, it has to be initialized by its constructor. In this example, the gripper's initilaize arguments are `IP=111.22.33.44` and `PORT=9999`:

```matlab
gripper=wsg-toolbox('IP','111.22.33.44','PORT',9999);`
```

### Execution

If the initalization was succesful, it is possible to call the first function:

```matlab
gripper.connect();
```

this will open the connection between the MATLAB-Computer and the gripper. If the connection is already opened, the function returns a warning:

```matlab
Warning: Connection is already established!` 
> In wsg-toolbox/connect (line 6) 
```

Now it is possible to call the first function, that moves the gripper:

```maltab
gripper.reference('open');
```

This function runs a homing. It is executed automatically every time the gripper is enabled. With the attribute `'open'` we decide, that the homing is carried out in the outer direction.

The gap, mentioned at the beginning of this example, measures 90 mm. So we have to adjust the soft limits of the gripper. A limit of 45 mm should be sufficient, because the gripper jaw measure 20 mm each.

```maltab
gripper.set_softlimits(0,45);
```

The gripper arms should now stand at the outer position, but the plus softlimit is smaller then 110 mm, so we have to move the gripper into the softlimits. (It is possible to move the gripper into the limits, but not out of them.)

```matlab
gripper.position('stop_abs', 40, 100);
```

At this moment we can check the softlimits:

```matlab
gripper.get_softlimit();
```

the return value is:

```matlab
LIMIT MINUS:0 mm
LIMIT PLUS:45 mm
```

Now we can move the gripper inside the gap to grasp the small ball with a 30 mm diameter. We use the following function:

```matlab
gripper.grasp(30,55);
```

If we missed the ball the function returns:

```matlab
E_CMD_FAILED
Fehler waehrend der Ausfuehrung eines Befehls.
```

---

### NOTE grasp-status

Functions to do the following are implemented but not yet tested for the example

---

In that case we can use the function

```matlab
TODO: test and add functions
```

to read the grasp-status.

After succesful grasp we move the gripper to the box. Before releasing the ball, we want to know the temprature and the grasp force:

```matlab
TODO: test and add functions
```

---

---

Next we simply release the ball:

```matlab
gripper.release(110,70);
```

The function returns:

```matlab
E_RANGE_ERROR
Bereichsfehler.
```

This happens because we still have the softlimits. So we have to reset them...

```matlab
gripper.reset_softlimits;
```

...and repeat the "release"-function:

```matlab
gripper.release(110,70);
```

#### Code-Script

```matlab
gripper=wsg-toolbox('IP','172.16.6.79','PORT',1001);
gripper.connect();
gripper.reference('open');
gripper.set_softlimits(0,45);
gripper.get_softlimit;
gripper.grasp(30,55);
TODO:
    add and test missing functions
gripper.release(110,70);
gripper.reset_softlimits;
gripper.release(110,70);
```

### License

[BSD-3 Clause License](LICENSE)

### Citing

@misc{wsg50.2019, title={WSG: A Gripper Class for MATLAB}, author={Kaupenjohann, Matti}, year={2019} }

[link_release]: https://i.imgur.com/OvMZBs9.jpeg
[link0_matlab_central]: https://i.imgur.com/OvMZBs9.jpeg
[link_install_tb]: https://de.mathworks.com/help/matlab/ref/matlab.addons.toolbox.installtoolbox.html
[link_clone]: https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository
[link_include_path]: https://de.mathworks.com/help/matlab/ref/path.html
[link_doc]: https://de.mathworks.com/help/matlab/ref/doc.html
