# Inside the container

## Features

Container features:

- a Debian 8.5 based system with an SSH server listening on tcp/22,
- a dedicated user is defined to run the SSH session: **devel**
  (password: **devel**)
- a script named "prepare_meta" for preparing the build environment

## File system organization and shared volume

The image has been designed with a dedicated file-system hierarchy. Here it is:

```bash
devel@bsp-devkit:/$ **tree -L 2 /xdt**
/xdt
|-- build
| `-- conf
| |-- bblayers.conf
| |-- local.conf
| [snip]
|-- ccache
|-- downloads
|-- meta
| |-- agl-manifest
| |-- meta-agl
| |-- meta-agl-demo
| |-- meta-agl-extra
| |-- meta-amb
| |-- meta-intel
| |-- meta-intel-iot-security
| |-- meta-iot-agl
| |-- meta-oic
| |-- meta-openembedded
| |-- meta-qt5
| |-- meta-renesas
| |-- meta-rust
| |-- meta-security-isafw
| `-- poky
|-- sdk
|-- sources
|-- sstate-cache
| |-- 00
| |-- 01
| |-- 02
| |-- 03
| |-- 04
| |-- 05
| |-- 06
| |-- 07
 [snip]
`-- workspace
```

Noticeably, the BSP related features are located in the dedicated "/xdt"
directory.

This directory contains sub-directories, and in particular the
following:

- **build**: will contain the result of the build process, including
  an image for the Porter board.
- **downloads**: (optional) contain the Yocto download cache, a
  feature which will locally store the upstream projects sources codes
  and which is fulfilled when an image is built for the first time.
  When populated, this cache allow the user to built without any
  connection to Internet.
- **meta**: contains the pre-selected Yocto layers required to built
  the relevant AGL image for the Porter board.
- **sstate-cache**: (optional) contain the Yocto shared state
  directory cache, a feature which store the intermediate output of
  each task for each recipe of an image. This cache enhance the image
  creation speed time by avoiding Yocto task to be run when they are
  identical to a previous image creation.
