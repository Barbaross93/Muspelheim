#!/bin/sh

if pidof lemonbar; then
	echo die >>/tmp/signal_bar
else
	#~/.local/bin/old/bar.sh
	sbar.sh &
fi
