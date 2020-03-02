# Bringing up a CAN device using socketcan backend

* [Using a supported Linux CAN device](https://www.elinux.org/CAN_Bus):

```bash
# Find your interface name (e.g. can0)
ip link
# Configure bitrate
sudo ip link set can0 type can bitrate 1000000
# Bring the device up
sudo ip link set can0 up
# Optionally configure CAN termination
sudo ip link set can0 type can termination 1
```

## Using slcand

* Based on FTDI Serial driver
* Requires slcand to "convert" serial device to SocketCAN.
* Officially supported in Linux Kernel v2.6.38

```bash
# Create SocketCAN device from serial interface
sudo slcand -o -c -s8 -S1000000 /dev/ttyUSB0 can0
# Bring the device up
sudo ip link set can0 up
```

## Using builtin Linux kernel virtual CAN module vcan

```bash
sudo modprobe vcan
sudo ip link add dev can0 type vcan
sudo ip link set can0 up
```
