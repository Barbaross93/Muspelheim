#!/bin/sh
# Based on https://gist.github.com/lbonn/89d064cde963cfbacabd77e0d3801398 
#

row=$(swaymsg -t get_tree | jq  -r '
    ..
    | objects
    | select(.type == "workspace") as $ws
    | ..
    | objects
    | select(has("app_id"))
    | (if .focused == true then "*" else " " end) as $asterisk
    | "[\($ws.name)] \($asterisk) \(.app_id) - \(.name) (\(.id))"' | bemenu -p "Windows")

if [ -n "$row" ]; then
    winid=$(echo "$row" | sed 's/.* (\([0-9]*\))/\1/' | tr -d '()')
    swaymsg "[con_id=$winid] focus"
fi
