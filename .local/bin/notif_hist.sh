#!/usr/bin/sh

notif_log=/tmp/notif_hist
count=/tmp/notif_count

query() {
	# Reverse order and attempts to dedup, doesnt work great
	notifs=$(tac $notif_log | cat -n | sort -uk2 | sort -nk1 | cut -f2-)

	if test $(find "$count" -mmin +1); then
		rm $count
	fi
	if [ ! -f "$count" ]; then
		echo 1 >$count
	fi
	c=$(cat $count)
	echo "$notifs" | awk "NR==$c" >"$XNOTIFY_HIST_FIFO" &
	c=$((c + 1))
	echo "$c" >$count
}

cleanup() {
	[ -f $count ] && rm $count
	pkill -USR1 xnotify
}

case "$1" in
-c | --cleanup)
	cleanup
	;;
-q | --query | *)
	query
	;;
esac
