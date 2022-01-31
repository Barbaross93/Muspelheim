#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

(
	sleep 2
	polybar bar
) &
(
	sleep 2
	polybar ext-bar
) &
