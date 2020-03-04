# Troubleshooting

This topic describes various areas that could cause you problems. 

## Including Extended Attributes

The
[Extended Attributes Set (`xattrs`)](https://linux-audit.com/using-xattrs-extended-attributes-on-linux/)
associated with the image during its construction must be copied to
the bootable media.
The `xattrs` supports
[Smack](https://en.wikipedia.org/wiki/Smack_(software)), which is a
Simplified Mandatory Access Control kernel.

**NOTE:** See
  [https://www.kernel.org/doc/Documentation/security/Smack.txt](https://www.kernel.org/doc/Documentation/security/Smack.txt).
  for detailed information on Smack.

**NOTE:** This is a required feature.

Many methods exist that allow you to create bootable media (e.g. `dd`, `bmaptools`,
`tar`).
It is recommended that you do not use `tar` to create bootable media.
However, if you do, you must take these steps to copy `xattrs` to the media:

1. Verify your `tar` version is 1.28 or newer:

   ```bash
   $ tar --version
   tar (GNU tar) 1.28
   [snip]
   ```

2. Optionally update `tar` if required.
   Most systems come with `tar` installed.
   If you need to install it, see the
   "[Installing tar](https://www.howtoforge.com/tutorial/linux-tar-command/#installing-tar)"
   section for instructions.

   When you build an AGL distribution, a native up-to-date version of
   `tar` is created.
   Use the following command to see that version:

   ```bash
   $ tmp/sysroots/x86_64-linux/usr/bin/tar-native/tar --version
   tar (GNU tar) 1.28
   [snip]
   ```

3. Copy the AGL files and Extended Attributes Set to your bootable media:

   ```bash
   $ tar --extract --xz --numeric-owner --preserve-permissions --preserve-order --totals \
              --xattrs-include='*' --directory=DESTINATION_DIRECTORY --file=agl-demo-platform.....tar.xz
   ```

## Screen orientation for Splash and in Weston

Depending of your scren mounting the default orientation of the UI an/or splash screen might be incorrect.
To change the orientation of the splash screen patch

```bash
File: /etc/systemd/system/sysinit.target.wants/psplash-start.service
Line:  ExecStart=/usr/bin/psplash -n -a 90
```

To change the orientation of the UI in Weston patch

```bash
File: /etc/xdg/weston/weston.ini
Line: transform=90
```

## Adding media files to play with MediaPlayer

AGL include the default MediaPlayer sample app which can be used to play music. The `lightmediascanner.service` by default will search for media under the `/media` folder. So if you plug in any USB stick containing music, they would be recognized and showed in the playlist of the MediaPlayer app menu.

The current supported format is OGG. Please convert your files to ogg to play with MediaPlayer.

**NOTE**: mp3 is not found by default. For this you need to enable the flags for mp3 support.

In case you want to store music in another place, modify the `/usr/lib/systemd/user/lightmediascanner.service` file and change the `--directory` parameter to the path of that folder.

If you don’t want to touch the ligthmediascanner service, you can also add a folder named "Music" under `/home/1001/Music` and put your music files there.

## Configuring the Audio hardware

AGL uses alsa as Audio configuration master. If the correct HW is not setup, the Audio system will fail to start what will also fails the demo Home Screen launch.
You need to configure Audio in

* pipewire

### pipewire

AGL does use the new pipewire infrastructure for sound.
The configuration is in:

* `/etc/pipewire/`
and
* `/etc/wireplumber/`

Please see https://git.automotivelinux.org/AGL/meta-agl-devel/tree/meta-pipewire/recipes-multimedia/wireplumber/wireplumber-board-config-agl .

