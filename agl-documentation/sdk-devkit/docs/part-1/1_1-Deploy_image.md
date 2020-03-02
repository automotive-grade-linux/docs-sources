# Deploy an image using containers

## Motivation

The Yocto build environment is subject to many variations depending on:

- Yocto/Poky/OpenEmbedded versions and revisions
- Specific layers required for building either the BSP or the whole distribution
- Host distribution and version [1]
- User environment

In particular, some recent Linux host distributions (Ubuntu 15.x, Debian
8.x, OpenSUSE 42.x, CentOS 7.x) do not officially support building with
Yocto 2.0.
Unfortunately, there's no easy solution to solve this kind of
problem:

- we will still observe for quite a long time a significant gap
 between the latest OS versions and a fully certified build environment.

To circumvent those drawbacks and get more deterministic results amongst
the AGL community of developers and integrators, using virtualization is
a good workaround.
A Docker container is now available for AGL images:

- it is faster, easier and less error-prone to use a prepared Docker
 container because it provides all necessary components to build and
 deploy an AGL image, including a validated base OS, independently of the
 user's host OS.

Moreover, light virtualization mechanisms used by Docker
do not add much overhead when building:

- performances are nearly equal to native mode.

[1] *The list of validated host distros is defined in the Poky distro, in
the file `meta-yocto/conf/distro/poky.conf` and also at [http://www.yoctoproject.org/docs/2.0/ref-manual/ref-manual.html#detailed-supported-distros](http://www.yoctoproject.org/docs/2.0/ref-manual/ref-manual.html#detailed-supported-distros)*

## Prerequisites

To run an AGL Docker image, the following prerequisites must be
fulfilled:

- You must run a 64-bit operating system, with administrative rights,
- Docker engine v1.8 or greater must be installed,
- An internet connection must be available to download the Docker
    image on your local host.
