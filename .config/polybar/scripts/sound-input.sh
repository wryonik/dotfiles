#!/bin/sh

# MUTED=$(pactl list sources | awk '/\*/,EOF {print}' | awk '/muted/ {print $2; exit}')
MUTED=$(pactl list sources | grep -A 7 alsa_input.pci-0000_00_1f.3.analog-stereo | grep -c 'Mute: no')

if [ "$MUTED" = 0 ]; then
    echo ""
else
    echo -n " "
    pactl list sources | grep -A 7 alsa_input.pci-0000_00_1f.3.analog-stereo | grep Volume | awk -F/ '{print $2}' | tr -d ' ' 
    # pactl list sources | grep "\* index:" -A 7 | grep volume | awk -F/ '{print $2}' | tr -d ' ' 
fi