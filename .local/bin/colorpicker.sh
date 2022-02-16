#!/bin/sh

#color=$(gpick -so 2>/dev/null)
color=$(xcolor)
#color=$(grabc)

if [ -n "$color" ]; then
	#temp=$(mktemp --suffix ".png")
	#convert -size 100x100 xc:$color $temp
	#printf '%s' "$color" | xsel -ib --logfile /dev/null
	notify-send "Colorpicker" "$color"
fi
