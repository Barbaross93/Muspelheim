#!/bin/sh

#polybar="$(pgrep polybar)"

#if [ "$(bspc config top_padding)" == "36" ]
if pidof lemonbar; then
	echo die >>/tmp/signal_bar
	#bspc config top_padding 0
	#bspc config bottom_monocle_padding 0
else
	#bspc config top_padding 39
	#bspc config bottom_monocle_padding 2
	#~/.local/bin/old/bar.sh
	sbar.sh &
fi
