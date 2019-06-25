# AGL Kickstart on Renesas R-Car Starter Kit Gen3 (h3ulcb, m3ulcb, salvator-x(optional))

## Prerequisites

* At this step, you are assumed to have downloaded the [AGL source code](/docs/getting_started/en/dev/reference/source-code.html).

See the related paragraph if not done yet.

* For creating the microSD card, you will need **bmaptool**

There are pre-built packages (.deb or .rpm) for the supported host OSes, available at [this location](
https://build.opensuse.org/package/show/isv:LinuxAutomotive:AGL_Master/bmap-tools)

## Hardware

Here is a non exhaustive list of hardware parts that could be used to setup the R-Car Starter Kit Gen3 board development environment:

* Starter Kit Gen3 board with its 5V power supply
* micro USB-A cable for serial console (optional if using ethernet and ssh connection)
* USB 2.0 Hub (optional)
* Ethernet cable (optional if using serial console)
* HDMI type D (Micro connector) cable and associated display
* micro-SD Card (at least 4GB) and recommend to use class 10 type.
* USB touch screen device like the GeChic 1502i/1503i (optional)

For more information and latest news, please check :

* [elinux page for h3ulcb][R-car h3ulcb]
* [elinux page for m3ulcb][R-car m3ulcb]
* [elinux page for salvator-x][R-car salvator-x]

Infotainment Carrier Board :

* [elinux page for Kingfisher][R-car Kingfisher]

**Note**:That the Salvator-X has NDA restrictions, so less documentation is available both here and elsewhere.

The following documents may also be helpful:

* [Yocto-Gen3 on elinux][R-car yocto]

## BSP Version of R-Car Starter Kit Gen3

<!-- SPEC-2253 (gfx drivers copied from 3.19 on top of 3.15) - FIXME -->
| AGL Version| Renesas version |
|:-:|:-:|
| AGL master  | 3.15.0 (+ Gfx libs from 3.19.0) |
| AGL 7.0.0  | 3.9.0 |
| AGL 6.0.0 | 3.7.0 |
| AGL 5.0.x, 5.1.0| 2.23.1 |
| AGL 4.0.x |2.19.0 |

## Building the AGL Demo Platform for R-Car Starter Kit Gen3

Before setting up the build environment, you need to download the proprietary drivers.

* The version of the drivers you need can be displayed this way:

```bash
grep -rn ZIP_.= $AGL_TOP/meta-agl/meta-agl-bsp/meta-rcar-gen3/scripts/setup_mm_packages.sh
```

* Download Renesas graphics drivers with a "click through" license from [Renesas website][rcar Linux Drivers 2]
  * Under the Target hardware: **R-Car H3/M3** section.

**Note**:

* You have to register with a free account on MyRenesas and accept the license conditions before downloading the drivers.
 The operation is fast and simple nevertheless mandatory to access evaluation of non open-source drivers for free.
 Once you registered, you can download two zip files.
* It is recommended to store these drivers into your download directory (usually $HOME/Downloads, pointed by $XDG_DOWNLOAD_DIR in some OS).
  * To avoid any errors, check that $XDG_DOWNLOAD_DIR is set to the directory where the drivers are stored, if not, set it using 'export' command
* Be sure to have the need rights for these files using :

```bash
chmod a+r $XDG_DOWNLOAD_DIR/*.zip
```

* Check that the needed drivers files are found using :

```bash
ls -1 $XDG_DOWNLOAD_DIR
[master]
-rw-r--r--. 1 1664 agl-sdk 5.0M Jun 28 15:23 R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20190212.zip
-rw-r--r--. 1 1664 agl-sdk 3,1M Jun 28 15:24 R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20190212.zip

[Guppy]
-rw-r--r--. 1 1664 agl-sdk 4.9M Apr 24 15:23 R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20180627.zip
-rw-r--r--. 1 1664 agl-sdk 3,0M Apr 24 15:24 R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20180627.zip

[Flounder]
-rw-r--r--. 1 1664 agl-sdk 4.9M Apr 24 15:23 R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20180627.zip
-rw-r--r--. 1 1664 agl-sdk 3,0M Apr 24 15:24 R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20180627.zip

[Eel]
-rw-r--r--. 1 1664 agl-sdk 4.5M Dec  8 15:23 R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-weston2-20170904.zip
-rw-r--r--. 1 1664 agl-sdk 3,0M Dec  8 15:24 R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-weston2-20170904.zip
```

### Setting up the build environment

Define the type of R-Car Starter Kit board as a variable:

* for machine **h3ulcb** (Starter Kit Premier/H3) :

```bash
export MACHINE=h3ulcb
```

* for machine **m3ulcb** (Starter Kit Pro/M3):

```bash
export MACHINE=m3ulcb
```

* for machine **h3-salvator-x**:

```bash
export MACHINE=h3-salvator-x
```

Now, init your build environment:

```bash
cd $AGL_TOP
source meta-agl/scripts/aglsetup.sh -m $MACHINE -b build agl-devel agl-demo agl-netboot agl-appfw-smack agl-localdev
```

**IMPORTANT NOTE**: Read the log to be sure you had no error during your setup.

In case of missing graphics drivers, you could notice an error message as follow:

```bash
[snip]
--- fragment /home/working/workspace_agl_master/meta-agl/templates/machine/h3ulcb/50_setup.sh
/home/working/workspace_agl_master /home/working/workspace_agl_master/build_gen3
The graphics and multimedia acceleration packages for
the R-Car Gen3 board can be downloaded from:
 https://www.renesas.com/en-us/solutions/automotive/rcar-demoboard-2.html

These 2 files from there should be store in your'/home/devel/Downloads' directory.
  R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-weston2-20190212.zip
  R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-weston2-20190212.zip
/home/working/workspace_agl_master/build_gen3
--- fragment /home/working/workspace_agl_master/meta-agl/templates/base/99_setup_EULAconf.sh
--- end of setup script
OK
Generating setup file: /home/working/workspace_agl_master/build_gen3/agl-init-build-env ... OK
------------ aglsetup.sh: Done
[snip]
```

If you encounter this issue, or any other unwanted behavior, you can fix the error mentioned and then clean up by removing the “$AGL_TOP/build” directory then re-launch the procedure again.

In any case, you can find out more information for the reason of the error in this file:

```bash
[snip]

~/workspace_agl/build/conf $ cat setup.log
--- beginning of setup script
--- fragment /home/thierry/workspace_agl/meta-agl/templates/base/01_setup_EULAfunc.sh
--- fragment /home/thierry/workspace_agl/meta-agl/templates/machine/m3ulcb/50_setup.sh
~/workspace_agl ~/workspace_agl/build
ERROR: FILES "+/home/thierry/Downloads/R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20190212.zip+" NOT EXTRACTING CORRECTLY
ERROR: FILES "+/home/thierry/Downloads/R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20190212.zip+" NOT EXTRACTING CORRECTLY
The graphics and multimedia acceleration packages for
the R-Car Gen3 board BSP can be downloaded from:
<https://www.renesas.com/us/en/solutions/automotive/rcar-download/rcar-demoboard-2.html>

These 2 files from there should be stored in your
'/home/thierry/Downloads' directory.
  R-Car_Gen3_Series_Evaluation_Software_Package_for_Linux-20190212.zip
  R-Car_Gen3_Series_Evaluation_Software_Package_of_Linux_Drivers-20190212.zip
ERROR: Script /home/thierry/workspace_agl/build/conf/setup.sh failed
[snip]
```

After this command, the working directory is changed to $AGL_TOP/build.

If you do not want do this, another option is to add the '**-f**' option to agl_setup.sh.

Users may want to check that the board is correctly selected in the environment:

```bash
grep -w -e "^MACHINE =" $AGL_TOP/build/conf/local.conf
  MACHINE = "h3ulcb"
or
  MACHINE = "m3ulcb"
or
  MACHINE = "h3-salvator-x"
```

Configure for Release or Development:

* development images contain extra tools for developer convenience, in particular:
  * a debugger (gdb)
  * some tweaks, including a disabled root password
  * a SFTP server
  * the TCF Agent for easier application deployment and remote debugging
  * some extra system tools (usb, bluetooth ...)
  * ...

We explicitely activate these debug facilities by specifying the “agl-devel agl-netboot” feature.

### Build your image

The process to build an image is simple:

```bash
bitbake agl-demo-platform
```

You may need to install rpcgen to run this command.

When finished (it may take few hours), you should get the final result:

```bash
ls -l $AGL_TOP/build/tmp/deploy/images/$MACHINE
```

**Note**:

In case of failure of the build it is safe to first check that the Linux distribution chosen for your host has been validated for the current version of Yocto used by AGL.

## Booting AGL Image on R-Car Starter Kit Gen3 boards using a microSD card

To boot the board using a micro-SD card, there are two operations that must be done prior to first initial boot:

* Update all firmware on the device.
* Set up the board to boot on the SD-card.

For each subsequent build you only need to rewrite the SD-card with the new image.

### Firmware Update

This procedure is done in two steps. The 'Sample Loader and MiniMonitor update' step only needs to be done once per device. The 'Firmware stack update' step is mandatory only if you use AGl Eel (version 5.0) or later.

#### Sample Loader and MiniMonitor update

Follow the documentation on the [eLinux.org wiki][R-car loader update] to update to at least version 3.02. This is mandatory to run AGL.

#### Firmware stack update

As an AArch64 platform, both **h3ulcb** and **m3ulcb** have a firmware stack divided in : **ARM Trusted Firmware**, **OP-Tee** and **U-Boot**.

If you use AGl Eel (version 5.0) or later, you must update the firmware using the following links to eLinux.org wiki: **[h3ulcb][R-car h3ulcb firmware update]** or **[m3ulcb][R-car m3ulcb firmware update]**.

The files listed in the eLinux.org wiki table will be found in the directory:

```bash
*\$AGL_TOP/build/tmp/deploy/images/$MACHINE*
```

The Salvator-X firmware update process is not documented on eLinux.

### Prepare the SD-card on the host

Plug the microSD card and get its associated device by either running *`dmesg | tail -15`* or *`lsblk`*, for example:

```bash
dmesg | tail -15

  [ 1971.462160] sd 6:0:0:0: [sdc] Mode Sense: 03 00 00 00
  [ 1971.462277] sd 6:0:0:0: [sdc] No Caching mode page found
  [ 1971.462278] sd 6:0:0:0: [sdc] Assuming drive cache: write through
  [ 1971.463870]  sdc: sdc1 sdc2
```

Here, the SD-card is attached to the device /dev/sdc.

```bash
lsblk

  NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
  sda      8:0    0 167,7G  0 disk
  ├─sda1   8:1    0   512M  0 part /boot/efi
  ├─sda2   8:2    0 159,3G  0 part /
  └─sda3   8:3    0   7,9G  0 part [SWAP]
  sdb      8:16   0 931,5G  0 disk
  └─sdb1   8:17   0 931,5G  0 part /media/storage
  sdc      8:32   1  14,9G  0 disk
  ├─sdc1   8:33   1    40M  0 part
  └─sdc2   8:34   1   788M  0 part
```

**IMPORTANT NOTE**: This is a critical operation, each computer is different and removable devices can change from time to time:
so you should repeat this operation each time you insert the microSD card to confirm the device name.

In the example above, we see:

* the first SATA drive as 'sda'.
* 'sdc' corresponds to the microSD card, and is also marked as removable device by *lsblk* which is a good confirmation.
* Your desktop system probably offers a choice to mount the SD-card automatically in some directory.
* In the next sample code, we'll suppose that the SD-card mount directory is stored in the variable $SDCARD.
* For example, if the microSD card is associated with device *sdc*:

Go to your build directory:

```bash
cd $AGL_TOP/build/tmp/deploy/images/$MACHINE
```

You can use bmaptool to copy the **.wic.xz** file to the storage device, discovered in the previous step:

```bash
bmaptool copy ./agl-demo-platform-$MACHINE.wic.xz $SDCARD
```

Or you can be uncompressed and written to the device:

```bash
  sudo umount /dev/sdc
  xzcat ./agl-demo-platform-$MACHINE.wic.xz | sudo dd of=$SDCARD bs=4M
  sync
```

### Booting the board

* Turn the board off using the power switch.
* Insert the microSD-card.
* Verify that you have plugged in, at least :
  * An external monitor on HDMI port
  * An input device (keyboard, mouse, touchscreen...) on USB port.

* Turn the board on using the power switch.
 After a few seconds, you'll see the AGL splash screen on the display and you'll be able to log in on the console terminal or in the graphic screen.

## Serial Console Setup

### Install a serial client on your computer

This can be “screen”, “picocom”, “minicom”.
The lighter of the 3 is “picocom” (it has less dependencies).

### Plug a USB cable from your computer to the serial CP2102 USB port (micro USB-A)

With “dmesg” you can check the device created for the serial link.
Usually, it's /dev/ttyUSB0 but the number may vary depending on other USB serial ports connected to the host.
To get it, you must switch the board on.
For example:

```bash
dmesg | tail
[2097783.287091] usb 2-1.5.3: new full-speed USB device number 24 using ehci-pci
[2097783.385857] usb 2-1.5.3: New USB device found, idVendor=0403, idProduct=6001
[2097783.385862] usb 2-1.5.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[2097783.385864] usb 2-1.5.3: Product: FT232R USB UART
[2097783.385866] usb 2-1.5.3: Manufacturer: FTDI
[2097783.385867] usb 2-1.5.3: SerialNumber: AK04WWCE
[2097783.388288] ftdi_sio 2-1.5.3:1.0: FTDI USB Serial Device converter detected
[2097783.388330] usb 2-1.5.3: Detected FT232RL
[2097783.388658] usb 2-1.5.3: FTDI USB Serial Device converter now attached to ttyUSB0
```

The link is attached to the device /dev/ttyUSB0.
It is time to launch your serial client.
Example:

```bash
picocom -b 115200 /dev/ttyUSB0
```

or

```bash
minicom -b 115200 -D /dev/ttyUSB0
```

or

```bash
screen /dev/ttyUSB0 115200
```

### Power on the board to see a shell on the console

* For machine h3ulcb:

```bash
NOTICE:  BL2: R-Car Gen3 Initial Program Loader(CA57) Rev.1.0.7
NOTICE:  BL2: PRR is R-Car H3 ES1.1
NOTICE:  BL2: LCM state is CM
NOTICE:  BL2: DDR1600(rev.0.15)
NOTICE:  BL2: DRAM Split is 4ch
NOTICE:  BL2: QoS is Gfx Oriented(rev.0.30)
NOTICE:  BL2: AVS setting succeeded. DVFS_SetVID=0x52
NOTICE:  BL2: Lossy Decomp areas
NOTICE:       Entry 0: DCMPAREACRAx:0x80000540 DCMPAREACRBx:0x570
NOTICE:       Entry 1: DCMPAREACRAx:0x40000000 DCMPAREACRBx:0x0
NOTICE:       Entry 2: DCMPAREACRAx:0x20000000 DCMPAREACRBx:0x0
NOTICE:  BL2: v1.1(release):41099f4
NOTICE:  BL2: Built : 19:20:52, Jun  9 2016
NOTICE:  BL2: Normal boot
NOTICE:  BL2: dst=0xe63150c8 src=0x8180000 len=36(0x24)
NOTICE:  BL2: dst=0x43f00000 src=0x8180400 len=3072(0xc00)
NOTICE:  BL2: dst=0x44000000 src=0x81c0000 len=65536(0x10000)
NOTICE:  BL2: dst=0x44100000 src=0x8200000 len=524288(0x80000)
NOTICE:  BL2: dst=0x49000000 src=0x8640000 len=1048576(0x100000)


U-Boot 2015.04 (Jun 09 2016 - 19:21:52)

CPU: Renesas Electronics R8A7795 rev 1.1
Board: H3ULCB
I2C:   ready
DRAM:  3.9 GiB
MMC:   sh-sdhi: 0, sh-sdhi: 1
In:    serial
Out:   serial
Err:   serial
Net:   Board Net Initialization Failed
No ethernet found.
Hit any key to stop autoboot:  0
=>
```

* For machine m3ulcb:

```
NOTICE:  BL2: R-Car Gen3 Initial Program Loader(CA57) Rev.1.0.14
NOTICE:  BL2: PRR is R-Car M3 Ver1.0
NOTICE:  BL2: Board is Starter Kit Rev1.0
NOTICE:  BL2: Boot device is HyperFlash(80MHz)
NOTICE:  BL2: LCM state is CM
NOTICE:  BL2: AVS setting succeeded. DVFS_SetVID=0x52
NOTICE:  BL2: DDR1600(rev.0.22)NOTICE:  [COLD_BOOT]NOTICE:  ..0
NOTICE:  BL2: DRAM Split is 2ch
NOTICE:  BL2: QoS is default setting(rev.0.17)
NOTICE:  BL2: Lossy Decomp areas
NOTICE:       Entry 0: DCMPAREACRAx:0x80000540 DCMPAREACRBx:0x570
NOTICE:       Entry 1: DCMPAREACRAx:0x40000000 DCMPAREACRBx:0x0
NOTICE:       Entry 2: DCMPAREACRAx:0x20000000 DCMPAREACRBx:0x0
NOTICE:  BL2: v1.3(release):4eef9a2
NOTICE:  BL2: Built : 00:25:19, Aug 25 2017
NOTICE:  BL2: Normal boot
NOTICE:  BL2: dst=0xe631e188 src=0x8180000 len=512(0x200)
NOTICE:  BL2: dst=0x43f00000 src=0x8180400 len=6144(0x1800)
NOTICE:  BL2: dst=0x44000000 src=0x81c0000 len=65536(0x10000)
NOTICE:  BL2: dst=0x44100000 src=0x8200000 len=524288(0x80000)
NOTICE:  BL2: dst=0x50000000 src=0x8640000 len=1048576(0x100000)


U-Boot 2015.04-dirty (Aug 25 2017 - 10:55:49)

CPU: Renesas Electronics R8A7796 rev 1.0
Board: M3ULCB
I2C:   ready
DRAM:  1.9 GiB
MMC:   sh-sdhi: 0, sh-sdhi: 1
In:    serial
Out:   serial
Err:   serial
Net:   ravb
Hit any key to stop autoboot:  0
=>
```

### Configure U-boot parameters

Follow the steps below to configure the boot from microSD card and to set screen resolution:

* Turn the board on using the power switch.
* Hit any key to stop autoboot (warning you have only few seconds).
* Type **printenv** to check if you have correct parameters for booting your board:
  * Example for a h3ulcb:

    ```
    => printenv
    baudrate=115200
    bootargs=console=ttySC0,115200 root=/dev/mmcblk1p1 rootwait ro rootfstype=ext4
    bootcmd=run load_ker; run load_dtb; booti 0x48080000 - 0x48000000
    bootdelay=3
    fdt_high=0xffffffffffffffff
    initrd_high=0xffffffffffffffff
    load_dtb=ext4load mmc 0:1 0x48000000 /boot/Image-r8a7795-h3ulcb.dtb
    load_ker=ext4load mmc 0:1 0x48080000 /boot/Image
    stderr=serial
    stdin=serial
    stdout=serial
    ver=U-Boot 2015.04 (Jun 09 2016 - 19:21:52)

    Environment size: 648/131068 bytes
    ```

  * Example for a m3ulcb:

    ```
    => printenv
    baudrate=115200
    bootargs=console=ttySC0,115200 root=/dev/mmcblk1p1 rootwait ro rootfstype=ext4
    bootcmd=run load_ker; run load_dtb; booti 0x48080000 - 0x48000000
    bootdelay=3
    fdt_high=0xffffffffffffffff
    filesize=cdeb
    initrd_high=0xffffffffffffffff
    load_dtb=ext4load mmc 0:1 0x48000000 /boot/Image-r8a7796-m3ulcb.dtb
    load_ker=ext4load mmc 0:1 0x48080000 /boot/Image
    stderr=serial
    stdin=serial
    stdout=serial
    ver=U-Boot 2015.04 (Nov 30 2016 - 18:25:18)

    Environment size: 557/131068 bytes
    ```

    * To boot on a sd card, it is recommended to set your environment using these commands :

    ```
    setenv bootargs console=ttySC0,115200 ignore_loglevel vmalloc=384M video=HDMI-A-1:1920x1080-32@60 root=/dev/mmcblk1p1 rw rootfstype=ext4 rootwait rootdelay=2
    ```
    ```
    setenv bootcmd run load_ker\; run load_dtb\; booti 0x48080000 - 0x48000000
    ```
    ```
    setenv load_ker ext4load mmc 0:1 0x48080000 /boot/Image
    ```

    * For machine h3ulcb (BSP >= 2.19):

    ```
    setenv load_dtb ext4load mmc 0:1 0x48000000 /boot/Image-r8a7795-es1-h3ulcb.dtb
    ```

    * For machine h3ulcb (BSP < 2.19):

    ```
    setenv load_dtb ext4load mmc 0:1 0x48000000 /boot/Image-r8a7795-h3ulcb.dtb
    ```

    * For machine m3ulcb:

    ```bash
    setenv load_dtb ext4load mmc 0:1 0x48000000 /boot/Image-r8a7796-m3ulcb.dtb
    ```

    * For machine m3ulcb with a kingfisher board:

    ```bash
    setenv load_dtb ext4load mmc 0:1 0x48000000 /boot/Image-r8a7796-m3ulcb-kf.dtb
    ```

    * For machine h3ulcb with a kingfisher board:

    ```bash
    setenv load_dtb ext4load mmc 0:1 0x48000000 /boot/Image-r8a7795-es1-h3ulcb-kf.dtb
    ```

    * Finally save boot environment:

    ```bash
    saveenv
    ```

* Now you can boot:

```
run bootcmd
```

### Console boot

After booting, you should see the wayland display on the external monitor and a login prompt on the console, such as:

* For machine h3ulcb:

```bash
Automotive Grade Linux ${AGL_VERSION} h3ulcb ttySC0

h3ulcb login: root
```

* For machine m3ulcb:

```bash
Automotive Grade Linux ${AGL_VERSION} m3ulcb ttySC0

m3ulcb login: root
```

Logging in on the console is easy:

* login is 'root'
* password is empty (not asked)

### Network access

If the board is connected to a local network using ethernet and if a DHCP server is able to distribute IP addresses,
you can then determine the Gen3 board IP address and log in using ssh:

```bash
m3ulcb login: root
Last login: Tue Dec  6 09:55:15 UTC 2016 on tty2
root@m3ulcb:~# ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.0.0.27/24 brd 10.0.0.255 scope global eth0
       valid_lft forever preferred_lft forever
root@m3ulcb:~#
```

Here, IP address is 10.0.0.27. Logging in using SSH is easy:

```bash
$ ssh root@10.0.0.27
Last login: Tue Dec  6 10:01:11 2016 from 10.0.0.13
root@m3ulcb:~# cat /etc/os-release
ID="poky-agl"
NAME="Automotive Grade Linux"
VERSION="3.0.0+snapshot-20161202 (chinook)"
VERSION_ID="3.0.0-snapshot-20161202"
PRETTY_NAME="Automotive Grade Linux 3.0.0+snapshot-20161202 (chinook)"
```

[R-car m3ulcb]: http://elinux.org/R-Car/Boards/M3SK
[R-car m3ulcb firmware update]: https://elinux.org/R-Car/Boards/M3SK#Flashing_firmware
[R-car h3ulcb]: http://elinux.org/R-Car/Boards/H3SK
[R-car h3ulcb firmware update]: https://elinux.org/R-Car/Boards/H3SK#Flashing_firmware
[R-car salvator-x]: https://elinux.org/R-Car/Boards/Salvator-X
[R-car loader update]: http://elinux.org/R-Car/Boards/Kingfisher#How_to_update_of_Sample_Loader_and_MiniMonitor
[R-car Kingfisher]: https://elinux.org/R-Car/Boards/Kingfisher
[R-car yocto]: http://elinux.org/R-Car/Boards/Yocto-Gen3
[rcar Linux Drivers]: https://www.renesas.com/solutions/automotive/rcar-download/rcar-demoboard.html
[rcar Linux Drivers 2]: https://www.renesas.com/en-us/solutions/automotive/rcar-download/rcar-demoboard-2.html
[Iot.bzh AGL-Kickstart-on-Renesas-Porter-Board]: http://docs.automotivelinux.org/docs/devguides/en/dev/reference/iotbzh2016/sdk/AGL-Kickstart-on-Renesas-Porter-board.pdf
[Iot.bzh AGL-Devkit-Image-and-SDK-for-Porter]: http://docs.automotivelinux.org/docs/devguides/en/dev/reference/iotbzh2016/sdk/AGL-Devkit-Image-and-SDK-for-porter.pdf
[Iot.bzh AGL-Devkit-Build-your-1st-AGL-Application]: http://docs.automotivelinux.org/docs/devguides/en/dev/reference/iotbzh2016/sdk/AGL-Devkit-Build-your-1st-AGL-Application.pdf
[Iot.bzh AGL_Phase2-Devkit-HowTo_bake_a_service]: http://docs.automotivelinux.org/docs/devguides/en/dev/reference/iotbzh2016/bsp/AGL_Phase2-Devkit-HowTo_bake_a_service.pdf

