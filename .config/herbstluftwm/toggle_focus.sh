#!/usr/bin/env bash

if pidof lemonbar; then
	killall lemonbar
	herbstclient pad 0 4 4 4 4
	herbstclient pad 1 4 4 4 4
	#herbstclient attr theme.title_height 10
	#herbstclient attr theme.floating.title_height 0
else
	herbstclient pad 0 44 4 4 4
	herbstclient pad 1 44 4 4 4
	bar.sh &
	#herbstclient attr theme.title_height 0
fi
