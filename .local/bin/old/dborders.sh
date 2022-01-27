#!/bin/sh
#
#   double borders
#

outer='0x1c1c1c'  # outer
inner1='0xa87f5f' # focused
inner2='0x424242' # normal
inner3='0x87afaf' # active

targets() {
	case $1 in
	focused) bspc query -N -n .local.focused.\!fullscreen ;;
	normal) bspc query -N -n .local.\!focused.\!fullscreen ;;
	active) bspc query -N -n .active.\!focused.\!fullscreen ;;
	esac
}

draw() { chwb2 -I "$i" -O "$o" -i "5" -o "3" $@ 2>/dev/null; }

# initial draw, and then subscribe to events
{
	echo
	bspc subscribe node_geometry node_focus
} |
	while read -r _; do
		i=$inner2 o=$inner1 draw "$(targets focused)"
		i=$inner2 o=$outer draw "$(targets normal)"
		i=$inner2 o=$inner3 draw "$(targets active)"
	done
