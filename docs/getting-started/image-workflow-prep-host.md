# 1. Preparing Your Build Host

Preparing your build host so that it can build an AGL image means
making sure your system is set up to use the
[Yocto Project](https://yoctoproject.org) OpenEmbedded build system,
which is based on
[BitBake](https://yoctoproject.org/docs/2.4.4/bitbake-user-manual/bitbake-user-manual.html).

This section presents minimal information so you can prepare the build host
to use the "Rocko" version of the Yocto Project (i.e. version 2.4.4).
If you want more details on how the Yocto Project works, you can reference
the Yocto Project documentation
[here](https://www.yoctoproject.org/docs/).

**NOTE:** This entire section presumes you want to build an image.
You can skip the entire build process if you want to use a ready-made
development image.
The
[supported images][AGL snapshots master latest] exist for several boards as
well as for the Quick EMUlator (QEMU).
See the
"[Downloading an Image](./app-workflow-image.html#downloading-an-image)"
section for more information on the ready-made images.

1. **Use a Supported Linux Distribution:** To use the AGL software, it is
   recommended that your build host is a native Linux machine that runs a
   Yocto Project supported distribution as described by the
   "[Supported Linux Distributions](https://www.yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#detailed-supported-distros)"
   section in the Yocto Project Reference Manual.
   Basically, you should be running a recent version of Ubuntu, Fedora, openSUSE,
   CentOS, or Debian.

   If you must use a build host that is not a native Linux machine, you can
   install and use Docker to create a container that allows you to work as
   if you are using a Linux-based host.
   The container contains the same development environment (i.e. distros, packages,
   and so forth) as would a properly prepared build host running a supported
   Linux distribution.
   For information on how to install and set up this Docker container, see the
   "[Setting Up a Docker Container](./docker-container-setup.html)"
   section.

2. **Be Sure Your Build Host Has Enough Free Disk Space:**
   Your build host should have at least 50 Gbytes.

3. **Be Sure Tools are Recent:**  You need to have recent versions for
   the following tools:

   * Git 1.8.3.1 or greater
   * Tar 1.27 or greater
   * Python 3.4.0 or greater

   If your distribution does not meet these minimal requirements, see the
   "[Required Git, tar, and Python Versions](https://www.yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#required-git-tar-and-python-versions)"
   section in the Yocto Project Reference Manual for steps that you can
   take to be sure you have these tools.

4. **Install Essential, Graphical, and Eclipse Plug-in Build Host Packages:**
   Your build host needs certain host packages.
   Depending on the Linux distribution you are using, the list of
   host packages differ.
   See
   "[The Build Host Packages](https://www.yoctoproject.org/docs/2.4.4/yocto-project-qs/yocto-project-qs.html#packages)"
   section of the Yocto Project Quick Start for information on the packages you need.

   **NOTE:** If you are using the CentOS distribution, you need to
   separately install the epel-release package and run the `makecache` command as
   described in
   "[The Build Host Packages](https://www.yoctoproject.org/docs/2.4.4/yocto-project-qs/yocto-project-qs.html#packages)"
   section of the Yocto Project Quick Start.

   Aside from the packages listed in the previous section, you need the following:

   * **Ubuntu and Debian:** curl
   * **Fedora:** curl
   * **OpenSUSE:** glibc-locale curl
   * **CentOS:** curl
