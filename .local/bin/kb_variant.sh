#!/bin/sh

# Toggle between qwerty and colemak

if setxkbmap -query | grep variant >/dev/null; then
	setxkbmap us
	#xmodmap ~/.config/x11/Xmodmap
	#sv restart ~/.local/service/xcape
	#notify-send "Keymap" "Keymap set to qwerty"
else
	setxkbmap us -variant colemak -option caps:capslock
	#xmodmap ~/.config/x11/Xmodmap
	#sv restart ~/.local/service/xcape
	#notify-send "Keymap" "Keymap set to colemak"
fi
