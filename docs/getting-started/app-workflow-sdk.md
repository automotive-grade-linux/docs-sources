# 2. Download or Build Your SDK Installer #

The Software Development Kit (SDK) allows you to use your build host
to develop an application specific to your target hardware.
SDKs are installed onto your build host by running an SDK installer
file (``*.sh``).

You must either download a pre-built installer file for your SDK or
build an installer file.
If you are developing an application for a board supported by the AGL software, you might
want to just download a pre-built SDK installer file.
If your hardware is not supported by AGL, you need to build the SDK installer file.

## Downloading a pre-built SDK Installer ##

For a look at the SDK installers for supported boards, go to the
[AGL Download Website](https://download.automotivelinux.org/AGL/release/).
From there, you can explore to find the SDK installer you want to download.
As an example, consider using a pre-built SDK to develop applications suited for a 64-bit
ARM-based board that you want to emulate using QEMU.
Furthermore, you are using the 6.0.0 "Flounder" release of the AGL software.
Follow these links:

```
flounder -> 6.0.0 -> qemuarm64 -> deploy -> sdk
```

From the list, you download the ``*.sh`` file, which is an installation script for the SDK.
Running the SDK installer script installs the SDK onto your build host.

SDK installation scripts have long names that reflect the platform specifics.
For example, the following file installs the SDK given the specifics earlier:

``poky-agl-glibc-x86_64-agl-demo-platform-crosssdk-armv7vehf-neon-vfpv4-toolchain-6.0.0.sh``

**NOTE:** If you want to know more about SDK installer file naming, which is a result of
BitBake and the Yocto Project, see the
"[Locating Pre-Built SDK Installers](https://yoctoproject.org/docs/2.4.4/sdk-manual/sdk-manual.html#sdk-locating-pre-built-sdk-installers)"
section in the Yocto Project documentation.

## Building an SDK Installer ##

If you cannot find a pre-built SDK installer for your hardware, you need to build one.
In this case, use BitBake in a similar manner used to build the image.
See the
"[Building an image](./app-workflow-image.html#building-an-image)"
section for information on building an image with BitBake.

The only difference between building the image and the SDK installer
is the target you give BitBake on the command line and the final location of
the ``*.sh`` file.
Following is the command that you use to build the SDK installer for ``agl-demo-platform``:

```
$ bitbake agl-demo-platform-crosssdk
```

The SDK installer file (``*.sh``) is placed in the build directory.
Assuming your top-level workspace is ``~/workspace_agl``, here is an example location
and SDK installer file:

```
~/workspace_agl/build/tmp/deploy/sdk/poky-agl-glibc-x86_64-core-image-minimal-cortexa15hf-neon-toolchain-3.0.0+snapshot.sh
```
