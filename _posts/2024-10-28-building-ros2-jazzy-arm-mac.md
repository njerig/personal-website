---
title: How to Build and Install ROS 2 Jazzy on an ARM Mac
subtitle: A labor of...love?
tags: ros
---

Here are my detailed instructions on how I got ROS 2 Jazzy Jalisco running on my M3 Mac _without Rosetta_.

For reference, here are some links that helped me get started:
- [ROS 2 Jazzy Docs](https://docs.ros.org/en/jazzy/Installation/Alternatives/macOS-Development-Setup.html)
- [Kliment Mamykin's instructions for building ROS 2 Galactic on an M1 Mac](http://mamykin.com/posts/building-ros2-on-macos-big-sur-m1/)

## A Note on Homebrew
If you migrated your Homebrew setup from an Intel Mac to an ARM Mac (as I did), you're going to have some issues resulting from
1. the architecture changing, and
2. having some packages installed in `/usr/local` (the Intel Mac's `brew --prefix`) and some installed in `/opt/homebrew` (the ARM Mac's `brew --prefix`).

Stay tuned on how I solved these issues.

## Directory Layout
I suggest making a root directory that you can then put your `ros2_jazzy` folder and your `venv` folder.

```
<root>
   ├── ros2_jazzy/     ROS workspace
   ├── venv/           Python virtual environment
```
I'm going to refer to the root directory as `outer_dir` from now on.

## Python 3.11
Install Python 3.11 using 
```shell
brew install python@3.11
```

## Virtual environment
Use whatever virtual environment setup you're comfortable with. You don't need to use direnv. (I didn't.) You don't even have to put the venv folder in the root folder like I suggested above.

While I used virtualfish,
```shell
cd /path/to/outer_dir
python3.11 -m venv venv
```
works perfectly fine.

Make sure you
```shell
source venv/bin/activate
pip install --upgrade pip
```
before starting the next section.

## Install prerequisites
Follow the [ROS 2 Jazzy documentation section on install prerequisites](https://docs.ros.org/en/jazzy/Installation/Alternatives/macOS-Development-Setup.html#install-prerequisites). You do not need to disable System Integrity Protection (SIP).

Once you're done,
```shell
pip uninstall empy
pip install empy==3.3.4
```

## Clone ROS
You'll want to create a workspace and clone all ROS repositories:
```shell
mkdir -p ~/ros2_jazzy/src
cd ~/ros2_jazzy
vcs import --input https://raw.githubusercontent.com/ros2/ros2/jazzy/ros2.repos src
```

## Build ROS
```
colcon build \
    --symlink-install \
    --merge-install \
    --event-handlers console_cohesion+ console_package_list+ \
    --packages-skip-by-dep python_qt_binding \
    --cmake-args \
        --no-warn-unused-cli \
        -DBUILD_TESTING=OFF \
        -DINSTALL_EXAMPLES=ON \
        -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk \
        -DCMAKE_OSX_ARCHITECTURES="arm64" \
        -DCMAKE_PREFIX_PATH=$(brew --prefix):$(brew --prefix qt@5) \
        -DPython3_EXECUTABLE=$(which python3) \
```

## An Incomplete List of Errors and Solutions

### `rviz_ogre_vendor`  `fatal error: 'Availability.h' file not found`
I solved this by 
1. reinstalling XCode, and
2. reinstalling XCode Command Line Tools:
   ```
   sudo rm -rf /Library/Developer/CommandLineTools
   xcode-select --install
   ```

### `<insert package here>` is giving you an `undefined symbols for architecture` error
Double check that you don't have the offending package in `/usr/local/Cellar`.  If you do have it, just
```shell
rm -rf /usr/local/Cellar/<offending package>
```

### Can't find Python errors
Deactivate and reactivate your virtual environment. (Have you tried turning it off, then on again?)

I hope this helps!