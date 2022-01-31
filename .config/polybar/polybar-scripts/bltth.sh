#!/bin/sh

GLYBT=""

rfkill event |
    while read -r line; do
        status=$(echo "$line" | grep "type 2" | awk '{print $10}')

        [ -z $status ] && status=1
        if [ "$status" -eq 1 ]; then
            echo "%{F#626262}${GLYBT}"
        elif [ "$status" -eq 0 ]; then
            echo "%{F#87afaf}${GLYBT}"
        fi
    done
