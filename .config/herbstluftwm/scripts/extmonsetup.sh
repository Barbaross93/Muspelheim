#!/usr/bin/env bash

intern=eDP1
#extern=HDMI-1-1
extern=VIRTUAL1

update_hlwm() {
    herbstclient detect_monitors
    herbstclient reload
}

if pgrep optirun; then
    xrandr --output "$extern" --off --output "$intern" --auto
    killall -INT optirun
    #autorandr --change
    killall redshift
    update_hlwm
    redshift &
    killall lemonbar
    bar.sh &
else
    optirun intel-virtual-output
    #wait
    #while :; do
    #    xrandr | grep VIRTUAL2
    #    if [ $? -eq 0 ]; then
    #        break
    #    fi
    #done
    resolution=""
    while [[ ! $resolution =~ [0-9] ]]; do
        xrandr --output "$intern" --primary --auto --rotate normal --output "$extern" --auto --rotate normal --right-of "$intern"
        resolution=$(xrandr | grep "$extern connected" | awk '{print $3}')
        sleep 1
        #if [ $? -eq 0 ]; then
        #    break
        #fi
    done
    #autorandr --change
    DISPLAY=:8 xset s 180 120
    update_hlwm
    #systemctl restart clightd.service
    DISPLAY=:8 redshift &
    herbstclient pad 1 44 4 4 4
    killall lemonbar
    bar.sh &
fi
