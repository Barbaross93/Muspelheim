#!/usr/bin/env sh

state=$(bspc query -T -n "$1" | jq -r '.client.state')

if [ "$state" = "fullscreen" ]; then
	pkill -STOP xnotify
else
	pkill -CONT xnotify
fi
