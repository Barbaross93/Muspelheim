#!/bin/sh

# Ncspot wont work right if cava starts before audio begins playing within ncspot.
# We need this script in order to have ncspot work properly

while :; do
	status=$(cat /proc/asound/card*/pcm*/sub*/status)
	if echo "$status" | grep "RUNNING" >/dev/null 2>&1; then
		cava
		break
	fi
	sleep 0.5
done
