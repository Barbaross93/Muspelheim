#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar bar &
polybar ext-bar &

sleep 2
for i in $(xdo id -n polybar); do
	herbstclient lower "$i"
done
