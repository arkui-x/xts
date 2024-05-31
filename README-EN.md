# XTS

## Introduction
The X test suite (XTS) is used to ensure consistent ArkUI functions across different platforms. Related test suites are all migrated from the OpenHarmony [acts](https://gitee.com/openharmony/xts_acts/tree/master/arkui) repository.

## About XTS Porting

XTS porting is the same as application porting. You need to build the XTS project into a JSBundle and place the JSBundle into the project directory of the corresponding platform. For example, if you place the JSBundle in the **assets** directory of Android, **aboutToAppear** will be called back to trigger test case execution when the application is started.

## Directory Structure

```
├── OAT.xml             # OAT file
└── android             # XTS test cases for the Android platform
     └── xts_2.0        # XTS test cases for the ArkUI declarative paradigm
```

## Test Case Execution

### Android Platform

#### Environment Configuration

If you are using Ubuntu and connecting it to a real Android phone through a USB cable, skip this step. The following procedure assumes that the Windows environment is connected to a Linux server or VM, and a real Android device is directly connected to the Windows environment through a USB port. Therefore, ADB port distribution needs to be enabled to ensure that the Linux server or VM can be connected to the Android real device through the ADB port.

* Obtain **adbportforward** and place it on Windows and Linux respectively.
```
git clone https://github.com/p2401kumar/AdbPortForward.git
```

* Windows configuration

Decompress **adbportforward** on Windows and create a batch processing script in the **lib** directory. The script content is as follows:
```
java -jar adbportforward.jar server adblocation=path/to/adb
pause
```
Run this script.

* Linux configuration

Decompress the **adbportforward** package on Linux, and create a shell script in the **lib** directory. The script content is as follows:
```
java -jar adbportforward.jar client adblocation=path/to/adb remotehost=192.168.0.159

```
Run this script. Then, create a terminal window, and access the Android device through the ADB port.

#### Execution

Go to the **android/xts_2.0** directory and run the following command to execute a single test suite:

```
./run.sh {Module name}
```

## Follow-up Plan

1. OpenHarmony XTS introduces a new test framework, where TestRunner is provided as an ability and test cases are started in TestRunner. The new test framework needs to be adapted to cross-platform projects.

2. Currently, execution results can only be viewed from logs. Visual reports need to be provided in the future.
