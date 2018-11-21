# Debug the Application #

You can debug your application many ways.
The method depends on factors such as the component you are debugging,
whether or not you are doing a post-mortem analysis, and your debugging
skills and productivity.
For example, do you know how to use the
[GNU Project Debugger](https://www.gnu.org/software/gdb/) (`gdb`) from a
console?
Or, is it better for you to use a remote user interface that is part of
an Integrated Development Environment (IDE) such as Eclipse?

For general information on debugging an application, see the
"[Debug your first AGL application](../../../../../docs/devguides/en/dev/reference/xds/part-1/5_debug-first-app.html)"
section.

Here are three methods:

   * Use `gdb` on the target.

     **NOTE:** How to use `gdb` and other debugging tools such as `valgrind`, `strace`,
     and so forth is beyond the scope of the AGL Documentation.
     See the appropriate documentation for third-party debugging tools.

   * Use Core Dumps if you have set the `agl-devel` feature.
     Core Dumps are obviously more suited for post-mortem analysis.
     For features, see the
     "[Initializing Your Build Environment](./image-workflow-initialize-build-environment.html#initializing-your-build-environment)"
     section.

     **NOTE:** Core Dumps are available only with the "Flunky Flounder" release (i.e. 6.x).

   * Use XDS remotely, which is based on `gdb` and
     [`gdbserver`](https://en.wikipedia.org/wiki/Gdbserver).
     See the
     "[XDS remote debugging mode](../../../../../docs/devguides/en/dev/reference/xds/part-1/5-2_debug-first-app-cmd.html#xds-remote-debugging-mode)"
     section for more information.

     For information on how to remotely debug the application using XDS from within an IDE, see the
     "[Debug using `xds-gdb` within an IDE](../../../../../docs/devguides/en/dev/reference/xds/part-1/5-3_debug-first-app-ide.html)"
     section.

   In order to use third-party debugging tools, you need to include the tools in the target image.
   You gain access to the tools by enabling the `agl-devel` feature when you run the
   `aglsetup.sh` script as described in the
   "[Initializing Your Build Environment](./image-workflow-initialize-build-environment.html#initializing-your-build-environment)"
   section.
