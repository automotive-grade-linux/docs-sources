# Audio System

## Overview

AGL uses the PipeWire daemon service to provide audio playback and capture
capabilities. PipeWire is accompanied by a secondary service, WirePlumber
(also referred to as the *session manager*), which provides policy management,
device discovery, configuration and more.

Applications can connect to the PipeWire service through its UNIX socket, by
using the *libpipewire* library as a front-end to that socket.

## Configuration

Currently in AGL Happy Halibut (8.0.0) there are limited configuration options
for the PipeWire audio stack. In a future release it is expected that a new
configuration mechanism will be available, with more flexibility,
comprehensibility and options.

### wireplumber.conf

The most useful configuration options for the audio stack can be found
in **/etc/wireplumber/wireplumber.conf**.

Through this file it is possible to configure:

* The default playback and capture devices:
```
  "default-playback-device": <"hw:0,0">,
  "default-capture-device": <"hw:0,0">,
```

You may change these lines to reflect the configuration of your board. The ALSA
device strings that you use there **must** start with *hw:* and **must** use
exactly 2 integer numbers, one for the device and one for the subdevice. Other
strings are not understood as of the time of writing of this document.

* The streams that are available for applications to use:
```
load-module C libwireplumber-module-mixer {
  "streams": <["Master", "Multimedia", "Navigation", "Communication", "Emergency"]>
}
...
load-module C libwireplumber-module-pw-alsa-udev {
  "streams": <["Multimedia", "Navigation", "Communication", "Emergency"]>
}
```

You may modify these arrays to include the streams that you would like to be
available on your system. These strings are matched against the strings that
the applications declare as their *role*.

*Note*: the *Master* stream on the mixer is a special stream that enables the
master volume control. Removing it will remove the ability to have a master
volume and may break applications that expect it to be available. This stream
should not be listed in the configuration for *libwireplumber-module-pw-alsa-udev*

*Note*: the stream names should be aligned everywhere they appear in this
configuration file. Listing different streams in different places may result in
undefined behaviour.

* The priorities of the roles:
```
  "role-priorities": <{
    "Multimedia": 1,
    "Communication": 5,
    "Navigation": 8,
    "Emergency": 10
  }>
```

A stream with a higher priority will always take over the audio output, pausing
any other lower priority streams in the meantime.

Currently there is no way of configuring other policy options.

### pipewire.conf

PipeWire also ships with **/etc/pipewire/pipewire.conf**, which can be used to
configure which pipewire modules are being loaded in the PipeWire deamon. You
should normally not need to modify anything there, unless you understand what
you are doing.

## APIs

### Native API - libpipewire

The main entry point for applications to access the audio system is the API
offered by *libpipewire*. The functionality offered by *libpipewire* is vast
and it is beyond the scope of this document to describe it all.

For playback and capture, applications should use *struct pw_stream* and its
associated methods. There are usage examples for it in the PipeWire
[source code](https://github.com/PipeWire/pipewire).

### Native API - GStreamer (Recommended)

For convenience, applications that use GStreamer can use the PipeWire GStreamer
elements to plug the functionality offered by *struct pw_stream* directly in
the GStreamer pipeline. These elements are called *pwaudiosrc* and *pwaudiosink*

Example:
```
gst-launch-1.0 audiotestsrc ! pwaudiosink
```

Through these elements, it is possible to specify the application role by setting
it in the *stream-properties* property of the element, as shown below:

```
gst-launch-1.0 audiotestsrc ! pwaudiosink stream-properties=p,media.role=Multimedia
```

or, in the C API:

```
gst_util_set_object_arg (sink, "stream-properties", "p,media.role=Multimedia");
```

When using these GStreamer elements, applications **should** handle the
**GST_MESSAGE_REQUEST_STATE** message on the bus and change their state accordingly.
This message will be sent when the *session manager* requests a change in the state
due to a higher priority stream taking over.

### ALSA Compatibility

AGL offers a virtual ALSA device that redirects audio to PipeWire
through an ALSA PCM plugin. This device is the default one, so unless you
explicitly specify a device in your ALSA client application, audio will go
through PipeWire instead.

This mode has limitations, however.
* There is no way to specify the role of the application. WirePlumber will
always assume it is a "Multimedia" application
* There is no way for the application to be notified when another stream
takes over. When this happens, the audio clock will simply stop progressing and
the ALSA API will likely block.

### Audiomixer service

See the separate audiomixer service documentation.

## Runtime mechanics

The PipeWire service is activated on demand, via systemd socket activation.
The WirePlumber service is always started and stopped together with the PipeWire
service.

If you wish to manually start/stop/restart the service, you can do so by using
*systemctl*:
```
systemctl start/stop/restart pipewire@1001.service
```

## Debugging

When something is wrong with the audio setup, it is useful to know how to debug
it...

### PipeWire & WirePlumber

The PipeWire and WirePlumber daemons can be configured to be more verbose
by editing **/etc/pipewire/environment**

* Set G_MESSAGES_DEBUG=all to enable WirePlumber's debug output.
* Set PIPEWIRE_DEBUG=n (n=1-5) to enable PipeWire's debug output.

All messages will be available in the systemd journal, inspectable with
journalctl.

### AGL applications & services (AppFW)

For AGL applications and services that are installed by the app framework,
you can set the *PIPEWIRE_DEBUG* environment variable in **/etc/afm/unit.env.d/pipewire**.
This will enable the debug messages that are printed by *libpipewire* and will
make them available also in the systemd journal.
