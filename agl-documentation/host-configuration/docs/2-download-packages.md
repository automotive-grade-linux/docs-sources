# Download Packages

Different repositories exist for different AGL releases.\
You need to download and install the packages based on your version
of AGL.

## Set the `REVISION` Environment Variable

All the packages reside in repositories managed by the
[OpenSUSE Build Service (OBS)](https://build.opensuse.org/).\
You can see the packages
[here](https://build.opensuse.org/project/subprojects/isv:LinuxAutomotive#).

Currently, support exists for the following AGL releases:

* ElectricEel
* FunkyFlounder
* GrumpyGuppy
* HappyHalibut
* Master

You need to set the `REVISION` environment variable to the AGL release you
are using.\
For this example, set and export `REVISION` as "Master".

```bash
export REVISION=Master
```

For additional details about OBS, see
[LinuxAutomotive page on OBS](https://build.opensuse.org/project/show/isv:LinuxAutomotive).

## Make Sure Your `DISTRO` Environment Variable is Set

The `DISTRO` environment variable needs to be correctly set for your
Linux distribution.\
See the
"[Verify Your Build Host](./1-verify-build-host.html)"
section for information on how to set this variable.

## Install the Repository

```bash
Hit:1 https://deb.nodesource.com/node_10.x xenial InRelease
Hit:2 https://download.docker.com/linux/ubuntu xenial InRelease
Hit:3 http://security.ubuntu.com/ubuntu xenial-security InRelease
Hit:4 http://us.archive.ubuntu.com/ubuntu xenial InRelease
Ign:5 http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_FunkyFlounder/xUbuntu_16.04 ./ InRelease
Hit:6 http://us.archive.ubuntu.com/ubuntu xenial-updates InRelease
Hit:7 http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_FunkyFlounder/xUbuntu_16.04 ./ Release
Hit:8 http://us.archive.ubuntu.com/ubuntu xenial-backports InRelease
Reading package lists... Done
```

Not sure why you get the `Ign` on line 5.\
I guess InRelease does not exist.

If you don't have a `/etc/apt/sources.list.d/AGL.list` file to even start with,
and you run through the whole thing, you get the following output:

```bash
$ sudo apt-get update
Hit:1 https://deb.nodesource.com/node_10.x xenial InRelease
Hit:2 https://download.docker.com/linux/ubuntu xenial InRelease
Hit:3 http://us.archive.ubuntu.com/ubuntu xenial InRelease
Get:4 http://us.archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
Get:5 http://security.ubuntu.com/ubuntu xenial-security InRelease [107 kB]
Ign:6 http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_FunkyFlounder/xUbuntu_16.04 ./ InRelease
Hit:7 http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_FunkyFlounder/xUbuntu_16.04 ./ Release
Get:9 http://us.archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]
Get:10 http://us.archive.ubuntu.com/ubuntu xenial-updates/main amd64 Packages [902 kB]
Fetched 1,225 kB in 1s (803 kB/s)
Reading package lists... Done
```

Following are example commands that show how to install the package repository
based on various values of `DISTRO` and `REVISION`:

### Ubuntu and "Master"

```bash
export REVISION=Master
export DISTRO="xUbuntu_18.04"
wget -O - http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_${REVISION}/${DISTRO}/Release.key | sudo apt-key add -
sudo bash -c "cat >> /etc/apt/sources.list.d/AGL.list <<EOF
#AGL
deb http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_${REVISION}/${DISTRO}/ ./
EOF"
sudo apt-get update
```

You can see the installed repository using the following command:

```bash
cat /etc/apt/sources.list.d/AGL.list
```

### OpenSUSE and "Master"

```bash
export DISTRO="openSUSE_Leap_15.0"
export REVISION=Master
source /etc/os-release; export DISTRO=$(echo $PRETTY_NAME | sed "s/ /_/g")
sudo zypper ar http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_${REVISION}/${DISTRO}/isv:LinuxAutomotive:AGL_${REVISION}.repo
sudo zypper --gpg-auto-import-keys ref
```

You can see the installed repository using the following command:

```bash
zypper repos | grep AGL
```

### Fedora and "Master"

```bash
export DISTRO="Fedora_28"
export REVISION=Master
source /etc/os-release ; export DISTRO="${NAME}_${VERSION_ID}"
sudo wget -O /etc/yum.repos.d/isv:LinuxAutomotive:AGL_${REVISION}.repo http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_${REVISION}/${DISTRO}/isv:LinuxAutomotive:AGL_${REVISION}.repo
```

You can see the installed repository using the following command:

```bash
dnf repolist --all | grep AGL
```

## Switching Between Repositories

The commands in the previous section showed you how to install the packages
from a specific repository and how to verify whether or not the packages
are enabled or disabled.
You can switch between different repositories.
You must disable your current AGL repository and then enable the repository
designated for the switch.

Following is an example for Debian distributions:

### Example for Debian distro

Suppose you are on "master" and you want the "ElectricEel" AGL revision.

```bash
export OLDR=Master
export NEWR=ElectricEel
sudo sed -i "s/${OLDR}/${NEWR}/g" /etc/apt/sources.list.d/AGL.list
sudo apt-get update
```

### Example for openSuse distro

```bash
#  | Alias                               | Name                                                                                      | Enabled | GPG Check | Refresh
---+-------------------------------------+-------------------------------------------------------------------------------------------+---------+-----------+--------
 1 | Atom                                | Atom Editor                                                                               | Yes     | (r ) Yes  | No
 2 | code                                | Visual Studio Code                                                                        | Yes     | (r ) Yes  | No
 3 | http-ftp.uni-erlangen.de-e3cebb6d   | Packman Repository                                                                        | Yes     | (r ) Yes  | Yes
 4 | isv_LinuxAutomotive_AGL_ElectricEel | isv:LinuxAutomotive:AGL_ElectricEel (openSUSE_Leap_15.0)                                  | Yes     | (r ) Yes  | No
 5 | isv_LinuxAutomotive_AGL_Master      | Automotive Grade Linux Application Development tools - master branch (openSUSE_Leap_15.0) | No      | ----      | ----
 6 | openSUSE-Leap-15.0-1                | openSUSE-Leap-15.0-1                                                                      | No      | ----      | ----
 7 | repo-debug                          | openSUSE-Leap-15.0-Debug                                                                  | No      | ----      | ----
 8 | repo-debug-non-oss                  | openSUSE-Leap-15.0-Debug-Non-Oss                                                          | No      | ----      | ----
 9 | repo-debug-update                   | openSUSE-Leap-15.0-Update-Debug                                                           | No      | ----      | ----
10 | repo-debug-update-non-oss           | openSUSE-Leap-15.0-Update-Debug-Non-Oss                                                   | No      | ----      | ----
11 | repo-non-oss                        | openSUSE-Leap-15.0-Non-Oss                                                                | Yes     | (r ) Yes  | Yes
12 | repo-oss                            | openSUSE-Leap-15.0-Oss                                                                    | Yes     | (r ) Yes  | Yes
13 | repo-source                         | openSUSE-Leap-15.0-Source                                                                 | No      | ----      | ----
14 | repo-source-non-oss                 | openSUSE-Leap-15.0-Source-Non-Oss                                                         | No      | ----      | ----
15 | repo-update                         | openSUSE-Leap-15.0-Update                                                                 | Yes     | (r ) Yes  | Yes
16 | repo-update-non-oss                 | openSUSE-Leap-15.0-Update-Non-Oss                                                         | Yes     | (r ) Yes  | Yes
```

Now, you want your "master" repository enabled.
In the above output, the "ElectricEel" repository is at the fourth line
and the "master" repository is at the fifth line.
Thus, enter the following:

```bash
$ sudo zypper mr -d 4 && sudo zypper mr -e 5
Repository 'isv_LinuxAutomotive_AGL_ElectricEel' has been successfully disabled.
Repository 'isv_LinuxAutomotive_AGL_Master' has been successfully enabled.
sudo zypper refresh
```

**NOTE:** In the previous command, the "-d" option is used for "disable" and the
"-e" option is used for "enable".

Following are the results:

```bash
#  | Alias                               | Name                                                                                      | Enabled | GPG Check | Refresh
---+-------------------------------------+-------------------------------------------------------------------------------------------+---------+-----------+--------
 1 | Atom                                | Atom Editor                                                                               | Yes     | (r ) Yes  | No
 2 | code                                | Visual Studio Code                                                                        | Yes     | (r ) Yes  | No
 3 | http-ftp.uni-erlangen.de-e3cebb6d   | Packman Repository                                                                        | Yes     | (r ) Yes  | Yes
 4 | isv_LinuxAutomotive_AGL_ElectricEel | isv:LinuxAutomotive:AGL_ElectricEel (openSUSE_Leap_15.0)                                  | No      | ----      | ----
 5 | isv_LinuxAutomotive_AGL_Master      | Automotive Grade Linux Application Development tools - master branch (openSUSE_Leap_15.0) | Yes     | (r ) Yes  | No
 6 | openSUSE-Leap-15.0-1                | openSUSE-Leap-15.0-1                                                                      | No      | ----      | ----
 7 | repo-debug                          | openSUSE-Leap-15.0-Debug                                                                  | No      | ----      | ----
 8 | repo-debug-non-oss                  | openSUSE-Leap-15.0-Debug-Non-Oss                                                          | No      | ----      | ----
 9 | repo-debug-update                   | openSUSE-Leap-15.0-Update-Debug                                                           | No      | ----      | ----
10 | repo-debug-update-non-oss           | openSUSE-Leap-15.0-Update-Debug-Non-Oss                                                   | No      | ----      | ----
11 | repo-non-oss                        | openSUSE-Leap-15.0-Non-Oss                                                                | Yes     | (r ) Yes  | Yes
12 | repo-oss                            | openSUSE-Leap-15.0-Oss                                                                    | Yes     | (r ) Yes  | Yes
13 | repo-source                         | openSUSE-Leap-15.0-Source                                                                 | No      | ----      | ----
14 | repo-source-non-oss                 | openSUSE-Leap-15.0-Source-Non-Oss                                                         | No      | ----      | ----
15 | repo-update                         | openSUSE-Leap-15.0-Update                                                                 | Yes     | (r ) Yes  | Yes
16 | repo-update-non-oss                 | openSUSE-Leap-15.0-Update-Non-Oss                                                         | Yes     | (r ) Yes  | Yes
```

### Example for Fedora distro

```bash
isv_LinuxAutomotive_AGL_FunkyFlounder       isv:LinuxAutomotive:AGL disabled
isv_LinuxAutomotive_AGL_Master            Automotive Grade Linux  enabled
```

The following commands enable the "ElectricEel" repository:

```bash
dnf config-manager --set-disabled isv_LinuxAutomotive_AGL_Master
dnf config-manager --set-enabled isv_LinuxAutomotive_AGL_FunkyFlounder
```

```bash
$ dnf repolist --all | grep AGL
isv_LinuxAutomotive_AGL_FunkyFlounder       isv:LinuxAutomotive:AGL enabled
isv_LinuxAutomotive_AGL_Master            Automotive Grade Linux  disabled
```
