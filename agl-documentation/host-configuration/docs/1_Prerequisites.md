# Prerequisites for package installation

There are different repos for AGL packages depending on the version, it is
possible to install all of them and switching between them.

To install latest (master) version you must set REVISION variable as follow :

```bash
export REVISION=Master
```

You can find all available repos [here](https://build.opensuse.org/project/subprojects/isv:LinuxAutomotive#).

For more details about OBS, please visit [LinuxAutomotive page on OBS](https://build.opensuse.org/project/show/isv:LinuxAutomotive).

## Add repo for debian distro

Avalable distro values are

```bash
export DISTRO="Debian_9.0"
export DISTRO="xUbuntu_16.04"
export DISTRO="xUbuntu_16.10"
export DISTRO="xUbuntu_17.10"
export DISTRO="xUbuntu_18.04"
```

Install the repository:

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

## Add repo for openSuse distro

```bash
#available distro values are openSUSE_Leap_42.3 openSUSE_Tumbleweed
export REVISION=Master
source /etc/os-release; export DISTRO=$(echo $PRETTY_NAME | sed "s/ /_/g")
sudo zypper ar http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_${REVISION}/${DISTRO}/isv:LinuxAutomotive:AGL_${REVISION}.repo
sudo zypper --gpg-auto-import-keys ref
```

## Add repo for fedora distro

```bash
#available distro values are Fedora_27 Fedora_28 Fedora_Rawhide
export REVISION=Master
source /etc/os-release ; export DISTRO="${NAME}_${VERSION_ID}"
sudo wget -O /etc/yum.repos.d/isv:LinuxAutomotive:AGL_${REVISION}.repo http://download.opensuse.org/repositories/isv:/LinuxAutomotive:/AGL_${REVISION}/${DISTRO}/isv:LinuxAutomotive:AGL_${REVISION}.repo
```

## Switch between repos

First, let's check our installed AGL repos.

### Debian distro

```bash
cat /etc/apt/sources.list.d/AGL.list
```

### openSuse distro

```bash
zypper repos | grep AGL
```

### Fedora distro

```bash
dnf repolist --all | grep AGL
```

Make sure that you have what you need installed.
With the commands above you should see which repos are enabled/disabled.
To switch between two repos you just have to disable your current AGL repo and
enable the wanted repo.
It's a little bit different for Debian distros, see the example right down
below.

### Example for Debian distro

I'm on Master and I want an ElectricEel revision.

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

I want my master repo enabled. Here ElectricEel repo is at the 4th line and Master at 5th line, so we have to enter:

```bash
$ sudo zypper mr -d 4 && sudo zypper mr -e 5
Repository 'isv_LinuxAutomotive_AGL_ElectricEel' has been successfully disabled.
Repository 'isv_LinuxAutomotive_AGL_Master' has been successfully enabled.
sudo zypper refresh
```

In this command "-d" stands for disable and "-e" enable

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

I want my ElectricEel repo enabled.

```bash
dnf config-manager --set-disabled isv_LinuxAutomotive_AGL_Master
dnf config-manager --set-enabled isv_LinuxAutomotive_AGL_FunkyFlounder
```

```bash
$ dnf repolist --all | grep AGL
isv_LinuxAutomotive_AGL_FunkyFlounder       isv:LinuxAutomotive:AGL enabled
isv_LinuxAutomotive_AGL_Master            Automotive Grade Linux  disabled
```

Now you have to [install the app-framework-binder](http://docs.automotivelinux.org/master/docs/devguides/en/dev/reference/host-configuration/docs/2_AGL_Application_Framework.html)
