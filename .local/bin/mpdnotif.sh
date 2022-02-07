#!/bin/sh

status=$(mpc status | grep 'playing\|paused')

case "$status" in
*playing*)
	info=$(mpc current --format " Now Playing  %title% (%time%)  %artist%  %album%")
	notify-send -u low "MPD" "$info"
	;;
*paused*)
	info=$(mpc current --format " Paused  %title% (%time%)  %artist%  %album%")
	notify-send -u low "MPD" "$info"
	;;
esac
