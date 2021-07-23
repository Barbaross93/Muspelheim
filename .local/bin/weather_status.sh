#!/bin/sh

icon=$(cat /tmp/weather/weather-icon)
temp=$(cat /tmp/weather/weather-degree)
status=$(weather_trimmer.sh)
quote=$(cat /tmp/weather/weather-quote | head -n1 | sed 's/\\n/\
/g')

printf "SEC:3\t$icon$temp\t$status\t$quote\n" >$XNOTIFY_FIFO
