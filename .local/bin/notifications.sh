#!/bin/sh

# Notif logic
if [ ! -p /tmp/new_notifs ]; then
	[ -e /tmp/new_notifs ] && rm /tmp/new_notifs
	mkfifo /tmp/new_notifs
fi

tiramisu -o "#summary\t#body\t#timeout" |
	while read -r line; do
		echo "$line" >/tmp/new_notifs
		echo "LOG $line" >>/tmp/notif_log
	done
