# Setting up your operating system

In this section, we describe the Docker installation procedure depending
on your host system. We will be focusing on the most popular systems;
for a full list of supported operating systems, please refer to Docker
online documentation: [https://docs.docker.com/](https://docs.docker.com/)

## Linux (Ubuntu / Debian)

At the time of writing, Docker project supports these Ubuntu/Debian
releases:

- Ubuntu Yakkety 16.10
- Ubuntu Xenial 16.04 LTS
- Ubuntu Trusty 14.04 LTS
- Debian 8.0 (64-bit)
- Debian 7.7 (64-bit)

For an updated list of supported distributions, you can refer to the
Docker project website, at these locations:

- [https://docs.docker.com/engine/installation/linux/debian/](https://docs.docker.com/engine/installation/linux/debian/)
- [https://docs.docker.com/engine/installation/linux/ubuntu/](https://docs.docker.com/engine/installation/linux/ubuntu/)

Here are the commands needed to install the Docker engine on your local
host:

```bash
sudo apt-get update
sudo apt-get install wget curl
wget -qO- https://get.docker.com/ | sh
```

This will register a new location in your "sources.list" file and
install the "docker.io" package and its dependencies:

```bash
$ cat /etc/apt/sources.list.d/docker.list
$ deb [arch=amd64] https://apt.dockerproject.org/repo ubuntu-xenial main
$ docker --version
Docker version 17.03.0-ce, build 60ccb22
```

It is then recommended to add your user to the new "docker" system
group:

```bash
sudo usermod -aG docker *<your-login>*
```

... and after that, to log out and log in again to have these credentials
applied.

You can reboot your system or start the Docker daemon using:

```bash
sudo service docker start
```

If everything went right, you should be able to list all locally
available images using:

```bash
$ docker images
REPOSITORY TAG IMAGE ID CREATED VIRTUAL SIZE
```

In our case, no image is available yet, but the environment is ready to
go on.

A SSH client must also be installed:

```bash
sudo apt-get install openssh-client
```

## Windows © (7, 8, 8.1, 10)

**WARNING: although Windows© can work for this purpose, not only are lots
of additional steps needed, but the build process performance itself is
suboptimal. Please consider moving to Linux for a better experience.**

We will be downloading the latest Docker Toolbox at the following
location:

[*https://www.docker.com/docker-toolbox*](https://www.docker.com/docker-toolbox)

and by clicking on the "*Download (Windows)*" button:

![window install windows 1](pictures/docker_install_windows_1.png)\
We will answer "Yes", "Next" and "Install" in the next dialog boxes.

![window install windows 2](pictures/docker_install_windows_2.png){style width:60%;}

![window install windows 3](pictures/docker_install_windows_3.png){style width:48%; float:left; margin-right:0.3em}
![window install windows 4](pictures/docker_install_windows_4.png){style width:48%; float:right}

![window install windows 5](pictures/docker_install_windows_5.png)

We can then start it by double-clicking on the "Docker Quickstart
Terminal" icon:

![window install windows 6](pictures/docker_install_windows_6.png)

It will take a certain amount time to setup everything, until this
banner appears:

![window install windows 7](pictures/docker_install_windows_7.png)

Docker Toolbox provides a 1 Gb RAM/20 Go HDD virtual machine; this is
clearly insufficient for our needs. Let us expand it to 4 Gb RAM/50
HDD (*these are minimal values; feel free to increase them if your computer
has more physical memory and/or free space*) :

```bash
export VBOXPATH=/c/Program\ Files/Oracle/VirtualBox/
export PATH="$PATH:$VBOXPATH"

docker-machine stop default

VBoxManage.exe modifyvm default --memory 4096
VBoxManage.exe createhd --filename build.vmdk --size 51200 --format VMDK
VBoxManage.exe storageattach default --storagectl SATA --port 2 --medium build.vmdk --type hdd

docker-machine start default

docker-machine ssh default "sudo /usr/local/sbin/parted --script /dev/sdb mklabel msdos"
docker-machine ssh default "sudo /usr/local/sbin/parted --script /dev/sdb mkpart primary ext4 1% 99%"
docker-machine ssh default "sudo mkfs.ext4 /dev/sdb1"
docker-machine ssh default "sudo mkdir /tmp/sdb1"
docker-machine ssh default "sudo mount /dev/sdb1 /tmp/sdb1"
docker-machine ssh default "sudo cp -ra /mnt/sda1/* /tmp/sdb1"

docker-machine stop default

VboxManage.exe storageattach default --storagectl SATA --port 2 --medium none
VboxManage.exe storageattach default --storagectl SATA --port 1 --medium build.vmdk --type hdd

docker-machine start default
```

We will then finalize the setup:

```bash
VboxManage.exe modifyvm default --natpf1 sshredir,tcp,127.0.0.1,2222,,2222
docker-machine start default
docker-machine ssh default "echo mkdir /sys/fs/cgroup/systemd | sudo tee /var/lib/boot2docker/bootlocal.sh"
docker-machine restart default
```

A SSH client must also be installed. We will grab *PuTTY* at the
following URL:
[*http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe*](http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe)

## Mac OS X ©

We will be downloading the latest Docker Toolbox at the following
location:
[https://www.docker.com/docker-toolbox](https://www.docker.com/docker-toolbox)

and by clicking on the "*Download (Mac)*" button:

![window install macro 1](pictures/docker_install_macos_1.png)

We will answer "Continue" and "Install" in the next dialog boxes:

![window install macro 2](pictures/docker_install_macos_2.png)

![window install macro 3](pictures/docker_install_macos_3.png){style width:80%;}
![window install macro 4](pictures/docker_install_macos_4.png){style width:80%;}

Then, when we go to our "Applications" folder, we now have a "Docker"
subfolder where we can start "Docker Quickstart Terminal":

![window install macro 5](pictures/docker_install_macos_5.png)

It will take a certain amount of time to setup everything, until this
banner appears:

![window install macro 6](pictures/docker_install_macos_6.png)

Docker Toolbox provides a 1 Gb RAM/20 Go HDD virtual machine; this is
clearly insufficient for our needs. Let us expand it to 4 Gb RAM/50
HDD (*these are minimal values; feel free to increase them if your computer
has more physical memory and/or free space*) :

```bash
docker-machine stop default

VboxManage modifyvm default --memory 4096
VboxManage createhd --filename build.vmdk --size 51200 --format VMDK
VboxManage storageattach default --storagectl SATA --port 2 --medium build.vmdk --type hdd

docker-machine start default

docker-machine ssh default "sudo /usr/local/sbin/parted --script /dev/sdb mklabel msdos"
docker-machine ssh default "sudo /usr/local/sbin/parted --script /dev/sdb mkpart primary ext4 1% 99%"
docker-machine ssh default "sudo mkfs.ext4 /dev/sdb1"
docker-machine ssh default "sudo mkdir /tmp/sdb1"
docker-machine ssh default "sudo mount /dev/sdb1 /tmp/sdb1"
docker-machine ssh default "sudo cp -ra /mnt/sda1/* /tmp/sdb1"

docker-machine stop default

VboxManage storageattach default --storagectl SATA --port 2 --medium none
VboxManage storageattach default --storagectl SATA --port 1 --medium build.vmdk --type hdd

docker-machine start default
```

We will then finalize the setup:

```bash
VboxManage modifyvm default --natpf1 sshredir,tcp,127.0.0.1,2222,,2222
docker-machine ssh default "echo mkdir /sys/fs/cgroup/systemd | sudo tee /var/lib/boot2docker/bootlocal.sh"
docker-machine restart default
```
