# Part 1 - Build AGL image from scratch

## Abstract

The AGL DevKit allows developers to rebuild a complete bootable image
and its associated SDK from source code.\
It uses Yocto/Poky version 2.x with latest version of Renesas BSP and
 enables low-level development of drivers and system services.

The AGL DevKit contains:

- This guide, which describes how to create a Docker container able to
  build AGL images and associated SDKs.\
  The container is also suitable to build AGL Applications
  independently of Yocto/Bitbake.
- Applications templates and demos available on Github, to start
  developing various types of applications independently of Yocto:
  - services
  - native applications
  - HTML5 applications
  - ...
- A documentation guide "**AGL Devkit - Build your 1st AGL
  Application**" which explains how to use the AGL SDK to create applications
  based on templates.

*This document focuses on building from scratch an AGL image for Porter
board, within a Docker container, and then install the associated SDK.*
