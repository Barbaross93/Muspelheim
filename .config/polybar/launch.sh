#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit
#pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

setsid -f polybar bar
setsid -f polybar ext-bar

sleep 2
for i in $(xdo id -n polybar); do
	herbstclient lower "$i"
done
