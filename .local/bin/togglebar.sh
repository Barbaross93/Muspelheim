#!/bin/sh

#polybar="$(pgrep polybar)"

#if [ "$(bspc config top_padding)" == "36" ]
if pidof lemonbar; then
	pkill -f "bash+.bar*"
	killall lemonbar
	bspc config bottom_padding 2
else
	bspc config bottom_padding 38
	bar.sh &
fi
