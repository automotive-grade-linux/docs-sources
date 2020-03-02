# Getting Your Source Files

Now that you have your host ready, packages installed, and the binder
daemon ready, you can get your source files together.
This example uses the `helloworld-service` binding, which is
a project hosted on GitHub, is written in the C programming language,
depends on the `libjson-c` library, and uses `cmake` for building.

## Install Programs and Libraries You Need for this Example

For this example, you need to have the following installed on your host:

```bash
git
cmake
pkg-config
gcc
g++
json-c
```

**NOTE:** If you are building a different binding, you need to make sure
you have all the programs and libraries needed to build that particular
binding.

### Installing on Debian

Use the following commands if your native Linux machine uses the Debian
distribution:

```bash
sudo apt-get install git cmake pkg-config gcc g++ libjson-c-dev
```

### Installing on OpenSUSE

Use the following commands if your native Linux machine uses the OpenSUSE
distribution:

```bash
sudo zypper install git cmake pkg-config gcc gcc-c++ libjson-c-devel
```

### Installing on Fedora

Use the following commands if your native Linux machine uses the Fedora
distribution:

```bash
sudo dnf install git cmake pkg-config gcc gcc-c++ json-c-devel.x86_64
```

## Cloning the helloworld-service repository

Use Git to create a local repository of the
[helloworld-service](https://github.com/iotbzh/helloworld-service) binding from
[IoT.BZH](https://iot.bzh/en/).
The following command creates a repository named `helloworld-service` in the
current directory.
The "--recurse-submodules" option ensures that all submodules (i.e. repositories
within `helloworld-service`) are initialized and cloned as well.

```bash
git clone https://github.com/iotbzh/helloworld-service.git --recurse-submodules
```
