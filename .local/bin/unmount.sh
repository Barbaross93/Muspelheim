#!/bin/sh

devices=$(ldmc -l)

selection=$(echo "$devices" | bemenu -p "Unmount")

if [ -n "$selection" ]; then
	dev=$(echo "$selection" | awk '{print $2}' | tr -d '"')
	ldmc -r "$dev" && notify-send "ldm" "$dev unmounted"
fi
