#!/bin/sh

if [ "$(xset q | grep Enabled | awk '{print $3}')" = "Enabled" ]; then
    xset dpms 0 0 0
    xset -dpms
    xset s 0 0
    xset s off
    xset s noblank
    pkill idle.sh
    #pkill xss-lock
    printf "SEC:3\t Caffeine Enabled\n" >$XNOTIFY_FIFO
    #dunstify -u normal -t 3000 -r 5534 " Caffeine Enabled"
else
    xset +dpms
    xset s on #&& DISPLAY=:8 xset +dpms s oni
    xset s blank
    xset s 180 120        #&& DISPLAY=:8 xset s 180
    xset dpms 305 600 600 #&& DISPLAY=:8 xset dpms 300

    #xss-lock -n dim-screen.sh -l -- lock &
    idle.sh 10 "systemctl suspend-then-hibernate" &
    printf "SEC:3\t Caffeine Disabled\n" >$XNOTIFY_FIFO
    #dunstify -u normal -t 3000 -r 5534 " Caffeine Disabled"
fi
