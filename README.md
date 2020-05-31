For brightness controls

make a xorg.conf file in /etc/X11/


`
Section "Device"

    Identifier  "0x42"

    Driver      "intel"

    Option      "Backlight"  "intel_backlight"

EndSection
`

To enable tapping for touch on touchpad

use "xinput list <device_id>"

change the property_number (in my case it is 282) in config file

To enable natural scrolling

change the property_number (in my case it is 282) in config file

If nm-applet freezes, remove dunst. Also in the current setup, I had masked systemd-journal-flush.service, bluetooth.service so that it will not run on startup.
