#!/bin/bash

# installs the packages present in my laptop
echo "Install all packages? (y/N) \c";
read $REPLY
if "$REPLY" = "y";
then
    pacman -S --needed - < ./pkglist.txt

else
    echo "skipping..."

fi

# copy config files to .config folder

echo "Backing up config files..."
mkdir ~/.config/backup
mv .config/dunst .config/gtk-2.0 .config/gtk-3.0 .config/i3 .config/polybar .config/rofi .config/spicetify .config/terminator .config/betterlockscreenrc .config/libinput-gestures.conf .config/backup

# copy config files to .config folder

echo "Copying config files..."
cp -r ./.config ~/.config

# staring libinput-gestures
libinput-gestures-setup autostart
libinput-gestures-setup start