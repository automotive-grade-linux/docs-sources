# Add a CAN device in CANdevStudio

Start a new project and grab a ***CanDevice*** from the left pane in the
***Device Layer*** section and drop it on the grid workspace. Right-Click on it
and open its ***Properties***. Here you have to set the ***backend*** and the
***interface*** name you'll want to use. Backend available are:

- socketcan: CAN stack present by default in the Linux Kernel. This use Linux socket and open source CAN device driver (More information here).
- systeccan: CAN bus backend using the SYS TEC CAN adapters.
- peakcan: CAN bus plugin using the PEAK CAN adapters.
- tinycan: CAN bus plugin using the MHS CAN adapters.
- vectorcan: CAN bus plugin using the Vector CAN adapters.

More details about CANdevStudio CAN bus support [here](http://doc.qt.io/qt-5.10/qtcanbus-backends.html).

***Interface*** is the name of the device you want to use. Bring up your CAN device and use the following command to find out which one are available:

```bash
ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s25: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 90:b1:1c:6b:b2:21 brd ff:ff:ff:ff:ff:ff
3: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:56:86:80 brd ff:ff:ff:ff:ff:ff
4: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr0 state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:56:86:80 brd ff:ff:ff:ff:ff:ff
5: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
    link/ether 02:42:81:38:a8:75 brd ff:ff:ff:ff:ff:ff
12: can0: <NOARP,UP,LOWER_UP> mtu 72 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/can
```
