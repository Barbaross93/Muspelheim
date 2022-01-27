#!/usr/bin/env sh

current=$(herbstclient attr theme.title_when)

if [ "$current" = "multiple_tabs" ]; then
	herbstclient attr theme.title_when always
else
	herbstclient attr theme.title_when multiple_tabs
fi
