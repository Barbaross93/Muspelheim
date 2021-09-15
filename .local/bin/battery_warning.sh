#!/bin/sh

if [ "$(acpi | wc -l)" = "1" ]; then
	battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	if [ "$battery_level" -le 5 ]; then
		sudo ZZZ
	elif [ "$battery_level" -le 10 ]; then
		#printf "BRD:#af5f5f\tSEC:5\tBattery low\tBattery level is ${battery_level}%%!\n" >$XNOTIFY_FIFO
		notify-send -u critical -t 5000 "Battery low" "Battery level is ${battery_level}%!"
	elif [ "$battery_level" -ge 100 ]; then
		#printf "SEC:10\tBattery Full\tDisconnect the power\n" >$XNOTIFY_FIFO
		notify-send -t 10000 "Battery Full" "Disconnect the power"
	fi
else
	battery_level=$(acpi -b | awk NR==2 | grep -P -o '[0-9]+(?=%)')
	if [ "$battery_level" -le 5 ]; then
		sudo ZZZ
	elif [ "$battery_level" -le 10 ]; then
		#printf "BRD:#af5f5f\tSEC:10\tBattery low\tBattery level is ${battery_level}%%!\n" >$XNOTIFY_FIFO
		notify-send -u critical -t 10000 "Battery low" "Battery level is ${battery_level}%!"
	elif [ "$battery_level" -ge 100 ]; then
		#printf "SEC:5\tBattery Full\tDisconnect the power\n" >$XNOTIFY_FIFO
		notify-send -t 5000 "Battery Full" "Disconnect the power"
	fi
fi
