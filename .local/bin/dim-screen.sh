#!/bin/sh

# Example notifier script -- lowers screen brightness, then waits to be killed
# and restores previous brightness on exit.

## CONFIGURATION ##############################################################

# Brightness will be lowered to this value.
min_brightness=10

# If your video driver works with xbacklight, set -time and -steps for fading
# to $min_brightness here. Setting steps to 1 disables fading.
fade_time=200
fade_steps=20

# If you have a driver without RandR backlight property (e.g. radeon), set this
# to use the sysfs interface and create a .conf file in /etc/tmpfiles.d/
# containing the following line to make the sysfs file writable for group
# "users":
#
#     m /sys/class/backlight/acpi_video0/brightness 0664 root users - -
#
#sysfs_path=/sys/class/backlight/intel_backlight/brightness

# Time to sleep (in seconds) between increments when using sysfs. If unset or
# empty, fading is disabled.
fade_step_time=0.01

###############################################################################

get_brightness() {
    if [ -z "$sysfs_path" ]; then
        #xbacklight -get
        light | cut -d'.' -f1
    else
        cat $sysfs_path
    fi
}

set_brightness() {
    if [ -z "$sysfs_path" ]; then
        #xbacklight -steps 1 -set $1
        light -S $1
    else
        echo $1 >$sysfs_path
    fi
}

fade_brightness() {
    if [ -z "$fade_step_time" ]; then
        set_brightness $1
    else
        level=$(get_brightness)
        steps=$(echo "($level - $min_brightness)/$fade_steps" | bc -l)
        while [ $(get_brightness) -gt $min_brightness ]; do
            light -U "$steps"
            sleep $fade_step_time
        done
    fi
}

#cur_idle=$(xprintidle)
old_brightness=$(get_brightness)
echo pause >/tmp/signal_bar
fade_brightness $min_brightness
xinput test-xi2 --root |
    while read -r event; do
        echo "$event" | grep EVENT >/dev/null 2>&1 && break
    done
#while :; do
#    [ $(xprintidle) -lt $cur_idle ] && break
#    sleep 0.75
#done

set_brightness $old_brightness
echo resume >/tmp/signal_bar
