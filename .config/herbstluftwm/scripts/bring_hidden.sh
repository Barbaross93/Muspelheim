#!/usr/bin/env bash

#xdotool getactivewindow windowsize 448 413 windowmove 732 331

hc() { ${herbstclient_command:-herbstclient} "$@"; }
dm() { ${bemenu_command:-bemenu} "$@"; }
bemenu_lines=${bemenu_lines:-10}

case "$1" in

*)
    # bring the selected window to the current tag and focus it
    name='Bring Hidden │ '
    action() { hc bring "$@"; }
    ;;
esac

#wmctrl -l |cat -n| sed 's/\t/) /g'| sed 's/^[ ]*//' \
id=$(herbstclient try foreach C clients. sprintf ATTR_V '%c.minimized' C and , compare ATTR_V = true , sprintf ATTR_TITLE '%c.title' C substitute TITLE ATTR_TITLE echo C TITLE | cut -d'.' -f2- | grep -v 'wselect.sh' | cat -n | sed 's/\t/) /g' | sed 's/^[ ]*//' |
    dm -p "$name") &&
    action $(awk '{ print $2 ; }' <<<"$id")
