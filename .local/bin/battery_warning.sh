#!/bin/sh

battery_level=$(acpi -b | awk NR==1 | grep -P -o '[0-9]+(?=%)')
if [ "$battery_level" -le 5 ]; then
	sudo ZZZ
elif [ "$battery_level" -le 10 ]; then
	notify-send -u critical -t 5000 "Battery low" "Battery level is ${battery_level}%!"
elif [ "$battery_level" -ge 100 ]; then
	notify-send -t 10000 "Battery Full" "Disconnect the power"
fi

bt_bat_check=$(acpi -b | wc -l)
if [ $bt_bat_check -eq 2 ]; then
	bt_bat_lvl=$(cat /sys/class/power_supply/hid-34:88:5d:b6:e9:13-battery/capacity)
	if [ "$bt_bat_lvl" -le 10 ]; then
		notify-send -u critical -t 5000 "Battery low" "Bluetooth battery level is low! ${bt_bat_lvl}% remaining!"
	fi
fi
