---
title: AGL - Waltham How to build
author: Veeresh Kadasani ((Advanced Driver Information Technology)
author: Naoko Tanibata (Advanced Driver Information Technology)
date: 2019-12-18

categories: architecture
tags: architecture, graphics, wayland, weston. waltham
layout: techdoc

---

**Table of Content**

1. TOC
{:toc}

## Information
Please also refer [Readme](https://gerrit.automotivelinux.org/gerrit/gitweb?p=src/weston-ivi-plugins.git;a=tree;h=refs/heads/master;hb=refs/heads/master) in source repository.

## How to build waltham-transmitter
1. Prerequisite before building
   AGL Image is already built. Please refer [here](https://docs.automotivelinux.org/docs/en/master/getting_started/reference/getting-started/image-workflow-build.html)

2. Go to AGL build folder and configure your environment.
```
       $ cd $AGL_TOP 
       $ source meta-agl/scripts/aglsetup.sh
```
3. Build waltham-transmitter by using bitbake.

Since waltham-transmitter is not built by default, this step is mandatory.

```
       $ bitbake waltham-transmitter
```

4. You can find the built results under $AGL_TOP/build/tmp/work/<board type>/waltham-transmitter/git-r0/image/
   - usr/bin/waltham-receiver
   - usr/lib/transmitter.so
   - usr/lib/waltham-renderer.so

## How to configure weston.ini and GStreamer pipeline

### weston.ini

In order to load waltham-transmitter plugin to weston, add "transmitter.so" to the "modules" key under "[core]" in weston.ini at transmitter side, 
Then make sure the "shell" is configured as "ivi-shell.so".
The destination of remoting also needs to be configured in weston.ini.
Add output name, receiver IP address, port number, output's width and height key under "[transmitter-output]". You can speficy multiple [transmitter-output] with different output-name.

```
/* Example_weston.ini - single transmitter-output */

	[core]
	shell=ivi-shell.so
	modules=systemd-notify.so,ivi-controller.so,transmitter.so

	[ivi-shell]
	ivi-module=ivi-controller.so
	ivi-input-module=ivi-input-controller.so

	[transmitter-output]
	output-name=transmitter_1
	server-address=192.168.2.52
	port=34400
	width=1920
	height=1080

```

### GStreamer pipeline

You can use GStreamer pipeline as you want. Please describe pipeline configuration in "/etc/xdg/weston/pipeline.cfg".
Here are 3 examples. 

```

/* General pipeline which does not use any HW encoder */
	appsrc name=src ! videoconvert ! video/x-raw,format=I420 ! jpegenc ! rtpjpegpay ! udpsink name=sink host=YOUR_RECIEVER_IP port=YOUR_RECIEVER_PORT sync=false async=false

/* pipeline to use Intel's HW encoder */
	appsrc name=src ! videoconvert ! video/x-raw,format=I420 ! mfxh264enc bitrate=3000000 rate-control=1 ! rtph264pay config-interval=1 ! udpsink name=sink host=YOUR_RECIEVER_IP port=YOUR_RECIEVER_PORT sync=false async=false

/* pipeline to use Rcar's HW encoder */
	appsrc name=src ! videoconvert ! video/x-raw,format=I420 ! omxh264enc bitrate=3000000 control-rate=2 ! rtph264pay ! udpsink name=sink host=YOUR_RECIEVER_IP port=YOUR_RECIEVER_PORT sync=false async=false

```

## Connection Establishment

1. Connect two boards over ethernet.
2. Assign IP to both boards. 
```Example:
	transmitter IP: 192.168.2.51
	waltham-receiver IP: 192.168.2.52
```
3. Check if the simple ping works
```
        $ ping 192.168.2.52 (you can also ping vice versa)
```

## Example steps to start remoting 

1. Start target boards.
 
transmitter side must have the above 2 files, the modified weston.ini and GStreamer pipeline,cfg.  
You can confirm that transmitter is loaded properly from weston log as below.

```
/* Example(/run/platform/display/weston.log) */
	[12:28:09.127] Loading module '/usr/lib/weston/transmitter.so'
	[12:28:09.182] Registered plugin API 'transmitter_v1' of size 88
	[12:28:09.183] Registered plugin API 'transmitter_ivi_v1' of size 16
	[12:28:09.186] Loading module '/usr/lib/libweston-6/waltham-renderer.so'
	[12:28:09.255] Transmitter initialized.
	[12:28:09.255] transmitter_output_attach_head is called
	[12:28:09.255] Weston head attached successfully to output
	[12:28:09.255] Output 'transmitter-192.168.2.52:34400-1' enabled with head(s) transmitter-192.168.2.52:34400-1
	[12:28:09.255] Transmitter weston_seat 0xaaab2209c800
	[12:28:09.255] Transmitter created pointer=0xaaab220e6b50 for seat 0xaaab2209c800
	[12:28:09.255] Transmitter created keyboard=0xaaab22038e60 for seat 0xaaab2209c800
	[12:28:09.255] Transmitter created touch=0xaaab220c7930 for seat 0xaaab2209c800
```

2. [receiver side] Start receiver application. 

The below example shows the case if you use waltham-receiver as receiver application.

1. Add surface to the display where you want to receive transmitted contents.   
You can check which output name is required by using the command "LayerManagerControl get scene". 

```
	$ layer-add-surfaces -s <surface count> -l <layer id> -d <output display name> &
/* Example */
	$ layer-add-surfaces -s 1 -l 1 -d HDMI-A-1 &
```
2. Start waltham-receiver. You can use debug option with "-v" if you want.
```	
 	$ waltham-receiver -p 34400 -v &
```

3. Now, receiver side is waiting for the contents coming from transmitter side.

**You must configure and start receiver side first.**

4. [transmitter side] Start an IVI application
5. Put the surface of IVI application onto transmitter-output by using LayerManagerControl command.
This surface will be transmitted.

```
	$ layer-add-surfaces -d <transmitter -output name> -s <surface count on receiver> -l <layer id on receiver>
/* Example */
	$ layer-add-surfaces -d transmitter-192.168.2.52:34400-1 -s 1 -l 1 &
```

5. [transmitter side] make sure that weston.log shows remoting has been started.

```
/* Example(/run/platform/display/weston.log) */
	[12:29:33.224] surface ID 1
	[12:29:40.622] gst-setting are :-->
	[12:29:40.622] ip = 192.168.2.52
	[12:29:40.622] port = 34400
	[12:29:40.622] bitrate = 3000000
	[12:29:40.622] width = 1080
	[12:29:40.622] height = 1920
	[12:29:42.177] Parsing GST pipeline:appsrc name=src ! videoconvert ! video/x-raw,format=I420 ! jpegenc ! rtpjjpegpay ! udpsink name=sink host=192.168.2.52 port=3440 sync=false async=false
```

## Typical issues & Tips

### help functions
You can find the help information of LayerManagerControl command by using

``` 
$ LayerManagerControl help
```

### waltham-transmitter and waltham-receiver doesn't communicate
1. Please check ethernet connection. If you assign 192.168.2.51 and 192.168.2.52 for waltham-transmitter and waltham-receiver, you shall ping vice versa.

``` 
/* At waltham-transmitter side */
	$ ping 192.168.2.52 

/* At waltham-receiver side */
	$ ping 192.168.2.51 
```

2. Make sure that IP address specified in the weston.ini under [transmitter-output] matches the waltham-receiver IP address.  
3. Make sure that IP address in pipeline.cfg on the transmitter side match the waltham-receiver's IP address.

### surface,layer or output information is unknown.
You can check them by using the below command.

```	
	$ LayerManagerControl get scene

/* Example */
	screen 0 (0x0)
	---------------------------------------
	- connector name:       HDMI-A-1
	- resolution:           x=1024, y=768
	- layer render order:   100(0x64), 
	
	    layer 100 (0x64)
	    ---------------------------------------
	    - destination region:   x=296, y=0, w=432, h=768
	    - source region:        x=0, y=0, w=432, h=768
	    - opacity:              1
	    - visibility:           1
	    - surface render order: 1(0x1), 
	    - on screen:            0(0x0) 
	
	        surface 1 (0x1)
	        ---------------------------------------
			- created by pid:       3338
	        - original size:      x=432, y=768
	        - destination region: x=0, y=0, w=432, h=768
    	    - source region:      x=0, y=0, w=432, h=768
        	- opacity:            1
			- visibility:         1
    	    - frame counter:      47
			- on layer:           100(0x64) 

	screen 1 (0x1)
	---------------------------------------
	- connector name:       transmitter-192.168.2.52:34400-1
	- resolution:           x=1920, y=1080
	- layer render order: 
	
	/* You can know the output name for remoting is "transmitter-192.168.2.52:34400-1" */
```
