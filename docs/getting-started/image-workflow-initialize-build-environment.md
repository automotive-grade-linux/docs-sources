# 3. Initializing Your Build Environment

Part of the downloaded AGL software is a setup script that you must
run to initialize the build environment.

## `aglsetup.sh` Script

You can find this script here:

```
$AGL_TOP/meta-agl/scripts/aglsetup.sh
```

The script accepts many options that allow you to define build parameters such
as the target hardware (i.e. the machine), build directory, and so forth.
Use the following commands to see the available options and script syntax:

```
$ bash
$ cd $AGL_TOP
$ source meta-agl/scripts/aglsetup.sh -h
```

## AGL Machines (= board support)

Your target platform will be selected with the `-m` flag.
The MACHINE can be selected from the templates in `meta-agl/templates/machine/*`.
Note: This is also the place where you can add new boards.

Following is a list of the available machines (level of support varies!):

```
Available machines:
   [meta-agl]
       bbe                        # BeagleBoneEnhanced
       beaglebone                 # BeagleBone
       cubox-i                    # multiple i.MX6 boards
       cyclone5                   # CycloneV
       dra7xx-evm                 # TI DRA7xx-EVM 'vayu'
       dragonboard-410c           # Qualcomm Dragonboard 410c
       dragonboard-820c           # Qualcomm Dragonboard 820c
       ebisu                      # Renesas RCar Ebisu
       h3-salvator-x              # Renesas RCar Salvator/H3
       h3ulcb                     # Renesas RCar H3
       h3ulcb-nogfx               # Renesas RCar H3 w/o gfx blobs
       hsdk                       # ARC HS
       imx6qdlsabreauto           # i.MX6 sabreauto
       intel-corei7-64            # x86-64 (Intel flavour)
       m3ulcb                     # Renesas RCar M3
       m3ulcb-nogfx               # Renesas RCAR M3 w/o gfx blobs
       nitrogen6x                 # i.MX6 nitrogen board
       qemuarm                    # Qemu ARM
       qemuarm64                  # Qemu AArch 64 (ARM 64bit)
     * qemux86-64                 # Qemu x86-64
       raspberrypi3               # Raspberry Pi 3
       raspberrypi4               # Raspberry Pi 4

```

## AGL Features

Before running the `aglsetup.sh`, you should understand what AGL features you
want to include as part of your image.
The script's help output lists available features and shows you the layers in
which they reside.

Following is a list of the available features:

```
Available features:
   [meta-agl]
       agl-all-features :( agl-demo  agl-appfw-smack  agl-hmi-framework  agl-profile-graphical-qt5  agl-profile-graphical  agl-pipewire  agl-speech-framework  agl-netboot )
       agl-appfw-smack
       agl-archiver
       agl-buildstats
       agl-ci
       agl-ci-change-features :( agl-demo  agl-appfw-smack  agl-hmi-framework  agl-profile-graphical-qt5  agl-profile-graphical  agl-pipewire  agl-speech-framework  agl-devel  agl-netboot  agl-pipewire  agl-buildstats  agl-ptest )
       agl-ci-change-features-nogfx :( agl-demo  agl-appfw-smack  agl-hmi-framework  agl-profile-graphical-qt5  agl-profile-graphical  agl-pipewire  agl-speech-framework  agl-devel  agl-netboot  agl-pipewire  agl-buildstats  agl-ptest )
       agl-ci-snapshot-features :( agl-demo  agl-appfw-smack  agl-hmi-framework  agl-profile-graphical-qt5  agl-profile-graphical  agl-pipewire  agl-speech-framework  agl-devel  agl-netboot  agl-archiver  agl-pipewire  agl-buildstats  agl-ptest )
       agl-ci-snapshot-features-nogfx :( agl-demo  agl-appfw-smack  agl-hmi-framework  agl-profile-graphical-qt5  agl-profile-graphical  agl-pipewire  agl-speech-framework  agl-devel  agl-netboot  agl-archiver  agl-pipewire  agl-buildstats  agl-ptest )
       agl-compositor
       agl-devel
       agl-egvirt
       agl-fossdriver
       agl-gplv2
       agl-hmi-framework
       agl-netboot
       agl-profile-cluster :( agl-profile-graphical )
       agl-profile-cluster-qt5 :( agl-profile-graphical-qt5  agl-profile-graphical )
       agl-profile-graphical
       agl-profile-graphical-qt5 :( agl-profile-graphical )
       agl-profile-hud
       agl-profile-telematics
       agl-ptest
       agl-sota
       agl-virt
       agl-virt-xen :( agl-virt )
   [meta-agl-cluster-demo]
       agl-cluster-demo :( agl-profile-cluster-qt5  agl-profile-graphical-qt5  agl-profile-graphical  agl-hmi-framework )
       agl-cluster-demo-preload
   [meta-agl-demo]
       agl-cluster-demo-support :( agl-gstrecorder )
       agl-demo :( agl-appfw-smack  agl-hmi-framework  agl-profile-graphical-qt5  agl-profile-graphical  agl-pipewire  agl-speech-framework )
       agl-demo-preload
       agl-demo-soundmanager :( agl-appfw-smack  agl-hmi-framework  agl-profile-graphical-qt5  agl-profile-graphical  agl-audio-soundmanager-framework )
       agl-sdl
   [meta-agl-devel]
       agl-audio-soundmanager-framework
       agl-gstrecorder
       agl-oem-extra-libs
       agl-pipewire
       agl-profile-graphical-html5 :( agl-profile-graphical )
       agl-speech-framework
       agl-voiceagent-alexa :( agl-speech-framework )
       agl-voiceagent-alexa-wakeword :( agl-voiceagent-alexa  agl-speech-framework )
   [meta-agl-extra]
       agl-localdev
       blsched
   [meta-agl-telematics-demo]
       agl-telematics-demo :( agl-profile-telematics )
```

