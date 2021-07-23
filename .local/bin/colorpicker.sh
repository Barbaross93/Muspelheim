#!/bin/sh
#set -euo pipefail

#color=$(gpick -so 2>/dev/null)
color=$(xcolor)

if [ -n "$color" ]; then
	temp=$(mktemp --suffix ".png")
	convert -size 100x100 xc:$color $temp
	echo $color | xsel -ib
	printf "IMG:$temp\t$color\n" >$XNOTIFY_FIFO
fi
