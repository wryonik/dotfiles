#!/bin/bash

pacman -S --needed - < ./pkglist.txt

cp -r ./.config ~/.config
