#!/bin/sh

status=$(playerctl status)

if [ "$status" = Playing ]; then
	info=$(playerctl metadata --format " Now Playing  {{ title }} ({{ duration(mpris:length) }})  {{ artist }}  {{ album }}")
	notify-send -u low "Music" "$info"
elif [ "$status" = Paused ]; then
	position=$(playerctl position --format "{{ duration(position) }}")
	duration=$(playerctl metadata --format "{{ duration(mpris:length) }}")
	formatted=" Playback Paused Current Position: $position/$duration"
	notify-send -u low "Music" "$formatted"
fi
