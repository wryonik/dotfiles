#!/bin/bash

backup_dir="/home/$USER/dotfiles"
config_folder="$HOME/.config"

declare -a HOME_FILES=(".zshrc" ".Xresources")
declare -a CONFIG_FILES=("dunst" "gtk-2.0" "gtk-3.0" "i3" "polybar" "rofi" "spicetify" "terminator" "betterlockscreenrc" "libinput-gestures.conf")

echo "Copying files from home dir"

for f in "${HOME_FILES[@]}"
do
    cd ~
    rsync -a --info=progress2 "$HOME/$f" "$backup_dir"
done

echo "Copying files from .config dir"

for f in "${CONFIG_FILES[@]}"
do
    rsync -a --info=progress2 "$config_folder/$f" "$backup_dir/.config"
done

echo "Updating package list"

pacman -Qqe > $backup_dir/pkglist.txt

if [ $# -eq 0 ]
then
    echo "No arguments supplied"
else
    if [ $1 == "upload" ]
    then
        cd $backup_dir
        pwd
        git add .
        if [ $# -eq 1 ]
        then
            echo "Uploading with default commit message"
            git commit -m "update dotfiles $(date)"
        else
            echo $2
            git commit -m "$2"
        fi
        git push origin arch
    fi
fi