# Deploy the Application to the Board #

You can set up your build environment to leverage a procedure's
[application template](http://docs.automotivelinux.org/docs/devguides/en/dev/reference/sdk-devkit/docs/part-2/2_4-Use-app-templates.html)
(app-template).
An app-template is a application framework that contains
[CMake](https://cmake.org/) macros that abstract deploying the application.
For example, with a proper build environment, you can run the following
to deploy your application:

```
$ make widget-target-install
```

The previous command uses secure copy (`scp`) to copy and install the widget to a
pre-defined target board.
