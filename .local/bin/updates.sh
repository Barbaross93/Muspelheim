#!/bin/sh

if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
    updates_arch=0
fi

if ! updates_aur=$(paru -Qua 2>/dev/null | wc -l); then
    updates_aur=0
fi

updates=$(($updates_arch + $updates_aur))

if [ "$updates" -gt 0 ]; then
    #echo " $updates"
    printf "SEC:3\t Updates: $updates\n" >$XNOTIFY_FIFO
fi