To find out exactly what a feature provides, check out the respective layer and its README.

An AGL feature is a configuration that accounts for specific settings
and dependencies needed for a particular build.
For example, specifying the "agl-demo" feature makes sure that the
`aglsetup.sh` script creates configuration files needed to build the
image for the AGL demo.

Following are brief descriptions of the AGL features you can specify on the
`aglsetup.sh` command line:

* **agl-all-features**: A set of AGL default features.
  Do not think of this set of features as all the AGL features.

* **agl-appfw-smack**: Enables IoT.bzh Application Framework plus SMACK and
  Cynara.

* **agl-archiver**: Enables the archiver class for releases.

* **agl-ci**: Flags used for Continuous Integration (CI).
  Using this feature changes the value of the
  [`IMAGE_FSTYPES`](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#var-IMAGE_FSTYPES)
  variable.

* **agl-ci-change-features**: Enables features for CI builds for Gerrit changes.

* **agl-ci-change-features-nogfx**: Enables features for CI builds for Gerrit changes
  for targets that use binary graphics drivers (i.e. builds without graphics).

* **agl-ci-snapshot-features**: Enables features for CI daily snapshot builds.

* **agl-ci-snapshot-features-nogfx**: Enables features for CI daily snapshot builds for
  targets that use binary graphics drivers (i.e. builds without graphics).

* **agl-devel**: Activates development options such as an empty root password,
  debuggers, strace, valgrind, and so forth.

* **agl-netboot**: Enables network boot support through Trivial File Transfer Protocol (TFTP) and Network Block Device (NBD) protocol.
  Netboot is needed for CI and useful for development to avoid writing
  sdcards. Needs additional setup.

<!--
* **agl-profile**: A group or set of Layers and a Package Group as used
  by the Yocto Project.
  This feature helps define dependency for various profiles and layers
  used during the build.
  For example, "agl-demo" depends on "agl-profile-graphical-qt", which
  in turn depends on "agl-profile-graphical", which in turn depends
  on "agl-profile-core".

  agl-profile-graphical
  agl-profile-graphical-html5
  agl-profile-graphical-qt5
  agl-profile-hud
  agl-profile-telematics

  **NOTE:** For information on Package Groups, see the
  "[Customizing Images Using Custom Package Groups](https://www.yoctoproject.org/docs/2.4.4/dev-manual/dev-manual.html#usingpoky-extend-customimage-customtasks)"
  section in the Yocto Project Development Tasks Manual.
  You can also find general information about Layers in the
  "[Layers](https://www.yoctoproject.org/docs/2.4.4/dev-manual/dev-manual.html#yocto-project-layers)"
  section in that same manual.
-->

* **agl-ptest**: Enables
  [Ptest](https://yoctoproject.org/docs/2.4.4/dev-manual/dev-manual.html#testing-packages-with-ptest)
  as part of the build.

* **agl-sota**: Enables Software Over-the-Air (SOTA) components and dependencies.
  Includes meta-updater, meta-updater-qemux86-64, meta-filesystems, and meta-python.

* **agl-demo**: Enables the layers meta-agl-demo and meta-qt5.
  You need agl-demo if you are going to build the agl-demo-platform.

* **agl-sdl**: Enables or adds SDL to the build.

* **agl-pipewire**: Enables AGLs pipewire support.

* **agl-audio-soundmanager-framework**: Enables Soundmanager framework, which is an exclusive switch for audio framework.

* **agl-localdev**: Adds a local layer named "meta-localdev" in the
  meta directory and a local.dev.inc configuration file when that file
  is present.

  This feature provides a shortcut for using the layer meta-localdev
  in the top-level folder for easy modifications to your own recipes.

## Example

Following is an example that initializes the build environment, selects "beaglebone"
for the machine, and chooses the "agl-demo" feature, which also includes the
"agl-appfw-smack", "agl-devel", and "agl-hmi-framework" features:

```
$ source meta-agl/scripts/aglsetup.sh -m qemux86-64 agl-demo agl-devel
aglsetup.sh: Starting
Generating configuration files:
   Build dir: /home/scottrif/workspace_agl/build
   Machine: qemux86-64
   Features: agl-appfw-smack agl-demo agl-devel
   Running /home/scottrif/workspace_agl/poky/oe-init-build-env
   Templates dir: /home/scottrif/workspace_agl/meta-agl/templates/base
   Config: /home/scottrif/workspace_agl/build/conf/bblayers.conf
   Config: /home/scottrif/workspace_agl/build/conf/local.conf
   Setup script: /home/scottrif/workspace_agl/build/conf/setup.sh
   Executing setup script ... --- beginning of setup script
 fragment /home/scottrif/workspace_agl/meta-agl/templates/base/01_setup_EULAfunc.sh
 fragment /home/scottrif/workspace_agl/meta-agl/templates/base/99_setup_EULAconf.sh
 end of setup script
OK
Generating setup file: /home/scottrif/workspace_agl/build/agl-init-build-env ... OK
aglsetup.sh: Done

 Shell environment set up for builds.

You can now run 'bitbake target'

Common targets are:
  - meta-agl:          (core system)
    agl-image-minimal
    agl-image-minimal-qa

    agl-image-ivi
    agl-image-ivi-qa
    agl-image-ivi-crosssdk

    agl-image-weston

  - meta-agl-demo:     (demo with UI)
    agl-demo-platform  (* default demo target)
    agl-demo-platform-qa
    agl-demo-platform-crosssdk

    agl-demo-platform-html5
$
```

Running the script creates the Build Directory if it does not already exist.
For this example, the Build Directory is "$AGL_TOP/workspace_agl/build".

The script's output also indicates the machine and AGL features selected for the build.

The script creates two primary configuration files used for the build: `local.conf` and `bblayers.conf`.
Both these configuration files are located in the Build Directory in the `conf` folder.
If you were to examine these files, you would find standard Yocto Project
configurations along with AGL configuration fragments, which are driven by the
machine (i.e. beaglebone) and the AGL features specified as part of the
script's command line.

The end result is configuration files specific for your build in the AGL development environment.

Finally, part of the `aglsetup.sh` script makes sure that any End User License Agreements (EULA)
are considered.
You can see that processing in the script's output as well.

**NOTE:** Use of the `local.conf` and `bblayers.conf` configuration files is fundamental
in the Yocto Project build environment.
Consequently, it is fundamental in the AGL build environment.
You can find lots of information on configuring builds in the Yocto Project
documentation set.
Here are some references if you want to dig into configuration further:

* [Customizing Images Using local.conf](https://yoctoproject.org/docs/2.4.4/dev-manual/dev-manual.html#usingpoky-extend-customimage-localconf)
* [Local](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#ref-varlocality-config-local)
* [build/conf/local.conf](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#structure-build-conf-local.conf)
* [build/conf/bblayers.conf](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#structure-build-conf-bblayers.conf)
* [BBLAYERS](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#var-BBLAYERS)
* [User Configuration](https://yoctoproject.org/docs/2.4.4/ref-manual/ref-manual.html#user-configuration)
* [Enabling Your Layer](https://yoctoproject.org/docs/2.4.4/dev-manual/dev-manual.html#enabling-your-layer)
