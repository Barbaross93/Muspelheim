#!/usr/bin/env sh

current=$(herbstclient attr theme.title_height)

if [ "$current" -eq 0 ]; then
	herbstclient attr theme.title_height 17
else
	herbstclient attr theme.title_height 0
fi
