#!/usr/bin/env bash
#set -euo pipefail

herbstclient --idle "rule" |
    while read -r event; do
        winid=$(echo "$event" | awk '{print $3}')
        xdo activate "$winid"
        while [ $? -eq 0 ]; do
            #sleep 0.3
            xdotool windowactivate "$winid" || break
            herbstclient --wait "focus_changed"
        done
    done
