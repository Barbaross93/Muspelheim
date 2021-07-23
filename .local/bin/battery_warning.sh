#!/bin/sh

#export PATH="/home/barbarossa/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
#export DISPLAY=":0"
#export XAUTHORITY="/home/barbarossa/.Xauthority"
#export XDG_RUNTIME_DIR="/run/user/1000"
#export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

if [ "$(acpi | wc -l)" = "1" ]; then
	battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	if [ "$battery_level" -le 5 ]; then
		poweroff
	elif [ "$battery_level" -le 10 ]; then
		printf "BRD:#cc241d\tSEC:5\tBattery low\tBattery level is ${battery_level}%!\n" >$XNOTIFY_FIFO
		#dunstify -t 5000 -r 221 "Battery low" "Battery level is ${battery_level}%!"
	elif [ "$battery_level" -ge 100 ]; then
		printf "SEC:10\tBattery Full\tDisconnect the power\n" >$XNOTIFY_FIFO
		#dunstify -u critical -t 10000 -r 221 "Battery Full" "Disconnect the power"
	fi
else
	battery_level=$(acpi -b | awk NR==2 | grep -P -o '[0-9]+(?=%)')
	if [ "$battery_level" -le 5 ]; then
		poweroff
	elif [ "$battery_level" -le 10 ]; then
		printf "BRD:#cc241d\tSEC:10\tBattery low\tBattery level is ${battery_level}%!\n" >$XNOTIFY_FIFO
		#dunstify -u critical -t 10000 -r 221 "Battery low" "Battery level is ${battery_level}%!"
	elif [ "$battery_level" -ge 100 ]; then
		printf "SEC:5\tBattery Full\tDisconnect the power\n" >$XNOTIFY_FIFO
		#dunstify -t 5000 -r 221 "Battery Full" "Disconnect the power"
	fi
fi
