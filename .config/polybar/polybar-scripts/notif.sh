#!/bin/bash

. "$HOME/.config/herbstluftwm/colorschemes/alduin.sh"
ORANGE="%{F$color19}"
CLR="%{B-}%{F-}"

# Signal fifo; not sure how to optimize this
[[ -e /tmp/signal_bar ]] && rm /tmp/signal_bar
mkfifo /tmp/signal_bar
tail -f /tmp/signal_bar |
    while read -r line; do
        [[ "$line" == "skip" ]] && touch /tmp/notif_skip
        [[ "$line" == "pause" ]] && touch /tmp/notif_pause
        [[ "$line" == "resume" ]] && rm /tmp/notif_pause 2>/dev/null
    done &

# Notif logic
[[ -e /tmp/old_notifs ]] && rm /tmp/old_notifs
mkfifo /tmp/old_notifs
{
    tiramisu -o "#summary\t#body\t#timeout" &
    tail -f /tmp/old_notifs &
} |
    while read -r line; do
        # Easy to spam binding, clean up first before cont.
        [[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip

        # We block the foreground until rofi is dead, if its running
        pid=$(pgrep -x rofi)
        if [ -n "$pid" ]; then
            tail --pid="$pid" -f /dev/null
        fi

        # If pause signal was sent to script
        if [[ -f "/tmp/notif_pause" ]]; then
            # Block foreground until file gets deleted
            inotifywait -q -q /tmp/notif_pause
        fi

        # Duplicate any '%' to process them as literal '%' in lemonbar
        line=${line//%/%%}

        case "$line" in
        LOG*)
            line="${line#LOG }"
            pretext="${ORANGE} NOTIF HISTORY:${CLR} "
            ;;
        *)
            echo "LOG $line" >>/tmp/notif_log
            pretext="${ORANGE} NOTIFICATION:${CLR} "
            ;;
        esac
        body="$(echo -e "$line" | cut -f1 -)"
        summary="$(echo -e "$line" | cut -f2 -)"
        timeout="$(echo -e "$line" | cut -f3 -)"
        notif="$summary"

        # Determine actual timeout in secs
        if [ "$timeout" = "-1" ]; then
            time=10.0
        else
            time=$(echo "scale=1;$timeout/1000" | bc)
        fi

        # If summary is blank, display body instead
        [ -z "$notif" ] && notif="$body"

        # Scroll if greater than 70 characters
        if [ ${#notif} -gt 70 ]; then
            end=$((SECONDS + ${time%.*}))
            while [ $SECONDS -lt $end ]; do
                [[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip && break
                c=0
                length=${#notif}
                while [ $c -le $length ]; do
                    [ $SECONDS -ge $end ] && break
                    [[ -f "/tmp/notif_skip" ]] && break
                    scrollstart=${notif:$c:70}
                    if [ ${#scrollstart} -eq 70 ]; then
                        echo "$pretext$scrollstart..."
                        [ $c -eq 0 ] && sleep 1
                    else
                        echo "$pretext$scrollstart"
                    fi
                    c=$((c + 1))
                    sleep 0.2
                done
            done
        else
            echo "$pretext$notif"
            c=0
            while (($(echo "$c <= $time" | bc -l))); do
                [[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip && break
                sleep 0.2
                c=$(echo "scale=1;$c + 0.2" | bc)
            done
        fi

        echo "${CLR}"
    done