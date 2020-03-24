# 6. Create and Build the Application #

In general, you can create and build an application many different ways.
Tools and Integrated Development Environments (IDEs) exist in various
scenarios that allow you to pick from whatever methodology or workflow
with which you are comfortable.

A simple application you can experiment with is the standard
"hello world" application.
For information on how to get set up and then clone the Git repository
for the "Hello World" application, see the
"[Get the Source Files](../../../devguides/reference/xds/part-1/create-app-get-source-files.html)"
section.

Key to developing an application suited for your target hardware is the
Standard Software Development Kit (SDK) mentioned in the
"[Get Ready to Create Your Application](./app-workflow-prep-app.html)"
section.
For information on the Standard SDK used with the Yocto Project and with
the AGL Project, see the
"[Yocto Project Application Development and Extensible Software Development Kit (eSDK)](https://yoctoproject.org/docs/2.4.4/sdk-manual/sdk-manual.html) Manual".

You can develop your application a number of ways.
The following list describes several:

* **Build the Application Using XDS:**
  You can use the AGL X(cross) Development System (XDS)
  to build your application:

  * Use the XDS command line tool.
    For information on how to build the "Hello World" application using the XDS
    command line, see the
    "[Build Using the Command Line](../../../devguides/reference/xds/part-1/create-app-build-cmd-line.html)"
    section.

  * Use the XDS Dashboard.
    For information on how to build the application using the XDS Dashboard, see the
    "[Build Using the XDS Dashboard](../../../devguides/reference/xds/part-1/create-app-build-dashboard.html)"
    section.

* **Build the Application Using a Stand-Alone SDK:**
   Nothing prevents you from using a Standard SDK completely outside of the
   AGL Project development environment to build your application.
   Here are a couple of methods:

   * Install Docker and create a container that has your SDK installed.
     The container is a stable environment where you can build applications.
     See the
     "[Setting Up a Docker Container](./docker-container-setup.html)"
     section for information on how to install Docker and create a container
     that has your SDK installed.

   * Use the popular Eclipse IDE configured to work with the Yocto Project.
     See the
     "[Developing Applications Using Eclipse](https://yoctoproject.org/docs/2.4.4/sdk-manual/sdk-manual.html#sdk-eclipse-project)"
     section in the Yocto Project Application Development and Extensible
     Software Development Kit (eSDK) Manual.

   * Using Qt Creator / qmake and want to use the same .pro / .pri file to build for desktop or AGL? Put AGL-specific definitions inside a `linux-oe-*` block in your .pro and .pri files, e.g.:
     ```
     linux-oe-* {
         PKGCONFIG += qlibwindowmanager qtappfw
         DEFINES += AGL
         QMAKE_LFLAGS += "-Wl,--hash-style=gnu -Wl,--as-needed"
         load(configure)
         qtCompileTest(libhomescreen)

         config_libhomescreen {
             CONFIG += link_pkgconfig
             PKGCONFIG += homescreen
             DEFINES += HAVE_LIBHOMESCREEN
         }

         DESTDIR = $${OUT_PWD}/../package/root/bin
     }
     ```

* **Build the Application Using Your Own Methodology:**
  Use any method you are familiar with to create your application.
  Many development tools and workflows exist that allow you to
  create applications.
