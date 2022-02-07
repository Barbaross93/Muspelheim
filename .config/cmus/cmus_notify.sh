#!/bin/env bash

#status=$(playerctl status)
status=$(cmus-remote -Q | grep status | awk '{print $2}')

if [ "$status" = playing ]; then
	info=$(cmus-remote -C "format_print \ Now\ Playing\ \ %t\ %d\ \ %a\ \ %l")
	notify-send -u low "Music" "$info"
elif [ "$status" = paused ]; then
	formatted=$(cmus-remote -C "format_print \ Playback\ Paused\ Current\ Position:\ %{position}/%d")
	notify-send -u low "Music" "$formatted"
fi

# Tell cover script to update
echo upd >/tmp/cmus_cover.fifo
