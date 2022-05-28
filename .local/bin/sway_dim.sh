#!/bin/sh

## CONFIGURATION ##############################################################

# Brightness will be lowered to this value.
min_brightness=10

# If your video driver works with xbacklight, set -time and -steps for fading
# to $min_brightness here. Setting steps to 1 disables fading.
fade_steps=20

# Time to sleep (in seconds) between increments when using sysfs. If unset or
# empty, fading is disabled.
fade_step_time=0.01

###############################################################################

fade_brightness() {
	if [ -z "$fade_step_time" ]; then
		light -S $1
	else
		level=$(light | cut -d'.' -f1)
		steps=$(echo "($level - $min_brightness)/$fade_steps" | bc -l)
		while [ $(light | cut -d'.' -f1) -gt $min_brightness ]; do
			light -U "$steps"
			sleep $fade_step_time
		done
	fi
}

case "$1" in
-d)
	light >/tmp/old_bright
	echo pause >/tmp/signal_bar
	fade_brightness $min_brightness
	;;
-r)
	light -S "$(cat /tmp/old_bright)" && rm -f /tmp/old_bright
	echo resume >/tmp/signal_bar
	;;
esac
