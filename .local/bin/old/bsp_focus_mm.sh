#!/usr/bin/env bash

mode="$1"
direction="$2"
monitor=$(bspc query -M --names -m $direction)
if bspc query -N -n $direction -m focused >/dev/null; then
	bspc node -$mode $direction
else
	if [ $mode = "f" ]; then
		if bspc query -N -d ${monitor}:focused >/dev/null; then
			bspc node -$mode $direction
		else
			bspc monitor -f $direction
		fi
	else
		bspc node -m $direction --follow
	fi
fi
