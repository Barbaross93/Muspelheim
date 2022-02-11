#!/bin/sh

# Terminate yambars
pkill yambar

# Wait until the processes have been shut down
while pgrep -u $UID -x yambar >/dev/null; do sleep 1; done

setsid -f yambar
setsid -f yambar -c ~/.config/yambar/ext-config.yml

sleep 2
for i in $(xdo id -a yambar); do
	herbstclient lower "$i"
done
