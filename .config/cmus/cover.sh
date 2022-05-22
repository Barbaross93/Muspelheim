#!/usr/bin/env bash

#-------------------------------#
# Display current cover         #
#-------------------------------#

reset_background() {
    printf "\ePtmux;\e\e]20;;100x100+1000+1000\a\e\\"
}

clear
[ -e /tmp/cmus_cover.fifo ] && rm /tmp/cmus_cover.fifo
mkfifo /tmp/cmus_cover.fifo
tail -f /tmp/cmus_cover.fifo |
    while read -r event; do
        tmp=$(mktemp --suffix ".png")
        filepath=$(cmus-remote -C "format_print %f")
        ffmpeg -nostdin -y -i "$filepath" "$tmp" &>/dev/null
        clear
        echo -e "\n\n\n\n\n\n"
        chafa -c full ${tmp}
        #echo -e "\ePtmux;\e\e]20;${tmp};40x40+97+30:op=keep-aspect\a\e\\"
        rm "$tmp"
    done
