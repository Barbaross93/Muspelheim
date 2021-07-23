#!/usr/bin/env sh

if ! pgrep -x xnotify; then
	rm -f $XNOTIFY_FIFO && rm -f $XNOTIFY_HIST_FIFO
	mkfifo $XNOTIFY_FIFO && mkfifo $XNOTIFY_HIST_FIFO
	tail -f $XNOTIFY_FIFO | tee -a /tmp/notif_hist | xnotify | sh &
	xnotify 0<>$XNOTIFY_HIST_FIFO &
else
	printf "xnotify is already running\n" >$XNOTIFY_FIFO
fi
