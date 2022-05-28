#!/bin/sh

#Idle script to watch for specific events

# Watch for changes in fullscreen state and act accordingly
swaymsg -m -t subscribe "['window']" | stdbuf -i0 -o0 -e0 jq -r '.container.fullscreen_mode' | uniq |
	while read -r fullscreen_state; do
		if [ $fullscreen_state -eq 1 ]; then
			# Pause notifications while in fullscreen
			echo pause >/tmp/signal_bar
		elif [ "$fullscreen_state" -eq 0 ]; then
			# Resume notifications after fullscreen
			echo resume >/tmp/signal_bar
		fi
	done
