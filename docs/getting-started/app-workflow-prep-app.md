# 5. Get Ready to Create Your Application #

Multiple methods exist that allow you to create your application.
You can use the X(cross) Development System (XDS), or you can use
a stand-alone Software Development Kit (SDK).
The preferred method is to use XDS.

## Using XDS ##

It is recommended that you develop your application using XDS,
which allows you to build, deploy, and execute personal projects on a target
either through the XDS dashboard or the XDS command line.

To use XDS, you need to install server and client parts
and then use XDS to install the SDK:

1. **Install the XDS Server:**  You might not have to install the XDS Server.
   If, for example, you are using an existing XDS server running on your local network
   or in the Cloud, you can use that server.

   If you do not have an existing XDS server, you need to install one.
   Three install types exist: container, virtual machine, or native.
   Follow the steps from the appropriate section to install and start an XDS server:

   * **Container:** [Installation based on Docker container](../../../../../docs/devguides/en/dev/reference/xds/part-1/1-1_install-xds-server-docker.html)

   * **Virtual Machine:** [Installation based on Virtual Machine appliance](../../../../../docs/devguides/en/dev/reference/xds/part-1/1-2_install-xds-server-vm.html)

   * **Native:** [Native installation](../../../../../docs/devguides/en/dev/reference/xds/part-1/1-3_install-xds-server-native.html)

2. **Install the XDS Client Tools**  The XDS Agent (``xds-agent``) needs to run on your build host.
   The agent interfaces with a Command-line Interpretor (CLI) tool (``xds-cli``) and an
   XDS Dashboard through a browser.
   Installation involves making sure you have the correct packages installed on the
   build host.
   Follow the steps in the
   "[Installing XDS Client Tools](../../../../../docs/devguides/en/dev/reference/xds/part-1/2_install-client.html)"
   section to install the XDS client tools and learn how to start the agent.

3. **Install the SDK:** Once you have XDS up, you need to install the
   SDK using either the command line or the Dashboard.
   See the
   "[Installing AGL SDKs](../../../../../docs/devguides/en/dev/reference/xds/part-1/3_install-sdks.html)"
   section for information on using both.

## Installing a Stand-Alone SDK ##

If you do not want to use XDS, you can install the SDK by itself.
For information, see the
"[App development SDK for Intel Minnowboard](https://wiki.automotivelinux.org/agl-distro/developer_resources_intel_apps)"
Wiki article.
You can also visit the
[Yocto Project Application Development and the Extensible Software Development Kit (eSDK)](https://yoctoproject.org/docs/2.4.4/sdk-manual/sdk-manual.html)
Manual.

**NOTE:** The AGL Project is not compatible with the eSDK.
You must use the Standard SDK.
