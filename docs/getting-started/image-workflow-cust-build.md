# 4. Customizing Your Build

Because the build process is based on BitBake and the Yocto Project,
build customizations are driven through configuration files used during
the build.

Lots of configuration files exist that define a build.
However, the primary one that acts as a global configuration mechanism is the
`local.conf` file, which is found in the Build Directory in a folder named "conf".

Before you start your build process, you should open up the `local.conf` file
and look through it to be sure the general configurations are correct.
The file is well commented so you should be able to understand what the
various variables accomplish.

To view and customize the `local.conf` file, use any text editor:

```bash
$ vi $AGL_TOP/build/conf/local.conf
```

As mentioned in the "[Initializing Your Build Environment](./image-workflow-initialize-build-environment.html#initializing-your-build-environment.html)" section,
the `local.conf` file gets augmented with AGL configuration fragments based on
how you execute the `aglsetup.sh` script.
You can see those fragments at the end the configuration file.

Even though your build should work fine after running the `aglsetup.sh` script,
you might consider editing your `local.conf` file to use one or more of the
following configurations.

## Capturing Build History

You can enable build history to help maintain the quality of your build output.
You can use it to highlight unexpected and possibly unwanted changes in the build output.
Basically, with build history enabled, you get a record of information about the contents
of each package and image.
That information is committed to a local Git repository where you can examine it.

To enable build history, make sure the following two lines are in your
`local.conf` file:

```bash
INHERIT += "buildhistory"
BUILDHISTORY_COMMIT = "1"
```

See the
"[Maintaining Build Output Quality](https://www.yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#maintaining-build-output-quality)"
section in the Yocto Project Reference Manual for a complete discussion on
build history.

## Deleting Temporary Workspace

During a build, the build system uses a lot of disk space to store temporary files.
You can ease the burden on your system and speed up the build by configuring the build
to remove temporary workspace.

You need to inherit the `rm_work` class by using this statement in the `local.conf` file:

```bash
INHERIT += "rm_work"
```

You can read about the class in the
"[rm_work.bbclass](https://www.yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#ref-classes-rm-work)"
section of the Yocto Project Reference Manual for more information.

##  Pointing at Shared State Cache Locations

The build system creates everything from scratch unless BitBake can determine that parts do not need to be rebuilt. Fundamentally, building from scratch is attractive as it means all parts are built fresh and there is no possibility of stale data causing problems.
When developers hit problems, they typically default back to building from scratch so they know the state
of things from the start.

The build process uses Shared State Cache (sstate) to speed up subsequent builds.
This cache retains artifacts that can be re-used once it is determined that they
would not be different as compared to a re-built module.

For the AGL build, you can specify the location for sstate files by including the
following in the `local.conf` file:

```bash
SSTATE_DIR = "${HOME}/workspace_agl/sstate-cache"
```

also, in the `local.conf` file, you can specify additional directories in which the build
system can look for shared state information.
Use the following form in your file to list out the directories you want the build
process to look at for sstate information:


```bash
SSTATE_MIRRORS ?= "\
     file://.* http://someserver.tld/share/sstate/PATH;downloadfilename=PATH \n \
     file://.* file:///some/local/dir/sstate/PATH"
```

If you want to know more about the Yocto Project sstate mechanism, see the
"[Shared State Cache](https://www.yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#shared-state-cache)"
section in the Yocto Project Reference Manual.

## Preserving the Download Directory

During the initial build, the system downloads many different source code tarballs
from various upstream projects.
Downloading these files can take a while, particularly if your network
connection is slow.
The process downloads files into a
"[download directory](https://www.yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#var-DL_DIR)".
The `DL_DIR` variable defines the download directory.
For subsequent builds, you can preserve this directory to speed up the download
part of a build.

The default download directory is in a folder named "downloads".
For the AGL build you can set the download directory by adding the following to your
`local.conf` file:

```bash
DL_DIR = "${HOME}/workspace_agl/downloads"
```

## Using a Shared State (sstate) Mirror

The underlying Yocto Project build system uses Shared State Mirrors to cache
artifacts from previous builds.
You can significantly speed up builds and guard against fetcher failures by
using mirrors.
To use mirrors, add this line to your `local.conf` file in the Build directory:

```
SSTATE_MIRRORS_append = " file://.* https://download.automotivelinux.org/sstate-mirror/master/${DEFAULTTUNE}/PATH \n "
```

You can learn more about shared state and how it is used in the
"[Shared State Cache](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#shared-state-cache)"
section of the Yocto Project Reference Manual.

