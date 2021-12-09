#!/usr/bin/bash

hex_prefix=0x
hex_num=$(printf '%x' $XSCREENSAVER_WINDOW)
window_id=$hex_prefix$hex_num

/usr/bin/nsxiv -b -g 1920x1080+0+0 -e $window_id /home/barbaross/Pictures/plain_lock.png

#/usr/bin/mpv --no-audio --no-input-terminal --no-stop-screensaver --panscan=1.0 --image-display-duration=inf --no-config --wid="$XSCREENSAVER_WINDOW" /home/barbaross/Pictures/noise_lock_452f2f.jpg
