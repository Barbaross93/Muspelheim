#!/bin/sh

now=$(date -d 'now' +"%H%M")         # define current time in 24H format
hr=$(date -d 'now + 10 min' +"%H%M") # define time + 1H in 24H format
# Check all today's events
khal list now 12h | tail -n +2 | while read -r line; do # make sure to use a
       apt=$(echo $line | cut -d'-' -f1 | sed 's/://g' | bc)
       # Check if each event will occur within the next hour
       if [ $apt -le $hr ] && [ $apt -ge $now ]; then
               notify-send -u low "Khal Event Reminder" "$line"
       fi
done
