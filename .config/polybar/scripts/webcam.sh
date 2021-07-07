#!/bin/bash

if [[ $(lsof /dev/video0 | awk '{print $1}' | grep -v COMMAND | uniq | sed 's/skypeforl*/skype/g' | wc -l) -ne 0 ]]; then
	echo -n ""
else
	echo -n ""
fi

# if [[ $(pactl list sources | grep -A 7 alsa_input.pci-0000_00_1f.3.analog-stereo | grep -c 'Mute: no') -ne 0 ]]; then
# 	echo ""
# else
# 	echo ""
# fi
