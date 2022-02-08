#!/usr/bin/env bash

#-------------------------------#
# Display current cover (ueber) #
#-------------------------------#

ImageLayer() {
    ueberzug layer -sp json
}

COVER="/tmp/cover.png"
COLS=$(tput cols)
LNS=$(tput lines)
X_PADDING=2
Y_PADDING=$((LNS / 4))

add_cover() {
    filepath=$(cmus-remote -C "format_print %f")
    ffmpeg -nostdin -y -i "$filepath" "$COVER" &>/dev/null
    COLS=$(tput cols)
    LNS=$(tput lines)
    echo "{\"action\": \"add\", \"identifier\": \"cover\", \"scaler\": \"fit_contain\", \"x\": $X_PADDING, \"y\": $Y_PADDING, \"width\": \"$COLS\", \"height\": \"$LNS\", \"path\": \"$COVER\"}"
}

[ -e /tmp/cmus_cover.fifo ] && rm /tmp/cmus_cover.fifo
mkfifo /tmp/cmus_cover.fifo
trap 'add_cover' WINCH
clear
ImageLayer - < <(
    tail -f /tmp/cmus_cover.fifo |
        while read -r event; do
            add_cover
        done
)

#-------------------------------#
# Display current cover (urxvt) #
#-------------------------------#

#function reset_background {
#    echo -e "\ePtmux;\e\e]20;;100x100+1000+1000\a\e\\"
#}

#clear
#playerctl --follow metadata mpris:trackid |
#[ -e /tmp/cmus_cover.fifo ] && rm /tmp/cmus_cover.fifo
#mkfifo /tmp/cmus_cover.fifo
#tail -f /tmp/cmus_cover.fifo |
#    while read -r event; do
#        tmp=$(mktemp --suffix ".png")
#        filepath=$(cmus-remote -C "format_print %f")
#        ffmpeg -nostdin -y -i "$filepath" "$tmp" &>/dev/null
#        #reset_background
#        echo -e "\ePtmux;\e\e]20;${tmp};40x40+98+30:op=keep-aspect\a\e\\"
#        rm "$tmp"
#    done
