#!/bin/sh

state=$(xinput list-props "Elan Touchpad" | grep "Device Enabled" | awk '{print $4}')

if [ "$state" -eq 0 ]; then
	xinput set-prop "Elan Touchpad" "Device Enabled" 1 && notify-send "Libinput" "Touchpad enabled"
elif [ "$state" -eq 1 ]; then
	xinput set-prop "Elan Touchpad" "Device Enabled" 0 && notify-send "Libinput" "Touchpad disabled"
fi
