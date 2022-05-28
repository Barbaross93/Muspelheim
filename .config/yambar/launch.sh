#!/bin/sh

launch() {
	# Terminate yambars
	pkill yambar

	# Wait until the processes have been shut down
	uid=$(id -u)
	while pgrep -u $uid -x yambar >/dev/null; do sleep 1; done

	if [ -n "$WAYLAND_DISPLAY" ]; then
		setsid -f yambar -c ~/.config/yambar/sway-yambar.yml
	elif [ -n "$DISPLAY" ]; then
		setsid -f yambar

		sleep 2
		for i in $(xdo id -a yambar); do
			herbstclient lower "$i"
		done
	fi
}

case "$1" in
-t | --toggle)
	if [ -n "$(pgrep yambar)" ]; then
		pkill yambar
	else
		launch
	fi
	;;
*)
	launch
	;;
esac
