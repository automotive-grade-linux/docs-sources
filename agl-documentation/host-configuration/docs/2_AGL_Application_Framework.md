# AGL Application Framework

The binder provides a way to connect applications to the services that it
needs.

It provides a fast way to securely offer APIs to applications written in any
language and running almost anywhere.

## Install the AGL application framework

Use the right command line according to your distro

### **Debian**

```bash
sudo apt-get install agl-app-framework-binder-dev
```

### **openSUSE**

```bash
sudo zypper install agl-app-framework-binder-devel
```

### **Fedora**

```bash
sudo dnf install agl-app-framework-binder-devel
```

To have environment variables set correctly to be able to use app-framework-binder just after the installation, you need to either logout/login or you can just manually source this file :

```bash
source /etc/profile.d/agl-app-framework-binder.sh
```

Note that this file will be source automatically for every new session.

## AGL application framework documentation

You can find the AGL application framework documentation
 [here](http://docs.automotivelinux.org/master/docs/apis_services/en/dev/reference/af-main/0-introduction.html
).
