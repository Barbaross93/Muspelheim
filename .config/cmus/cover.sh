#!/usr/bin/env bash

#-------------------------------#
# Display current cover         #
#-------------------------------#

function reset_background {
    echo -e "\ePtmux;\e\e]20;;100x100+1000+1000\a\e\\"
}

clear
#playerctl --follow metadata mpris:trackid |
[ -e /tmp/cmus_cover.fifo ] && rm /tmp/cmus_cover.fifo
mkfifo /tmp/cmus_cover.fifo
tail -f /tmp/cmus_cover.fifo |
    while read -r event; do
        tmp=$(mktemp --suffix ".png")
        filepath=$(cmus-remote -C "format_print %f")
        ffmpeg -nostdin -y -i "$filepath" "$tmp" &>/dev/null
        #reset_background
        echo -e "\ePtmux;\e\e]20;${tmp};40x40+97+40:op=keep-aspect\a\e\\"
        rm "$tmp"
    done
