#!/usr/bin/env sh

if ! pgrep -x xnotify; then
	rm -f $XNOTIFY_FIFO
	mkfifo $XNOTIFY_FIFO
	cat 0<>$XNOTIFY_FIFO | tee -a /tmp/notif_hist | xnotify &
else
	printf "xnotify is already running\n" >$XNOTIFY_FIFO
fi
