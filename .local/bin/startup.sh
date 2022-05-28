#!/bin/sh

# Run these programs as user services
uid=$(id -u)
pgrep -U "$uid" runsv && pkill -U "$uid" runsv
setsid -f runsvdir -P ~/.local/service/common

if [ -n "$WAYLAND_DISPLAY" ]; then
	setsid -f runsvdir -P ~/.local/service/wayland
elif [ -n "$DISPLAY" ]; then
	setsid -f runsvdir -P ~/.local/service/x11
fi

# Things to launch on startup that require an internet connection
while :; do
	[ "$(cat /sys/class/net/wlp5s0/carrier)" -eq 1 ] && break
	sleep 1
done
network=$(iwctl station wlp5s0 show | grep 'Connected network' | xargs | cut -d' ' -f3-)
case "$network" in
Ollies*Network)
	sv start ~/.local/service/common/barrier
	;;
*)
	sudo -A wg-quick up barbarossvpn
	;;
esac

#On startup, check for any new mails
mailsync
