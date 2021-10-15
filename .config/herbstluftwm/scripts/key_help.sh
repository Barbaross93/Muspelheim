#!/usr/bin/env bash

#xdotool getactivewindow windowsize 636 491 windowmove 642 292

modifier=$(grep "hc keybind" ~/.config/herbstluftwm/autostart | awk '{$1=$1};1' | sed '/^#/d' | cut -d' ' -f3- | sed 's/$Mod/Super/g' | sed 's/Mod1/Alt/g' | awk '{print $1}' | tr -d '"')

description=$(grep 'hc keybind' ~/.config/herbstluftwm/autostart | awk '{$1=$1};1' | sed '/^#/d' | sed 's/^[^#]*#//g' | sed "s/.*hc.*//")

final=$(paste -d '\t' <(echo "$modifier") <(echo "$description") | column -s $'\t' -t)

echo "$final" | bemenu -p "Help:"
