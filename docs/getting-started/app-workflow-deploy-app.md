# Deploy the Application to the Board #


Many options exist for controlling your target and copying your compiled application to the target.
Details are target-specific and cannot be explained in detail here.

Suffice it to say that if you compile your application on your build host and you have
an image running on your target hardware, you must employ some method to copy the application
to the target.
Several general methods exist:

  * Write the application to a storage device that both the build host and
    the target hardware support.
    This could be an SD card or a flash drive.
    Be sure to format the drive as FAT32 to eliminate file ownership and permission issues.

  * Remotely mount the target's file system on the build host with the Network File System
    (NFS) or Samba.

  * Commit compiled code from the build host to a shared repository and update the
    target from that repository.

  * Use remote commands from a host over a network, such as `scp` (i.e. secure copy).

  * You can set up your build environment to leverage a procedure's
    [application template](../../../../../docs/devguides/en/dev/reference/sdk-devkit/docs/part-2/2_4-Use-app-templates.html)
    (app-template).
    An app-template is an application framework that contains
    [CMake](https://cmake.org/) macros that abstract deploying the application.
    For example, with a proper build environment, you can run the following
    to deploy your application:

    ```
    $ make widget-target-install
    ```

    **NOTE:**
    The previous command uses `scp` to copy and install the widget to a pre-defined target board.

Once you have the application copied to the target, it must provide a way to
initiate operating system commands.
To initiate operating system commands, you can do one of the following:

  * Connect a keyboard and display directly to the target.

  * Use ``ssh`` from a network-connected host to run commands on the target remotely.

  * Use a network for communication between the build host and the target.
    This method works nicely when the build host and the target hardware are geographically apart.
