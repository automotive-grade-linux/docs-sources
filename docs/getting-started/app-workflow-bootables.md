# 3. Create Bootable Media #

In order to test an application, your device must be running the image and, of course,
the application.
To run the image, you need to create a bootable image that can be launched
from an external device such as an SD card or USB stick.

The following list overviews the process.
You find a more detailed description of the process in the
"[Create a bootable media](./machines/intel.html#create-a-bootable-media)"
section.

1. Insert your media into the appropriate build host interface (e.g. USB port).
2. Determine the device name of your portable media (e.g. ``sdb``).
3. Download the ``mkefi-agl.sh`` script.
4. Check your available script options.
5. Use ``mkefi-agl.sh`` to create your media.
