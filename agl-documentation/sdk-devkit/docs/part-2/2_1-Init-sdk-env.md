# Initializing SDK environment and templates

## Initializing the SDK environment

*(This document assumes that you are logged inside the **bsp-devkit** Docker
container, used to produce Rcar Gen3 BSP image and AGL SDK in the
previous **"SDK quick setup"** document)*

To be able to use the toolchain and utilities offered by AGL SDK, it is
necessary to source the proper setup script. This script is in the SDK
root folder and is named `/xdt/sdk/environment-setup-*` (full name
depends on the target machine)

For Rcar Gen3 boards, we source the required SDK environment variables like
this:

```bash
source /xdt/sdk/environment-setup-aarch64-agl-linux
```

To verify that it succeeded, we should obtain a non-empty result for
this command:

```bash
echo $CONFIG_SITE | grep sdk /xdt/sdk/site-config-aarch64-agl-linux
```

## Application categories

We provide multiple development templates for the AGL SDK:

- Service

  A Service is a headless background process, allowing Bindings to expose
  various APIs accessible through the transports handled by the application
  framework, which are currently:
  - [HTTP REST (HTTP GET, POST...)](https://en.wikipedia.org/wiki/Representational_state_transfer)
  - [WebSocket](https://en.wikipedia.org/wiki/WebSocket)
  - [D-Bus](https://www.freedesktop.org/wiki/Software/dbus/)

- Native application

  A Native application is a compiled application, generally written in C/C++,
  accessing one or more services, either by its own means or using a helper
  library with HTTP REST/WebSocket capabilities.

  *(our template is written in C and uses the "libafbwsc" helper library
  available in the app-framework-binder source tree on AGL Gerrit)*

- HTML5 application

  An HTML5 application is a web application, generally written with a framework
  (AngularJS, Zurb Foundation...), accessing services with its built-in HTTP
  REST/WebSocket capabilities.

- Legacy application

  A legacy application contains a native application not made for AGL
  Application Framework but launched by it. For such application, only
  security setup is made.

## Getting helloworld templates

Application Framework _helloworld_ example live in a dedicated Git
Repository, currently hosted on GitHub at the following address:

[https://github.com/iotbzh/helloworld-service](https://github.com/iotbzh/helloworld-service)

To get the templates in our development container, let us simply clone
the source repository:

```bash
$ cd ~
$ git clone --recursive https://github.com/iotbzh/helloworld-service
Cloning into 'helloworld-service'...
[...snip...]
Resolving deltas: 100% (125/125), done.
Checking connectivity... done.
```
