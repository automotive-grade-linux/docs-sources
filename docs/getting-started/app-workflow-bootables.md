# 3. Create Bootable Media #

In order to test an application, your device must be running the image and, of course,
the application.
To run the image, you need to create a bootable image that can be launched
from an external device such as an SD card or USB stick.

The following list overviews the process.

1. Insert your media into the appropriate build host interface (e.g. USB port).
2. Determine the device name of your portable media (e.g. ``sdb``).
3. Write out the image using e.g. ``etcher`` , ``bmaptool`` or ``dd``.

You can detailed steps for creating bootable images for several types of images
in the following sections:

* "[Deploying the AGL Demo Image](./machines/qemu.html#3-deploying-the-agl-demo-image)" for emulation images
* "[Booting the Image Using a MicroSD Card](./machines/renesas.html#7-booting-the-image-using-a-microsd-card) for supported Renesas boards
* "[Booting the Image on Raspberry Pi](./machines/raspberrypi.html#2-booting-the-image-on-raspberrypi) for Raspberry Pi 4 board
