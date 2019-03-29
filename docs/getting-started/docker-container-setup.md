# Overview

This section explains how to quickly setup a Docker container environment
suitable for using the Yocto Project build system.
Within the container environment you can build images using BitBake
and create and package AGL applications with a Software Development
Kit (SDK) specifically tailored for your target hardware.

Docker is an open source tool designed to make it easier to create, deploy,
and run applications by using containers.
Containers allow a developer to package up an application with all
the parts it needs, such as libraries and other dependencies, and ship
it all out as one package.

The container you set up here is configured for Yocto Project and AGL.
This configuration means you do not have to have a native Linux build
host.
You can use a system running Microsoft or MacOS.

You can learn more about Docker on the
[Docker Documentation](https://docs.docker.com/) site.

**NOTE:** The information in this section has been tested using a Linux
system.
However, as previously mentioned, you could set up a Docker container
that works using Windows or MacOS.

## 1. Installing Docker Community Edition (CE)

If your build host does not already have
[Docker CE](https://docs.docker.com/install/) installed, you must install it.

You can find general instructions for installing Docker CE on a Linux system
on the [Docker Site](https://docs.docker.com/engine/installation/linux/).

You need to download the Docker CE version particular to your operating system.
For example, if you are running the Ubuntu 16.04 Linux distribution, you can
click the appropriate
[Supported Platform](https://docs.docker.com/install/#supported-platforms) checkmark
and see the instructions you need to install Docker CE on that platform.

Follow the steps to install Docker CE for your particular distribution.
For example, the
[Get Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
page describes how to install Docker CE on a build host running the Ubuntu
distribution.

Successful Docker installation is measured by the results of running a "hello world"
application:

```bash
$ sudo docker run hello-world
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

## 2. Setting Up to Use Docker as a Non-Root User

For Linux machines, Docker runs as a root user by default.
You can create a docker group and add yourself to it so that you do not
have to preface every `docker` command with `sudo`, for example.

Follow the instructions on the
[Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall/)
page for information on how to create a Docker group and add yourself to the group.

Once you have set up to use Docker as a non-root user, you can log out of your
system, log back in, and run the "hello world" application again to verify you
do not have to use root:

```bash
$ docker run hello-world
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

## 3. Setting Up a Persistent Workspace

Docker images are pre-configured to use a particular User Identifier (uid) and
Group Identifier (gid) that allow the Container to use the Yocto Project
build system.
The `uid:gid` provides a dedicated user account *devel*,
which belongs to `uid=1664(devel)` and `gid=1664(devel)`.

**NOTE:** The password is `devel`.

The `create_container.sh` script as shown in the following
section instantiates a new container and shares the following
volumes with the build host:

* **/xdt:**
  The build directory inside the container.
  This directory is stored in **~/ssd/xdt_$ID**, which is specific to
  the container's instance ID.

* **/home/devel/mirror:**
  A development mirror stored in **~/ssd/localmirror_$ID**,
  which is specific to the container's instance ID.

* **/home/devel/share:**
  A development share at **~/devel/docker/share**, which is shared
  by all containers.

These shared volumes need the proper permissions in order form them
to be accessible from the container environment.
You can make sure permissions are in order using the following commands:

```bash
$ mkdir ~/ssd ~/devel
$ chmod a+w ~/ssd ~/devel
```

**Note**:

* To gain access from your host on files created within the container, your
   host account requires to be added to group id 1664.

## 4. Getting the Generic AGL Worker Docker Image

You can either locate and install a pre-built image or rebuild the image.

### Using a Pre-Built Image

Use the `wget` command to download the latest pre-built Docker image
into your local Docker instance.
Here is an example:

```bash
$ wget -O - https://download.automotivelinux.org/AGL/snapshots/sdk/docker/docker_agl_worker-latest.tar.xz | docker load
$ docker images
      REPOSITORY                                      TAG                 IMAGE ID            CREATED             SIZE
      docker.automotivelinux.org/agl/worker-generic   5.99-95             6fcc19b4e0d7        2 weeks ago         1.56GB
      jenkins                                         latest              55720d63e328        5 weeks ago         711.9 MB
      hello-world                                     latest              c54a2cc56cbb        5 months ago        1.848 kB
```

After loading the image, identify and export the `IMAGE_ID`.
For example, the `IMAGE_ID` given the previous command is "6fcc19b4e0d7".

```bash
$ export IMAGE_ID=6fcc19b4e0d7
```

### Building an Image

You can build the Docker image using the
[docker-worker-generator](https://git.automotivelinux.org/AGL/docker-worker-generator/)
scripts.

## 5. Starting the Container

After you have the image available, use the
`create_container` script to start a new, fresh container that is
based on the AGL Worker image:

**NOTE:**
The password for the ID "devel" inside the docker image is "devel".

```bash
$ git clone https://git.automotivelinux.org/AGL/docker-worker-generator
$ cd docker-worker-generator
$ ./contrib/create_container 0 $IMAGE_ID
$ docker ps
CONTAINER ID        IMAGE                                       COMMAND                  CREATED             STATUS              PORTS                                                                                        NAMES
4fb7c550ad75        6fcc19b4e0d7   "/usr/bin/wait_for_ne"   33 hours ago        Up 33 hours         0.0.0.0:2222->22/tcp, 0.0.0.0:69->69/udp, 0.0.0.0:8000->8000/tcp, 0.0.0.0:10809->10809/tcp   agl-worker-odin-0-sdx
```

## 6. Installing the AGL SDK for Your Target

Once you have a new container that is based on the AGL Worker Image, you
can copy the SDK Installer to the container and then install
the target-specific AGL SDK.
With an SDK installed, you are able to develop AGL applications
using the SDK.

For this section, assume that the SDK is `agl-demo-platform-crosssdk` and was built
according to the instructions in the
"[Download or Build Your SDK Installer](./app-workflow-sdk.html)"
section.

Follow these steps:

1. **Copy the SDK Installer to the Shared Volume:

<!--

This is part of the example from the original file.
It shows building out the SDK from a container.

For example, we could have built the SDK from another worker container listening with SSH on port 2223:

```bash
create_container 1;
ssh -p 2223 devel@mybuilder.local;
... [ prepare build environment ] ...
bitbake agl-demo-platform-crosssdk;
... [ build happens in /xdt/build ] ...
```
-->

   ```
   $ cp /xdt/build/tmp/deploy/sdk/poky-agl-glibc-x86_64-agl-demo-platform-crosssdk-cortexa15hf-neon-toolchain-3.0.0+snapshot.sh ~/share
   ```

2. Log into your "SDK Container" and install the SDK:

   ```bash
   $ ssh -p 2222 devel@mysdk.local
   $ install_sdk ~/share/poky-agl-glibc-x86_64-agl-demo-platform-crosssdk-cortexa15hf-neon-toolchain-3.0.0+snapshot.sh
   ```

## 7. Build Your Application

Once you have the SDK installed in your container, you are ready
to develop your application.
See the
"[Create and Build the Application](./app-workflow-build-app.html)"
section for more information.


<!--

This stuff is leftover from the original file.
It is pretty generic and I don't think we need to retain it.

First, you must source the SDK environment you wish to use (you MUST repeat this step each time you open a new shell):

```bash
source /xdt/sdk/environment-setup-<your_target>
```

You're then ready to go: get the sources, run the builds ...

```bash
git clone <your repo for your app>;
cd <your app>;
cmake; make; make package;
```

-->
