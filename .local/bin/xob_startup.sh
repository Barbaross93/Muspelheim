#!/usr/bin/env bash
#set -euo pipefail

volu() {
	stdbuf -o0 -i0 -e0 alsactl monitor |
		while read -r line; do
			echo $line | grep Volume &>/dev/null
			if [ $? -eq 0 ]; then
				state=$(amixer get Master | grep "Mono" | awk '{print $6}' | sed -r '/^\s*$/d')
				val=$(amixer get Master | grep "Mono" | awk '{print $4}' | tr -d -c 0-9)
				if [[ "$state" == "[off]" ]]; then
					echo "$val!"
				else
					echo "$val"
				fi
			fi
		done
}

light() {
	inotifywait -m -q -e close_write /sys/class/backlight/intel_backlight/brightness |
		while read -r line; do
			#light=$(xbacklight)
			#rounded=$(echo "$light/1" | bc)
			#echo $rounded
			xbacklight -get
		done
}
volu | xob -s volume &
light | xob -s backlight &

wait
