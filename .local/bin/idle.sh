#!/bin/sh

if [ $# -lt 2 ]; then
    printf "usage: %s minutes command\n" "$(basename $0)" 2>&1
    exit 1
fi

timeout=$(($1 * 60 * 1000))
shift
cmd="$@"
triggered=false

while true; do
    while :; do
        [ -f /tmp/caffeine ] || break
        sleep 0.2
    done
    tosleep=$(((timeout - $(xprintidle)) / 1000))
    if [ $tosleep -le 0 ]; then
        $triggered || $cmd
        triggered=true
    else
        triggered=false
        sleep $tosleep
    fi
done
