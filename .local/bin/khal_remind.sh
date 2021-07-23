#!/bin/sh

now=$(echo $(date +"%H%M"))          # define current time in 24H format
hr=$(echo $(date +"%H%M") + 10 | bc) # define time + 1H in 24H format
# Check all today's events
khal list now 12h | tail -n +2 | while read -r line; do # make sure to use a khal config file where the date format is in 24H format
	apt=$(echo $line | cut -d'-' -f1 | sed 's/://g' | bc)
	# Check if each event will occur within the next hour
	if [ $apt -le $hr ] && [ $apt -ge $now ]; then
		printf "BRD:#458588\tEvent Reminder\t$line\n" >$XNOTIFY_FIFO
	fi
done
