#!/bin/sh

#-------------------------------#
# Display current cover         #
# ueberzug version              #
#-------------------------------#

ImageLayer() {
    ueberzug layer -sp json
}

COVER="/tmp/cover.png"
X_PADDING=1
Y_PADDING=1

if [ ! -f "$COVER" ]; then
    touch $COVER
fi

add_cover() {
    if [ -e $COVER ]; then
        echo "{\"action\": \"add\", \"identifier\": \"cover\", \"x\": $X_PADDING, \"y\": $Y_PADDING, \"path\": \"$COVER\"}"
    else
        sleep 1
        add_cover
    fi
}

#clear
#ImageLayer - < <(
#    #add_cover
#    while inotifywait -q -q -e close_write "$COVER"; do
#        add_cover
#    done
#)

##Catimg method
clear
if [ ! -f "$COVER" ]; then
    touch "$COVER"
fi
while inotifywait -q -q -e close_write "$COVER"; do
    clear
    chafa -c full $COVER -s $(tput cols)x$(tput lines)
    #catimg $COVER
done

### URxvt method below
#function reset_background {
#    printf "\ePtmux;\e\e]20;;100x100+1000+1000\a\e\\"
#}

#clear
#i=0
#if [ ! -f "$COVER" ]; then
#    touch "$COVER"
#fi
#while inotifywait -q -q -e close_write "$COVER"; do
#    clear
#    cp /tmp/cover.png /tmp/cover$i.png
#    reset_background
#    sleep 0.3
#    printf "\ePtmux;\e\e]20;/tmp/cover$i.png;40x40+93+0:op=keep-aspect\a\e\\"
#    rm /tmp/cover$i.png
#    i=$((i + 1))
#done
