# Building for Emulation

Building an image for emulation allows you to simulate your
image without actual target hardware.

This section describes the steps you need to take to build the
AGL demo image for emulation using either Quick EMUlator (QEMU) or
VirtualBox.

## 1. Making Sure Your Build Environment is Correct

The
"[Initializing Your Build Environment](../image-workflow-initialize-build-environment.html)"
section presented generic information for setting up your build environment
using the `aglsetup.sh` script.
If you are building the AGL demo image for emulation, you need to specify some
specific options when you run the script:

```bash
source meta-agl/scripts/aglsetup.sh -f -m qemux86-64 agl-demo agl-devel
```

The "-m" option specifies the "qemux86-64" machine.
The list of AGL features used with script are appropriate for development of
the AGL demo image suited for either QEMU or VirtualBox.

## 2. Using BitBake

This section shows the `bitbake` command used to build the AGL image.
Before running BitBake to start your build, it is good to be reminded that AGL
does provide pre-built images for developers that can be emulated
using QEMU and VirtualBox.
You can find these pre-built images on the
[AGL Download web site](https://download.automotivelinux.org/AGL/release).

For supported images, the filenames have the following forms:

```
<release-name>/<release-number>/qemuarm/*
<release-name>/<release-number>/qemuarm64/*
<release-name>/<release-number>/qemux86-64/*
```

Start the build using the `bitbake` command.

**NOTE:** An initial build can take many hours depending on your
CPU and and Internet connection speeds.
The build also takes approximately 100G-bytes of free disk space.

For this example, the target is "agl-demo-platform":

```bash
  bitbake agl-demo-platform
```

By default, the build process puts the resulting image in the Build Directory:

```
<build_directory>/tmp/deploy/images/qemux86-64/

e.g.

<build_directory>/tmp/deploy/images/qemux86-64/agl-demo-platform-qemux86-64.vmdk.xz
```

**Note:**

If you built your image with bitbake, you can now just use the ``runqemu`` wrapper.

**Note:**
If you need to run it outside of the bitbake environment or need special settings for
hardware pass-through or the like, read on:


## 3. Deploying the AGL Demo Image

Deploying the image consists of decompressing the image and then
booting it using either QEMU or VirtualBox.

### Decompress the image:

For Linux, use the following commands to decompress the image and prepare it for boot:

```bash
cd tmp/deploy/images/qemux86-64
xz -d agl-demo-platform-qemux86-64.vmdk.xz
```

For Windows, download [7-Zip](http://www.7-zip.org/) and then
select **agl-demo-platform-qemux86-64.vmdk.xz** to decompress
the image and prepare it for boot.

### Boot the Image:

The following steps show you how to boot the image with QEMU or VirtualBox.

#### QEMU

Depending on your Linux distribution, use these commands to install QEMU:

**NOTE:** if you have created an AGL crosssdk, it will contain a
QEMU binary for the build host.
This SDK QEMU binary does not support graphics.
Consequently,  you cannot use it to boot the AGL image and
need to call your host's qemu binary instead.

**NOTE:** the VM images need UEFI in the emulator to boot. Thus you need
to install the necessary files with below commands (ovmf).

If your build host is running
[Arch Linux](https://www.archlinux.org/), use the following commands:

```bash
sudo pacman -S qemu ovmf
export OVMF_PATH=/usr/share/ovmf/x64/OVMF_CODE.fd
```

If your build host is running Debian or Ubuntu, use the following commands:

```bash
sudo apt-get install qemu-system-x86 ovmf
export OVMF_PATH=/usr/share/ovmf/OVMF.fd
```

If you build host is running Fedora, use the following commands:

```bash
sudo yum install qemu qemu-kvm edk2-ovmf
export OVMF_PATH=/usr/share/edk2/ovmf/OVMF_CODE.fd
```

Once QEMU is installed, boot the image with KVM support:

```bash
qemu-system-x86_64 -enable-kvm -m 2048 \
    -bios ${OVMF_PATH} \
    -hda agl-demo-platform-qemux86-64.wic.vmdk \
    -cpu kvm64 -cpu qemu64,+ssse3,+sse4.1,+sse4.2,+popcnt \
    -vga virtio -show-cursor \
    -device virtio-rng-pci \
    -serial mon:stdio -serial null \
    -soundhw hda \
    -net nic \
    -net user,hostfwd=tcp::2222-:22
```

After successfully starting the virtual machine, use this command to connect the machine remotely:

```bash
ssh –p 2222 root@localhost
```

**NOTE:** KVM may not be supported within a virtualized environment such as
VirtualBox. This is indicated by the qemu command above giving the error
message `Could not access KVM kernel module: No such file or directory` or
the kernel log output contains the error message `kvm: no hardware support`.
The image can be booted in such an environment by removing `-enable-kvm` from
the qemu command line, however this will result in lower perfromance within
the AGL demo.

#### VirtualBox

Start by downloading and installing [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 5.2.0 or later.

Once VirtualBox is installed, follow these steps to boot the image:

1. Start VirtualBox
2. Click **New** to create a new machine
3. Enter **AGL QEMU** as the *Name*
4. Select **Linux** as the *Type*
5. Select **Other Linux (64-bit)** as the *Version*
6. Set *Memory size* to **2 GB**
7. Click **Use an existing virtual hard disk file** under *Hard disk*
8. Navigate to and select the **agl-demo-platform-qemux86-64.vmdk** image
9. Select the newly created **AGL QEMU** machine and click **Settings**
10. Go to the **System** tab and ensure **Enable EFI (special OSes only)** is enabled then click **OK**
11. With the **AGL QEMU** machine still selected, click **Start** to boot the virtual machine
