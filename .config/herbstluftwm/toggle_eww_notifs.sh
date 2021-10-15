#!/usr/bin/env bash

if pgrep -f eww_notifd.sh; then
	notify-send -u normal " Notifications disabled"
	sleep 6
	pkill -f eww_notifd.sh
else
	eww_notifd.sh &
	sleep 1
	notify-send -u normal " Notifications enabled"
fi
