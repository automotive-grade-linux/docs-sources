# PipeWire Audio System Overview

## Overview

AGL uses the PipeWire daemon service to provide audio playback and capture
capabilities. PipeWire is accompanied by a secondary service, WirePlumber
(also referred to as the *session manager*), which provides policy management,
device discovery, configuration and more.

Applications can connect to the PipeWire service through its UNIX socket, by
using the *libpipewire* library as a front-end to that socket.

## Configuration

The Audio System's configuration is mainly done in the session manager.
The session manager is the service that dictates policy, therefore this is
the place to configure options such as device properties, device priorities
and application linking policy.

An extensive listing of configuration options for the session manager,
WirePlumber, is available in the next chapter,
[Session Manager Configuration](./wireplumber_configuration.md)

### wireplumber-cli

WirePlumber supports runtime configuration of devices, through the
`wireplumber-cli` tool. This tool supports the following sub-commands:

* `wireplumber-cli ls-endpoints`:
   This lists all the known audio endpoints, including devices and applications
   that are streaming. In front of the devices, there is a `*` (star) character
   on the "default" device, i.e. the device that is chosen by default to link
   applications to. The volume and mute status of the devices is also shown.
* `wireplumber-cli set-default [id]`:
   Changes the default endpoint of a specific category (capture or playback,
   determined automatically by the endpoint's type)
   and sets it to be the endpoint with the specified `[id]`. The id is the
   number shown in front of each endpoint's name in `ls-endpoints`.
* `wireplumber-cli set-volume [id] [vol]`:
   Sets the volume of `[id]` to `[vol]`. `[vol]` must be a floating point
   number between 0.0 (0%) and 1.0 (100%).
* `wireplumber-cli device-node-props`:
   Lists all the properties of the device nodes, useful for writing `.endpoint`
   configuration files, as discussed in the _Session Management Configuration_
   chapter.

Due to a system limitation, before running this tool on the command line,
you need to export the `XDG_RUNTIME_DIR` environment variable, like this:

```
export XDG_RUNTIME_DIR=/run/user/1001
```

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
[source code](https://gitlab.freedesktop.org/pipewire/pipewire).

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

See the separate
[agl-service-audiomixer](https://git.automotivelinux.org/apps/agl-service-audiomixer/about/)
documentation.

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

* Set `G_MESSAGES_DEBUG=all` to enable WirePlumber's debug output.
* Set `PIPEWIRE_DEBUG=n` (n=1-5) to enable PipeWire's debug output.

All messages will be available in the systemd journal, inspectable with
journalctl.

`PIPEWIRE_DEBUG` can be set to a value between 1 and 5, with 5 being the
most verbose and 1 the least verbose.

### AGL applications & services (AppFW)

For AGL applications and services that are installed by the app framework,
you can set the *PIPEWIRE_DEBUG* environment variable in **/etc/afm/unit.env.d/pipewire**.
This will enable the debug messages that are printed by *libpipewire* and will
make them available also in the systemd journal.
