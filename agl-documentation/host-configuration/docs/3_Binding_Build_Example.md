# Binding Build Example

Now that you have installed the AGL Application Framework, you will be guided through the installation of the [helloworld-service](https://github.com/iotbzh/helloworld-service) binding.

## Install git, cmake, gcc, g++ and json-c

### Debian

```bash
sudo apt-get install git cmake gcc g++ libjson-c-dev
```

### openSuse

```bash
sudo zypper install git cmake gcc gcc-c++ libjson-c-devel
```

### Fedora

```bash
sudo dnf install git cmake gcc gcc-c++ json-c-devel.x86_64
```

## Clone the helloworld-service repository

Sources of the [helloworld-service](https://github.com/iotbzh/helloworld-service) binding are available at IoT.BZH's GitHub.

```bash
git clone "https://gerrit.automotivelinux.org/gerrit/apps/agl-service-helloworld"
cd agl-service-helloworld
```

## Built it

```bash
./autobuild/linux/autobuild package
```

or manually

```bash
mkdir build
cd build
cmake ..
make
```

## Run it

Refer to the "Running" section of [this](http://docs.automotivelinux.org/master/docs/apis_services/en/dev/reference/af-binder/afb-binding-writing.html#sample-binding-tuto-1) page

## Troubleshooting

### systemd and/or libmicrohttpd

If you encounter an error message like this one :

```shell
-- Checking for module 'libmicrohttpd>=0.9.55'
--   No package 'libmicrohttpd' found
CMake Error at /usr/share/cmake/Modules/FindPkgConfig.cmake:415 (message):
  A required package was not found
Call Stack (most recent call first):
  /usr/share/cmake/Modules/FindPkgConfig.cmake:593 (_pkg_check_modules_internal)
  conf.d/app-templates/cmake/cmake.d/01-build_options.cmake:92 (PKG_CHECK_MODULES)
  conf.d/app-templates/cmake/common.cmake:77 (include)
  conf.d/cmake/config.cmake:184 (include)
  CMakeLists.txt:3 (include)
```

Open the config.cmake file located in helloworld-service/conf.d/cmake/
and add a # to the beginning of the "libsystemd>=222" and "libmicrohttpd>=0.9.55".
The end result should look something like this

```CMake
  set (PKG_REQUIRED_LIST
    json-c
    #libsystemd>=222
    afb-daemon
    #libmicrohttpd>=0.9.55
  )
```

Once this is done return to the "Build it!" section of this page.
