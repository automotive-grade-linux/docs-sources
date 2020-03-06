# 1. Download or Build Your Image #

You need to have an image that you can run on your hardware device.
You can either build that image from scratch or, if you are going to use
hardware supported by AGL, you can download a ready-made image from the
[AGL Download Website](https://download.automotivelinux.org/AGL/release/) site.

## Downloading an image ##

For a look at the supported images, go to the
[AGL Download Website](https://download.automotivelinux.org/AGL/release/).
You can explore that hierarchy and locate images based on the AGL release and the supported hardware.

The following list summarizes the pre-built image support:

* **[Quick EMUlator (QEMU)](https://www.qemu.org/):**
QEMU is a generic, open source machine emulator and virtualizer.
You can use QEMU as your "hardware" when you run an image built for
the emulator.
AGL supports QEMU images for ARM 32/64bit and Intel 64bit
devices.

* **[R-Car Gen3 Ultra Low-Cost Board](https://www.elinux.org/R-Car/Boards/M3SK , https://www.elinux.org/R-Car/Boards/H3SK):**
The M3ULCB/H3ULCB is a Renesas R-Car Gen3 SOC development board.
Depending on the SOC specialization, Renesas provides several classes
of these boards.
The "M" classification is for the "middle-end" version as compared to the
"H" classification, which is a "high-end" version.

* **[Raspberry Pi 4](https://www.raspberrypi.org/products/):**
The Raspberry Pi 4 uses a 64-bit quad-core processor.
The board features dual-band wireless LAN, Bluetooth 4.2/BLE,
faster Ethernet, and Power-over-Ethernet support with separate PoE HAT.

* **[x86-64]:**
Any x86-64 hardware is supported. We recommend e.g. the Up² board.

* **[DRA7xx Evaluation Module Platform](http://www.ti.com/tool/J6EVM5777):**
Texas Instruments Jacinto™ DRA7xx evaluation module platform helps speed up
development efforts and reduces time-to-market for applications
such as infotainment, reconfigurable digital cluster, or integrated digital
cockpit.



If you want to use QEMU or you are developing an application for one the
supported hardware board types, you might consider skipping the build
step, which is described below, and just download your image.

As an example, suppose you want to download the 64-bit ARM-based image
that you can emulate using QEMU.
Go to the [AGL Download Website](https://download.automotivelinux.org/AGL/release/)
site and follow these links:

```
icefish -> 9.0.0 -> qemuarm64 -> deploy -> images -> qemuarm64
```

From the list, you could download the ``Image-qemuarm64.bin`` Kernel and the 
``agl-demo-platform-crosssdk-qemuarm64.ext4.xz``Image file.


## Building an image ##

Building the image from scratch requires system preparation, build configuration, and then the build itself.
Building an image for the first time can take many hours.

The following procedure describes how to build your image:

1. **Prepare Your System:**  Your system, known as a "build host" needs to meet some requirements
   in order to build images in the AGL environment.
   The "[Preparing Your Build Host](./image-workflow-prep-host.html)"
   section describes in detail how to make sure your system meets
   these requirements.

   In summary, do the following to prepare your system:

   * Be sure that your build system runs a modern version of a supported Linux Distribution.
     For a list of supported distributions, see the
     "[Supported Linux Distributions](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#detailed-supported-distros)"
     section in the Yocto Project Reference Manual.

     **NOTE:** Building images using AGL software leverages off the
     [Yocto Project](https://www.yoctoproject.org/), which is an Open Source project used to create small, embedded distributions.

   * Be sure that you have updated versions of Tar, Git, Python, and the GNU Compiler Collection (GCC).

   * Install required packages on the build host.
     This list of packages depends on the particular Linux Distribution your build host uses.
     See the
     "[Preparing Your Build Host](./image-workflow-prep-host.html)"
     section for the packages you need to install for your specific
     distribution.

     **NOTE:** The definitive package requirements are documented in the
     "[Required Packages for the Host Development System](https://yoctoproject.org/docs/latest/ref-manual/ref-manual.html#required-packages-for-the-host-development-system)"
     section of the Yocto Project Reference Manual.

2. **Download the AGL source code:** Getting the AGL source code involves creating an
   isolated work directory, securing the "repo" tool, and finally
   using Git to download the source code into a cloned local repository.

   Be sure to consider the source code version before downloading the source.
   If you want the cutting edge version of the AGL source code, download the "master" branch.
   Otherwise, download the latest stable AGL release.

   You can see example steps in the
   "[Download AGL source code](./image-workflow-download-sw.html)"
   section.

3. **Initialize the build environment:** The build process assumes many environment
   variable settings, tools, tool locations, and file hierarchies.
   Once the AGL software is on your local system, you need to run the build
   setup script (i.e. ``aglsetup.sh``) to establish environment variables
   and paths used during the build process.

   Because the script accepts options that define the features used in your
   build environment, you need to understand what features you want
   before running the script.
   For information on running the script and on the features you can choose,
   see the
   "[Initializing Your Build Environment](./image-workflow-initialize-build-environment.html)"
   section.

4. **Customize your build configuration:** Aside from environment variables
   and parameters, build parameters and variables need to be defined before
   you start the build process.
   These parameters (configurations) are defined in the ``local.conf``
   configuration file.
   In general, the defaults in that file are good enough.
   However, you can customize aspects by editing the ``local.conf`` file.
   See the
   "[Customizing Your Build](./image-workflow-cust-build.html)"
   section for the location of the file and a list of common customizations.

   **NOTE:** For detailed explanations of the configurations you can make
   in the ``local.conf`` file, consult the
   [Yocto Project Documentation](https://www.yoctoproject.org/docs/).

5. **Building the image:** You use
   [BitBake](https://yoctoproject.org/docs/2.4.4/bitbake-user-manual/bitbake-user-manual.html)
   to build the image.
   BitBake is the engine used by the Yocto Project when building images.
   The command used to build the image is ``bitbake``.

   For example, the following command builds the image for the AGL demo platform,
   which is an image you can emulate using QEMU:

   ```
   $ bitbake agl-demo-platform
   ```

   As previously mentioned, building a new image can take a long time.
   An initial build could take hours.
   Once the image has been initially built, re-builds are much quicker as
   BitBake takes advantage of cached artifacts.

   The build image resides in the deployment area of the build directory.
   For example, Assuming your top-level AGL directory is ``~/workspace_agl``, you find the image here:

   ```
   ~/workspace_agl/build/tmp/deploy/images/qemux86-64/
   ```
