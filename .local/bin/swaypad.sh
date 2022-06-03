#!/bin/sh

swaymsg scratchpad show
if [ $? -eq 2 ]; then
	setsid -f alacritty --class Dropdown -e tmux new -As Dropdown
	#setsid -f foot -a Dropdown -e tmux new -As Dropdown
	sleep 0.2
	swaymsg scratchpad show
fi
