# Building and Running Your Service Natively

The next step in the binder development process is to build your
binder and run it using your native Linux system.

**NOTE:** This section assumes using the `helloworld-service` example
and completion of the previous steps in this
"[Building Microservices Natively](./0-build-microservice-overview.html)"
section.

## Building the Service

Move to the cloned `helloworld-service` repository and build the service
using either of the following methods:

* ```bash
  cd helloworld-service
  ./conf.d/autobuild/linux/autobuild package
  ```

* ```bash
  cd helloworld-service
  mkdir build
  cd build
  cmake ..
  make
  ```

## Running the Service

You use the Application Framework Binder Daemon (`afb-daemon`) to
bind one instance of an application or service to the rest of the system.
In this example, you are binding an instance of `helloworld-service`
to the rest of the system:

```bash
afb-daemon --binding helloworld.so --port 3333 --token ''
```

The previous command starts `afb-daemon` and loads the `helloworld.so`
binding.
The daemon is now listening on port 3333 of the `localhost`.

## Testing the Service

Refer to the
[AGL Test Framework](../../apis_services/#agl-test-framework) topic in the
"APIs & Services" topic.
You can test your `helloworld-service` binding using the `afm-test` tool.

Examine the generic example describing how to launch the tests suite
[here](../../apis_services/reference/afb-test/3_Launch_the_tests.html).
This example can help you understand how to test your helloworld binding
instance.

## Using Optional Tools

Once you have built and run your micro-service successfully using your
native Linux system, you should consider using some additional
development tools: X(Cross) Development System (XDS) and
the Controller Area Network (CAN) Development Studio (CANdevStudio).

* **XDS:** Cross-compiles and ports your AGL image to your target hardware.
For information on XDS, see the
"[X(cross) Development System: User's Guide](../reference/xds/part-1/xds-overview.html)"
section.

* **CANdevStudio:** Simulates CAN signals such as ignition status,
doors status, or reverse gear by every automotive developer.
For information on CANdevStudio, see the
"[CANdevStudio Quickstart](../../apis_services/reference/candevstudio/1_Usage.html)"
section.

## Troubleshooting

### systemd and/or libmicrohttpd

If you encounter an error message similar to the following,
you need to make some changes to your `cmake` file:

```shell
-- Checking for module 'libmicrohttpd>=0.9.60'
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

Open the `config.cmake` file located in `helloworld-service/conf.d/cmake/` directory
and add a hash character (i.e. #) to the beginning of the "libsystemd>=222"
and "libmicrohttpd>=0.9.60" strings.
Following is an example of the edits:

```CMake
  set (PKG_REQUIRED_LIST
    json-c
    #libsystemd>=222
    afb-daemon
    #libmicrohttpd>=0.9.60
  )
```

After making these changes, rebuild the service again as described in the
"[Building the Service](./4-getting-source-files.html#building-the-service)"
section previously on this page.
