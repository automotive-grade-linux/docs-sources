# Verify Your Build Host

In order to build a Microservice binding natively, you need to be using a
supported Linux distribution.
In general, a recent version of Debian, Ubuntu, OpenSUSE, and Fedora works.
Following is a specific list of supported distributions:

* [Debian](https://www.debian.org/releases/) 9.0
* [Ubuntu](https://wiki.ubuntu.com/Releases) 16.04, 16.10, 17.10, and 18.04
* [OpenSUSE](https://en.opensuse.org/openSUSE:Roadmap) Leap 15.0 and Tumbleweed
* [Fedora](https://fedoraproject.org/wiki/Releases) 27, 28, 29, and Rawhide.

Exporting the `DISTRO` environment variable defines the distribution.
Following are examples:

```bash
export DISTRO="Debian_9.0"
export DISTRO="xUbuntu_16.04"
export DISTRO="xUbuntu_16.10"
export DISTRO="xUbuntu_17.10"
export DISTRO="xUbuntu_18.04"
```

Set the `DISTRO` environment appropriately.
