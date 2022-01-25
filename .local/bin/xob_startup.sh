#!/usr/bin/env sh
#set -euo pipefail

vfifo=/tmp/xob_vol
bfifo=/tmp/xob_bright

[ -e "$vfifo" ] && rm $vfifo
mkfifo $vfifo
[ -e "$bfifo" ] && rm $bfifo
mkfifo $bfifo

tail -f $vfifo | xob -t 2000 -s volume &
tail -f $bfifo | xob -t 2000 -s backlight &

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
			light=$(light)
			rounded=$(echo "$light/1" | bc)
			echo $rounded
			#xbacklight -get
		done
}
#volu | xob -t 2000 -s volume &
#light | xob -t 2000 -s backlight &

wait
