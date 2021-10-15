#!/usr/bin/env bash

eww_window() {
	if "$icon_window"; then
		eww open notification_icon
	else
		eww open notification
	fi
}

case "$1" in
	-c|--close)
		eww close-all
		rm /tmp/notif_count
		exit
		;;
	-n|--new)
		if [ ! -f /tmp/notif_count ]; then
			eww close-all
			exit
		fi
		old=false
		;;
	-o|--old|*)
		old=true
		;;
esac

# If our source file doesn't exist, notifs aren't running and this script is moot. quit here.
if [ ! -f /tmp/notif_raw ]; then
	exit
fi

if [ -f /tmp/notif_count ]; then
	current_count=$(cat /tmp/notif_count)
	total_notifs=$(cat /tmp/notif_raw | wc -l)

	# Check to make sure we don't go over the max number of notifs that exist
	if "$old" && [ "$current_count" -ge "$total_notifs" ]; then
		exit
	fi

	if $old; then
		count_change=$(( current_count + 1 ))
	else
		count_change=$(( current_count - 1 ))
	fi

	# If the count is 0, that means we were already looking at the newest notif. Quit here
	if [ "$count_change" -eq 0 ]; then
		eww close-all
		rm /tmp/notif_count
		exit
	fi

	# report the new count change
	echo "$count_change" | tee /tmp/notif_count >/dev/null
else
	# If count pipe doesn't exist, means we're just starting to look at history
	if $old; then
		touch /tmp/notif_count
		echo "1" | tee /tmp/notif_count >/dev/null
	else
		# Nothing should happen if I pass new and we were already on latest history
		exit
	fi
fi

# The count currently tells us which line from the top we want to look at
count=$(cat /tmp/notif_count)

# Reverse order of notifs, make it easier to grab specific line
top_to_bottom=$(tac /tmp/notif_raw)
reverse_date=$(tac /tmp/notif_timelog)

#extract the actual line we want
relevant_line=$(sed "${count}q;d" <(echo "$top_to_bottom"))
relevant_date=$(sed "${count}q;d" <(echo "$reverse_date"))

#Close eww just in case it's already opened
eww close-all
#sleep 0.3

# Send info to named pipes for eww
echo "$relevant_line" | jq -r '.summary' | tee /tmp/notif_summary >/dev/null
echo "$relevant_line" | jq -r '.body' | tee /tmp/notif_body >/dev/null
echo "$relevant_date" | tee /tmp/notif_time

icon=$(echo "$relevant_line" | jq -r '.app_icon')
echo "$icon" | tee /tmp/notif_icon >/dev/null
# Check to determine which eww window we'll open
if [ -f "$icon" ]; then
	icon_window=true
else
	icon_window=false
fi

#Determine urgency and open notifs
urgency=$(echo "$relevant_line" | jq -r '.hints.urgency')
if [[ "$urgency" == "0" ]]; then
	# Low urgency
	echo "#89beba" | tee /tmp/notif_urgency >/dev/null
	eww_window
elif [[ "$urgency" == "1" ]]; then
	# Normal Urgency
	echo "#a7c080" | tee /tmp/notif_urgency >/dev/null
	eww_window
elif [[ "$urgency" == "2" ]]; then
	#Critical notifications stay until I make them go away
	echo "#e68183" | tee /tmp/notif_urgency >/dev/null
	eww_window
else
	#If notif doesn't have urgency, treat as normal
	echo "#a7c080" | tee /tmp/notif_urgency >/dev/null
	eww_window
fi
