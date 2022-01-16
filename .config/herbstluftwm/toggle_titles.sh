#!/usr/bin/env sh

current=$(herbstclient attr theme.title_height)

if [ "$current" -eq 0 ]; then
	herbstclient attr theme.title_height 25
	herbstclient attr theme.title_depth 18
else
	herbstclient attr theme.title_height 0
	herbstclient attr theme.title_depth 0
fi
