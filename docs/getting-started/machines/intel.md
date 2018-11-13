# Building for Most Intel 64-Bit Hardware Platforms

Although the reference hardware used by the AGL Project is the 64-bit Open Source MinnowBoard,
you can use the information found on the "[MinnowBoard wiki](https://minnowboard.org/)"
to enable most 64-bit Intel Architecture (IA) platforms that use the 64-bit
UEFI as the boot loader.
In addition to the MinnowBoard, support for the
[upCore & UpSquared boards](http://www.up-board.org/upsquared/) exists.
MinnowBoard Max and Turbot as well as Joule are both 64-bit capable.

If you are interested in creating ***applications*** to run on hardware booted
using an image built with the AGL Project, see the following:

* [Application Development Workflow](../../../app-workflow-intro.html/overview)
* [Developing Apps for AGL](https://wiki.automotivelinux.org/agl-distro/developer_resources_intel_apps)

UEFI has significantly evolved and you will likely want to check that your hardware's
firmware is up-to-date.
You should make this check for both the MinnowBoard-Max and the Joule platforms.
You do not need to make this check for the MinnowBoard-Turbo and Up platforms:

* [`https://firmware.intel.com/projects/minnowboard-max`](https://firmware.intel.com/projects/minnowboard-max)
* [`https://software.intel.com/en-us/flashing-the-bios-on-joule`](https://software.intel.com/en-us/flashing-the-bios-on-joule)

## 1. Making Sure Your Build Environment is Correct

The
"[Initializing Your Build Environment](../../../image-workflow-initialize-build-environment.html/Initializing-your-build-environment)"
section presented generic information for setting up your build environment
using the `aglsetup.sh` script.
If you are building for an Intel 64-bit platform, you need to specify some
specific options when you run the script:

```bash
$ source meta-agl/scripts/aglsetup.sh \
    -m intel-corei7-64 \
    agl-devel agl-demo agl-appfw-smack agl-netboot agl-audio-4a-framework
```

The "-m" option specifies the "intel-corei7-64" machine.
If you were building for a Joule developer kit, you would use the
"-m joule" option.

The list of AGL features used with script are appropriate for the AGL demo image suited
for the Intel 64-bit target.
The "agl-netboot" option creates the correct Initial RAM Filesystem (initramfs)
image even if you do not boot from a network.

## 2. Using BitBake

This section shows the `bitbake` command used to build the AGL image.
Before running BitBake to start your build, it is good to be reminded that AGL
does provide pre-built images for developers that work with supported hardware.
You can find these pre-built images on the
[AGL Download web site](https://download.automotivelinux.org/AGL/release).

For supported Intel images, the filenames have the following form:

```
<release-name>/<release-number>/intel-core17-64/deploy/images/intel-core17-64/bzImage-intel-corei7-64.bin
```

Start the build using the `bitbake` command.
**NOTE:** An initial build can take many hours depending on your
CPU and and Internet connection speeds.
The build also takes approximately 100G-bytes of free disk space.

For this example, the target is "agl-demo-platform":

```bash
  bitbake agl-demo-platform
```

The build process puts the resulting image in the Build Directory:

```
<build_directory>/tmp/deploy/images/intel-corei7-64/
```

**WRITER NOTE:** I am not sure what to do with the following information:

An alternative method for building an image is to use the AGL SDK delivered in a Docker container.

There is currently no SDK dedicated to IA but the SDK provided for the Porter Board can build an IA image without changes (just `aglsetup.sh` needs to call for Intel).

See chapter 2 of [Porter QuickStart](http://iot.bzh/download/public/2016/sdk/AGL-Kickstart-on-Renesas-Porter-board.pdf "wikilink").

## 3. Creating Bootable Media

Depending your target hardware you will use an USB stick, an SD card or a HDD/SDD.
The creation process remains the same independently of the selected support.
It does require to have access to a Linux machine with `sudo` or root password.

Create a bootable SD card with the script [mkefi-agl.sh](https://gerrit.automotivelinux.org/gerrit/gitweb?p=AGL/meta-agl.git;a=blob_plain;f=scripts/mkefi-agl.sh;hb=HEAD)
check the available options with the -v option. mkefi-agl.sh -v

1. **Insert Media Device:**
   Insert your removable media into the corresponding interface.

2. **Determine the Name of Your Media Device:**
   Use the `lsblk` command to make sure you know the name of the device to which you will be writing.

   ```bash
     lsblk
     # You want the name of the raw device and not the name of a partition on the media.
     #(e.g. /dev/sdc or /dev/mmcblk0)
   ```

3. **Download the `mkefi-agl.sh` Script:**
   You can find the script in the "meta-agl/scripts" folder of your AGL source files.

   Alternatively, you can download the script from the following Git repository:

   [https://github.com/dominig/mkefi-agl.sh](https://github.com/dominig/mkefi-agl.sh)

4. **Create Your Bootable Media:**
   Run the following to see `mkefi-agl.sh` usage information:

   ```bash
     ./mkefi-agl.sh -v
   ```

   Supply the name of your actual image and device name and run the script.
   The following example assumes a USB device (e.g. `/dev/sdb`) and the image
   `intel-corei7-64.hdd`:

   ```bash
   $ sudo ./mkefi-agl.sh intel-corei7-64.hdd /dev/sdb
   # /dev/sdX is common for USB stick where "X" is "b".
   # /dev/mmcblk0 is common for an integrated SD card reader in a notebook computer.
   ```

## 4. Booting the Image on the Target Device

Follow these steps to boot your image on the target device:

1. Insert the bootable media that contains the AGL image into the target device.

2. Power on the device.

3. As the device boots, access the boot option screen.
   You generally accomplish this with the F12 key during the power up operation.

4. From the boot option screen, select your bootable media device.

5. Save and exit the screen and let the device boot from your media.

   **NOTE:**: Depending on the speed of your removable media, the first boot might
   not complete.
   If this is the case, reboot the device a second time.
   It is common with USB sticks that you need to boot a couple of times.

   For Intel devices, the serial console is configured and activated at the rate of 115200 bps.
