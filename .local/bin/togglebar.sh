#!/bin/sh

#if pgrep lemonbar; then
#	echo die >>/tmp/signal_bar
#else
#	setsid sbar.sh &
#fi

pad=$(herbstclient list_padding | cut -d' ' -f1)

if [ $pad -ne 0 ]; then
	xdo hide -a yambar
	#polybar-msg cmd toggle
	herbstclient pad "" 0 0 0 0
else
	xdo show -a yambar
	#polybar-msg cmd toggle
	herbstclient pad "" 39 0 0 0
fi
