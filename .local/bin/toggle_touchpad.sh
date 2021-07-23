#!/bin/sh

state=$(xinput list-props "Elan Touchpad" | grep "Device Enabled" | awk '{print $4}')

if [ "$state" -eq 0 ]; then
	xinput set-prop "Elan Touchpad" "Device Enabled" 1 && printf "Touchpad enabled\n" >$XNOTIFY_FIFO
elif [ "$state" -eq 1 ]; then
	xinput set-prop "Elan Touchpad" "Device Enabled" 0 && printf "Touchpad disabled\n" >$XNOTIFY_FIFO
else
	printf "Something borked\n" >$XNOTIFY_FIFO
fi
