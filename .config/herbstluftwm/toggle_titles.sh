#!/usr/bin/env sh

current=$(herbstclient attr theme.title_height)

if [ "$current" -eq 0 ]; then
	herbstclient attr theme.tiling.title_height 18
	herbstclient attr theme.tiling.padding_top 8
else
	herbstclient attr theme.tiling.title_height 0
	herbstclient attr theme.tiling.padding_top 0
fi
