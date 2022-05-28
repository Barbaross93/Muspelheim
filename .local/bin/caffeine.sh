#!/bin/sh

state=$(sv check ~/.local/service/wayland/swayidle/ | cut -d' ' -f2)
#state=$(xset q | grep Enabled | awk '{print $3}')
case "$state" in
Enabled)
    xset dpms 0 0 0
    xset -dpms
    xautolock -disable
    echo true >/tmp/caffeine.fifo
    ;;
Disabled)
    xset +dpms
    xset dpms 0 0 300 #&& DISPLAY=:8 xset dpms 300
    xautolock -enable
    echo false >/tmp/caffeine.fifo
    ;;
*run*)
    sv down ~/.local/service/wayland/swayidle
    echo true >/tmp/caffeine.fifo
    ;;
*down*)
    sv up ~/.local/service/wayland/swayidle
    echo false >/tmp/caffeine.fifo
    ;;
esac
