#!/bin/bash

case "$1" in
-win)
    WG=$(herbstclient get window_gap)
    let "WG=WG-4"
    herbstclient set window_gap $WG
    ;;
+win)
    WG=$(herbstclient get window_gap)
    let "WG=WG+4"
    herbstclient set window_gap $WG
    ;;
-frm)
    WG=$(herbstclient get frame_gap)
    let "WG=WG-4"
    herbstclient set frame_gap $WG
    ;;
+frm)
    WG=$(herbstclient get frame_gap)
    let "WG=WG+4"
    herbstclient set frame_gap $WG
    ;;
*)
    herbstclient set window_gap 0 && herbstclient set frame_gap 12
    ;;
esac
