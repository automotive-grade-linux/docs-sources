# Building for Most Intel 64-Bit Hardware Platforms

Most 64-bit capable x86 hardware will run AGL just fine (e.g. Laptop w/ touchscreen).
For development, we recommend the
[upCore & UpSquared boards](http://up-board.org/upsquared/specifications/).

If you are interested in creating ***applications*** to run on hardware booted
using an image built with the AGL Project, see the following:

* [Application Development Workflow](../app-workflow-intro.html)
* [Developing Apps for AGL](https://wiki.automotivelinux.org/agl-distro/developer_resources_intel_apps)

UEFI has significantly evolved and you should check that your hardware's
firmware is up-to-date.

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
    agl-devel agl-demo agl-netboot
```

The "-m" option specifies the "intel-corei7-64" machine.

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
<release-name>/<release-number>/intel-corei7-64/deploy/images/intel-corei7-64/agl-demo-platform-crosssdk-intel-corei7-64.wic.xz
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


## 3. Creating Bootable Media

Typically, you use a USB stick, SD card, or HDD/SDD to create bootable media.
It is possible, however, to install the AGL image onto Embedded MultiMediaCard
(eMMC).
eMMC provides card longevity at a low cost and is used in automotive infotainment
systems, avionics displays, and industrial automation/HMI control applications
to name a few.

You can write the `wic.xz` image after extraction with `dd` or `etcher`.
Or you use `bmaptool` which does not require extraction.

Note: for `bmaptool`, also download the `.wic.bmap` file as well.

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
By default, when you build an AGL image for an Intel target, the serial debug
ports are as follows:

* Up boards the `/dev/ttyS0` serial port is difficult to access.
  Using `/dev/ttyS4` is preferred, which is routed on the Arduino
  connector.
  See the [Up2 Pin Specification]( http://www.up-board.org/wp-content/uploads/2017/11/UP-Square-DatasheetV0.5.pdf)
  for more information.

Depending on your particular hardware, you might need to change the
configuration in your bootloader, which is located in the EFI partition.

### Serial Debug Cable

Most development boards use a standard serial debug cable (e.g. 3.3V FTDI serial cable).
Up Boards use the same FTDI 3.3V adapter.
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

