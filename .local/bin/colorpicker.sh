#!/bin/sh

#color=$(gpick -so 2>/dev/null)
color=$(xcolor)

if [ -n "$color" ]; then
	#temp=$(mktemp --suffix ".png")
	#convert -size 100x100 xc:$color $temp
	printf '%s' "$color" | xsel -ib
	notify-send "Colorpicker" "$color"
fi
