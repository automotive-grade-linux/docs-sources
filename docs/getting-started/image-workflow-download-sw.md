# 2 Downloading AGL Software

Once you have determined the build host can build an AGL image,
you need to download the AGL source files.
The AGL source files, which includes the Yocto Project layers, are
maintained on the AGL Gerrit server.
For information on how to create accounts for Gerrit, see the
[Getting Started with AGL](https://wiki.automotivelinux.org/start/getting-started)
wiki page.

The remainder of this section provides steps on how to download the AGL source files:

1. **Define Your Top-Level Directory:**
   You can define an environment variable as your top-level AGL workspace folder.
   Following is an example that defines the `$HOME/workspace_agl` folder using
   an environment variable named "AGL_TOP":

   ```bash
   $ export AGL_TOP=$HOME/workspace_agl
   $ mkdir -p $AGL_TOP
   ```

2. **Download the `repo` Tool and Set Permissions:**
   AGL Uses the `repo` tool for managing repositories.
   Use the following commands to download the tool and then set its
   permissions to allow for execution:

   ```bash
   $ mkdir -p ~/bin
   $ export PATH=~/bin:$PATH
   $ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
   $ chmod a+x ~/bin/repo
   ```

   **NOTE:** See the
   "[Repo Command Reference](https://source.android.com/setup/develop/repo)"
   for more information on the `repo` tool.

3. **Download the AGL Source Files:**
   Depending on your development goals, you can either download the
   latest stable AGL release branch, or the "cutting-edge" (i.e. "master"
   branch) files.

   * **Stable Release:**
     Using the latest stable release gives you a solid snapshot of the
     latest know release.
     The release is static, tested, and known to work.
     To download the latest stable release branch (i.e. Flounder 6.0), use
     the following commands:

     ```bash
     $ cd $AGL_TOP
     $ repo init -b flounder -u https://gerrit.automotivelinux.org/gerrit/AGL/AGL-repo
     $ repo sync
     ```

   * **Cutting-Edge Files:**
     Using the "cutting-edge" AGL files gives you a snapshot of the
     "master" directory.
     The resulting local repository you download is dynamic and can become
     out-of-date with the upstream repository depending on community contributions.
     The advantage of using "cutting-edge" AGL files is that you have the
     absolute latest features, which are often under development, for AGL.

     To download the "cutting-edge" AGL files, use the following commands:

     ```bash
     $ cd $AGL_TOP
     $ repo init -u https://gerrit.automotivelinux.org/gerrit/AGL/AGL-repo
     $ repo sync
     ```

   Once you `sync` the repository, you have the AGL files in the form of
   "layers" (e.g. `meta-*` folders).
   You also have the `poky` repository in your AGL workspace.

   Listing out the resulting directory structure appears as follows:

   ```
   $ tree -L 1
   .
   ├── build
   ├── meta-agl
   ├── meta-agl-demo
   ├── meta-agl-devel
   ├── meta-agl-extra
   ├── meta-altera
   ├── meta-boundary
   ├── meta-freescale
   ├── meta-freescale-3rdparty
   ├── meta-freescale-distro
   ├── meta-intel
   ├── meta-intel-iot-security
   ├── meta-oic
   ├── meta-openembedded
   ├── meta-qcom
   ├── meta-qt5
   ├── meta-raspberrypi
   ├── meta-renesas
   ├── meta-renesas-rcar-gen3
   ├── meta-rust
   ├── meta-sdl
   ├── meta-security-isafw
   ├── meta-ti
   ├── meta-updater
   ├── meta-virtualization
   └── poky
   ```
