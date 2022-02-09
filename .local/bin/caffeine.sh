#!/bin/sh

if [ "$(xset q | grep Enabled | awk '{print $3}')" = "Enabled" ]; then
    xset dpms 0 0 0
    xset -dpms
    #xset s 0 0
    #xset s off
    #xset s noblank
    xautolock -disable
    #xidlehook-client --socket /tmp/xidlehook.sock control --action Disable
    #notify-send "Caffeine" "Caffeine enabled"
    echo true >/tmp/caffeine.fifo
    #polybar-msg hook caffeine 2
else
    xset +dpms
    #xset s on #&& DISPLAY=:8 xset +dpms s oni
    #xset s blank
    #xset s 180 119    #&& DISPLAY=:8 xset s 180
    xset dpms 0 0 300 #&& DISPLAY=:8 xset dpms 300
    xautolock -enable
    #xidlehook-client --socket /tmp/xidlehook.sock control --action Enable
    #notify-send "Caffeine" "Caffeine disabled"
    echo false >/tmp/caffeine.fifo
    #polybar-msg hook caffeine 1
fi
