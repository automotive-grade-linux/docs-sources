# AGL SDK compilation and installation

Now that we have both a finalized development container and a deployed
Porter image, let us create and install the SDK (Software Development
Kit), so that we can develop new components for our image.

Going back to the container, let's generate our SDK files:

```bash
bitbake agl-demo-platform-crosssdk
```

This will take some time to complete.

Alternatively, you can download a prebuilt SDK file suitable for AGL 2.0
on automotivelinux website:

```bash
mkdir -p /xdt/build/tmp/deploy/sdk
cd /xdt/build/tmp/deploy/sdk
wget https://download.automotivelinux.org/AGL/release/chinook/3.0.2/porter-nogfx/deploy/sdk/poky-agl-glibc-x86_64-core-image-minimal-cortexa15hf-neon-toolchain-3.0.0+snapshot.sh
```

Once you have the prompt again, let's install our SDK to its final
destination. For this, run the script `install_sdk` with the SDK
auto-installable archive as argument:

```bash
install_sdk /xdt/build/tmp/deploy/sdk/poky-agl-glibc-x86_64-core-image-minimal-cortexa15hf-neon-toolchain-3.0.0+snapshot.sh
```

The SDK files should be now installed in `/xdt/sdk`:

```bash
$ tree -L 2 /xdt/sdk
/xdt/sdk/
|-- environment-setup-cortexa15hf-neon-agl-linux-gnueabi
|-- site-config-cortexa15hf-neon-agl-linux-gnueabi
|-- sysroots
|   |-- cortexa15hf-neon-agl-linux-gnueabi
|   |-- x86_64-aglsdk-linux
`-- version-cortexa15hf-neon-agl-linux-gnueabi
```

You can now use them to develop new services, and native/HTML
applications.

Please refer to the document entitled "Build Your 1st AGL Application"
to learn how to do this.
