# 5. Building the AGL Image

Building the AGL image involves running BitBake with a specified target.
Depending on whether you are building the image for the first time or if this
is a subsequent build, the time needed for the build could be significant.

It is critical that you specify the correct options and configurations for the
build before executing the `bitbake` command.
The previous sections in the "Image Development Workflow" have treated this setup
in a generic fashion.
This section, provides links to topics with instructions needed to create images for
three types of supported platforms and for emulation using Quick EMUlator (QEMU)
or VirtualBox:

* [Most Intel-based 64-Bit Boards](./machines/intel.html/)
* [Emulation](./machines/qemu.html/)
* [R Car Starter Kit Gen3 Board](./machines/renesas.html/)
* [Raspberry PI 2 or 3](./machines/raspberrypi.html/)
