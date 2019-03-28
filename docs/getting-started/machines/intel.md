# Building for Most Intel 64-Bit Hardware Platforms

Although the reference hardware used by the AGL Project is the 64-bit Open Source MinnowBoard,
you can use the information found on the "[MinnowBoard wiki](https://minnowboard.org/)"
to enable most 64-bit Intel Architecture (IA) platforms that use the 64-bit
UEFI as the boot loader.
In addition to the MinnowBoard, support for the
[upCore & UpSquared boards](http://up-board.org/upsquared/specifications/) exists.
MinnowBoard Max and Turbot are both 64-bit capable.

If you are interested in creating ***applications*** to run on hardware booted
using an image built with the AGL Project, see the following:

* [Application Development Workflow](../app-workflow-intro.html)
* [Developing Apps for AGL](https://wiki.automotivelinux.org/agl-distro/developer_resources_intel_apps)

UEFI has significantly evolved and you should check that your hardware's
firmware is up-to-date.
You must make this check for MinnowBoard-Max platforms.
You do not need to make this check for the MinnowBoard-Turbo, upCore, and UpSquared
platforms:

* [`https://firmware.intel.com/projects/minnowboard-max`](https://firmware.intel.com/projects/minnowboard-max)
* Intel automotive Module Reference Board (MRB)

  **NOTES:** By default, these MRBs ship with an Automotive
  Fast Boot loader (ABL), which requires encrypted images.
  You can ask Intel's "Engineering Sales support" for a special version
  of the MRB that does not require an encrypted image.
  You need this type of MRB in order to test AGL on the development board.
  Contact your Intel technical support representative to get the non-signed
  ABL firmware.


## 1. Making Sure Your Build Environment is Correct

The
"[Initializing Your Build Environment](../image-workflow-initialize-build-environment.html)"
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

An alternative method for building an image is to use the AGL SDK delivered in a Docker container.

There is currently no SDK dedicated to IA but the SDK provided for the Porter Board can build an IA image without changes (just `aglsetup.sh` needs to call for Intel).

See chapter 2 of [Porter QuickStart](http://iot.bzh/download/public/2016/sdk/AGL-Kickstart-on-Renesas-Porter-board.pdf "wikilink").

## 3. Creating Bootable Media

Typically, you use a USB stick, SD card, or HDD/SDD to create bootable media.
It is possible, however, to install the AGL image onto Embedded MultiMediaCard
(eMMC).
eMMC provides card longevity at a low cost and is used in automotive infotainment
systems, avionics displays, and industrial automation/HMI control applications
to name a few.

When creating bootable media,
[Extended Attributes (`xattrs`)](https://linux-audit.com/using-xattrs-extended-attributes-on-linux/)
are required for use with
[Smack](https://en.wikipedia.org/wiki/Smack_(software)).
This section describes using the `mkabl-agl.sh` or `mkefi-agl.sh` scripts
to create bootable media.
Use of either of these scripts include all required `xattrs`.

**NOTE:** You can find detailed information on Smack at
  [https://www.kernel.org/doc/Documentation/security/Smack.txt](https://www.kernel.org/doc/Documentation/security/Smack.txt).

While the `mkabl-agl.sh` or `mkefi-agl.sh` scripts are recommended for creating
your bootable media for Intel devices, other methods exist.
If you use an alternative method (e.g. `tar`), be sure you take steps to copy
`xattrs` as part of the image.
See the
"[Including Extended Attributes](../troubleshooting.html#including-extended-attributes)"
section for more information.

### USB Stick, SD Card, and HDD/SDD

Depending on your target hardware, use a USB stick, an SD card, or an HDD/SDD.
The creation process remains the same independently of the selected support.
It does require to have access to a Linux machine with `sudo` or root password.

Create a bootable SD card with the script [`mkefi-agl.sh`](https://gerrit.automotivelinux.org/gerrit/gitweb?p=AGL/meta-agl.git;a=blob_plain;f=scripts/mkefi-agl.sh;hb=HEAD).
Use the "-v" option to check the available options.

**NOTE:** If you are using an Intel Module Reference Board (MRB), you need to
  use the
  [`mkabl-agl.sh`](https://gerrit.automotivelinux.org/gerrit/gitweb?p=AGL/meta-agl.git;a=blob_plain;f=scripts/mkefi-agl.sh;hb=HEAD)
  script instead of the `mkefi-agl.sh` script.

Follow these steps to create your bootable media:

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

### Embedded MultiMediaCard (eMMC)

It is possible to install the AGL image directly on the internal eMMC
rather than a removable device such as a USB stick or SD card.
To do so, requires the following steps:

1. **Add Required Tools to Your AGL Image:**

   Add a file named `site.conf` in your `build/conf` directory.
   Make sure the file has the following content:

   ```
   INHERIT += "rm_work"
   IMAGE_INSTALL_append = " linux-firmware-iwlwifi-7265d"
   IMAGE_INSTALL_append = " parted e2fsprogs dosfstools"
   IMAGE_INSTALL_append = " linux-firmware-i915 linux-firmware-ibt linux-firmware-iwlwifi-8000c"
   ```
   In addition to the previous statements, you need to add the
   Intel Wireless WiFi Link (`iwlifi`) driver for your own device
   as needed.

2. **Rebuild Your Image**

   Rebuild the AGL image by following the instructions in the
   "[Using BitBake](../machines/intel.html#2-using-bitbake)"
   step of this page.

3. **Install the Rebuilt Image Onto a Removable Device**

   Follow the steps previously described here to copy the new
   image onto a removable device such as a USB stick.

4. **Copy the Image from the USB Stick to Your Build Host's Home Directory**

   Copy the image you just temporarily installed to the removable
   device to your build host's home directory.
   The process uses this image later for installation in the
   eMMC.
   For example, copy the image file created using the Yocto Project from
   the build directory to your home directory:

   ```bash
   $ cp build/tmp/deploy/images/intel-corei7-64/agl-demo-platform-intel-corei7-64.wic.xz ~/
   ```

5. **Boot the AGL Image from the Removable Device**

   You can see how to boot the image on the target device by
   following the procedure in the next section.

6. **Connect to Your Device that is Running the Image**

   You need to use a Serial Link or SSH to connect to the device running
   your image.

7. **Determine the eMMC Device Name**

   Be sure you know the name of the eMMC device.
   Use the `lsblk` command.

8. **Install the Image into the eMMC**

   Use the `mkefi-agl.sh` Script to install the image into the eMMC.

   ```
   cat /proc/partitions
   ```
9. **Remove the USB or SD Boot Device**

   Once your image is running on the booted device, you can remove the
   media used to boot the hardware.

10. **Reboot Your Device**

    Cycle through a reboot process and the device will boot from the
    eMMC.

## 4. Booting the Image on the Target Device

Be aware of the following when booting your device:

* Interrupting the boot process is easier to achieve when
  using a USB keyboard as opposed to a serial link.

* During the boot process, USB hubs are not supported.
  You need to connect any USB keyboard directly to your device's
  USB socket.

* It is recommended that you use F9 to permanently change the boot
  order rather than interrupt the process for each subsequent boot.
  Also, you must have your bootable media plugged in or connected
  to the target device before you can permanently change the boot
  order.

* Booting from an SD card is faster as compared to booting from
  a USB stick.
  Use an SD card for better boot performance.

* The MinnowBoard, many laptops, and NUC devices do not accept
  USB3 sticks during the boot process.
  Be sure your image is not on a USB3 stick.

Use these steps to boot your device:

1. Insert the bootable media that contains the AGL image into the target device.

2. Power on the device.

3. As the device boots, access the boot option screen.
   You generally accomplish this with the F12 key during the power up operation.

   **NOTE:** When booting a MinnowBoard, you can change the default boot
   device by hitting F2 during initial UEFI boot.

4. From the boot option screen, select your bootable media device.

5. Save and exit the screen and let the device boot from your media.

   **NOTE:**: Depending on the speed of your removable media, the first boot might
   not complete.
   If this is the case, reboot the device a second time.
   It is common with USB sticks that you need to boot a couple of times.

   For Intel devices, the serial console is configured and activated at the rate of 115200 bps.

## 5. Miscellaneous Information

Following is information regarding serial debug ports, serial cables, and
port names for connected displays.

### Serial Debug Port

Serial debug port IDs vary across hardware platforms.
By default, when you build an AGL image for an Intel target such as the
Minnowboard, Module Reference Board (MRB), or Up board, the serial debug
ports are as follows:

* MinnowBoard uses `/dev/ttyS0`
* MRB uses `/dev/ttyS2`
* Up boards the `/dev/ttyS0` serial port is difficult to access.
  Using `/dev/ttyS4` is preferred, which is routed on the Arduino
  connector.
  See the [Up2 Pin Specification]( http://www.up-board.org/wp-content/uploads/2017/11/UP-Square-DatasheetV0.5.pdf)
  for more information.

Depending on your particular hardware, you might need to change the
configuration in your bootloader, which is located in the EFI partition.

### Serial Debug Cable

On the MinnowBoard, the serial debug cable is an FTDI serial cable.
You can learn more [here](https://minnowboard.org/tutorials/best-practice-serial-connection).

Up Boards use the same FDDI 3.3V adapter as does the MinnowBoard.
However, the pin out is not adjacent and requires split pins.

### Port Names and Connected Displays

Port naming can change across hardware platforms and connected displays.
The simplest way to determine the port name used for a connected display
is to check the after the initial boot process completes.
You can make this check in the `systemd` journal as follows:

```bash
$ journalctl | grep Output
```

**NOTE:** Output for the
[`journalctl`](https://www.freedesktop.org/software/systemd/man/journalctl.html)
command generates only when a real display is connected to the connector on the board.
The file holding that configuration is `/etc/xdg/weston/weston.ini`.

Common Display names for Intel platforms are the following:

* `HDMI-A-1`
* `HDMI-A-2`
* `LVDS-1`

