#!/bin/sh

if [ -n "$WAYLAND_DISPLAY" ]; then
	location=$(slurp -b 00000000 -p)
	color=$(grim -g "$location" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -1 | awk '{print $3}')
	notify-send "Colorpicker" "$color"
elif [ -n "$DISPLAY" ]; then
	#color=$(gpick -so 2>/dev/null)
	color=$(xcolor)
	#color=$(grabc)

	if [ -n "$color" ]; then
		#temp=$(mktemp --suffix ".png")
		#convert -size 100x100 xc:$color $temp
		#printf '%s' "$color" | xsel -ib --logfile /dev/null
		notify-send "Colorpicker" "$color"
	fi
fi
