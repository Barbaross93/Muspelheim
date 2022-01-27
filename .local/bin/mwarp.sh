#!/bin/sh

# Warp mouse to center of focused window
coords=($(herbstclient attr clients.focus.content_geometry | tr 'x' ' ' | tr '+' ' '))
width=$((coords[0] / 2))
height=$((coords[1] / 2))
x=${coords[2]}
y=${coords[3]}
if [ "$width" -gt 0 ]; then
	xdo pointer_motion -x $((width + x)) -y $((height + y))
else
	#move pointer to center of screen if we're not focusing a window
	xdo pointer_motion -x 960 -y 540
fi
