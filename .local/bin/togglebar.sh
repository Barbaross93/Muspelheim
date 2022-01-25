#!/bin/sh

if pgrep lemonbar; then
	echo die >>/tmp/signal_bar
else
	setsid sbar.sh &
fi
