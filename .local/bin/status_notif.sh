#!/bin/sh

#TODO:
# make rampable icons for audio, brightness, battery, wifi (might be a pita to implement this)
#add a progress bar for brightness and volumne full view; see bright and vol scripts
#fix bspwm node flags; they dont appear for some reason
# Make this POSIX

bspwm() {
	desktop_info=$(bspc query -T -d | jq -r '.name, .layout')
	desktop_name=$(echo "$desktop_info" | head -1)
	desktop_layout=$(echo "$desktop_info" | tail -1)

	focused_node=$(bspc query -T -n)
	# Should return tiled, pseudo_tiled, floating, or fullscreen
	state=$(printf "%s" "$focused_node" | jq -r '.client.state')
	locked=$(printf "%s" "$focused_node" | jq -r '.locked')
	sticky=$(printf "%s" "$focused_node" | jq -r '.sticky')
	private=$(printf "%s" "$focused_node" | jq -r '.private')
	marked=$(printf "%s" "$focused_node" | jq -r '.marked')

	#unset state_list
	if [ "$state" = "pseudo_tiled" ]; then
		state_list=${state_list}${state_list:+,}
	elif [ "$state" = "floating" ]; then
		state_list=${state_list}${state_list:+,}
	elif [ "$state" = "fullscreen" ]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [ "$locked" = "true" ]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [ "$sticky" = "true" ]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [ "$private" = "true" ]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [ "$marked" = "true" ]; then
		state_list=${state_list}${state_list:+,}
	fi

	sani_list=$(printf "%s" "$state_list" | tr ',' ' ')

	if [ -z "$sani_list" ]; then
		sani_list=""
	else
		sani_list=" $sani_list"
	fi

	if [ "$desktop_layout" = "tiled" ]; then
		layout=
	else
		layout=
	fi

	case "$1" in
	-s | --simple)
		echo " | $desktop_name"
		;;
	-f | --full)
		if [ -n "$sani_list" ]; then
			echo " | $desktop_name: $layout,$sani_list"
		else
			echo " | $desktop_name: $layout"
		fi
		;;
	esac
}

hlwm() {
	current_tag=$(herbstclient list_monitors | grep "FOCUS" | awk '{print $5}' | sed -e 's/^"//' -e 's/"$//')

	layout=$(herbstclient attr tags.focus.tiling.focused_frame.algorithm)
	if [ "$layout" = "horizontal" ]; then
		icon=
	elif [ "$layout" = "vertical" ]; then
		icon=
	elif [ "$layout" = "max" ]; then
		icon=
	elif [ "$layout" = "grid" ]; then
		icon=
	fi

	case "$1" in
	-s | --simple)
		echo " | $current_tag"
		;;
	-f | --full)
		echo " | $current_tag: $icon"
		;;
	esac
}

calendar() {
	time=$(date +"%I:%M %p")
	date=$(date +"%A, %B %d")

	case "$1" in
	-s | --simple)
		echo " | $time"
		;;
	-f | --full)
		echo " | $time\n | $date"
		;;
	esac
}

audio() {
	case "$1" in
	-s | --simple)
		#mute_state=$(pulsemixer --get-mute)
		mute_state=$(amixer get Master | grep "Mono" | awk '{print $6}' | sed -r '/^\s*$/d')

		if [ "$mute_state" = "[on]" ]; then
			#vol=$(pulsemixer --get-volume | awk '{print $1}')
			vol=$(amixer get Master | grep "Mono" | awk '{print $4}' | tr -d -c 0-9)
			vol="$vol%"
		elif [ "$mute_state" = "[off]" ]; then
			vol="Muted"
		fi

		if [ "$vol" = "Muted" ]; then
			echo " | $vol"
		else
			echo " | $vol"
		fi
		;;
	-f | --full)
		FULL=""
		EMPTY=""
		value="${3:-5}"

		#mute_state=$(pulsemixer --get-mute)
		mute_state=$(amixer get Master | grep "Mono" | awk '{print $6}' | sed -r '/^\s*$/d')

		if [ "$mute_state" = "[on]" ]; then
			#vol=$(pulsemixer --get-volume | awk '{print $1}')
			vol=$(amixer get Master | grep "Mono" | awk '{print $4}' | tr -d -c 0-9)
			vol="$vol"
		elif [ "$mute_state" = "[off]" ]; then
			vol="Muted"
		fi

		if [ "$vol" = "Muted" ]; then
			echo " | $vol"
		else
			barFull=$(seq -s "$FULL" $((vol / 10)) | sed 's/[0-9]//g')
			barEmpty=$(seq -s "$EMPTY" $((11 - vol / 10)) | sed 's/[0-9]//g')

			printf "%b" " | $barFull$barEmpty $vol%"
		fi
		;;
	esac
}

brightness() {
	case "$1" in
	-s | --simple)
		#brightness=$(busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get "s" "" | awk '{print $3*100}')
		#brightness=$(echo "($brightness+0.5)/1" | bc)
		brightness=$(echo "$(xbacklight)/1" | bc)
		echo " | $brightness%"
		;;
	-f | --full)
		FULL=""  #"•"
		EMPTY="" #"○"
		value="${3:-5}"
		#brightness="$(busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get "s" "" | awk '{print $3*100}')"
		#brightness=$(echo "($brightness+0.5)/1" | bc)
		brightness=$(echo "$(xbacklight)/1" | bc)
		barFull=$(seq -s "$FULL" $((brightness / 10)) | sed 's/[0-9]//g')
		barEmpty=$(seq -s "$EMPTY" $((11 - brightness / 10)) | sed 's/[0-9]//g')
		printf "%b" " | $barFull$barEmpty $brightness%"
		;;
	esac
}

battery() {
	case "$1" in
	-s | --simple)
		if [ "$(acpi | wc -l)" = "1" ]; then
			if [ "$(acpi | awk '{print $3}')" = "Charging," ]; then
				echo " | $(acpi | awk '{print $4}' | cut -d',' -f1)"
			elif [ "$(acpi | awk '{print $3}')" = "Full," ]; then
				echo " | Full"
			else
				echo " | $(acpi | awk '{print $4}' | cut -d',' -f1)"
			fi
		else
			if [ "$(acpi | awk 'NR=2 {print $3}')" = "Charging," ]; then
				echo " | $(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)"
			elif [ "$(acpi | awk 'NR=2 {print $3}')" = "Full," ]; then
				echo " | Full"
			else
				echo " | $(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)"
			fi
		fi
		;;
	-f | --full)
		if [ "$(acpi | wc -l)" = "1" ]; then
			state=$(acpi | awk '{print $3}')
			if [ "$state" = "Charging," ]; then
				percent=$(acpi | awk '{print $4}' | cut -d',' -f1)
				time=$(acpi | awk NR=1 | awk '{print $5, $6, $7}')
				echo " | $percent, $time"
			elif [ "$state" = "Full," ]; then
				echo " | Full"
			else
				percent=$(acpi | awk '{print $4}' | cut -d',' -f1)
				time=$(acpi | awk NR=1 | awk '{print $5, $6}')
				echo " | $percent, $time"
			fi
		else
			state=$(acpi | awk 'NR=2 {print $3}')
			if [ "$state" = "Charging," ]; then
				percent=$(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)
				time=$(acpi | awk 'NR=2 {print $5, $6, $7}')
				echo " | $percent, $time"
			elif [ "$state" = "Full," ]; then
				echo " | Full"
			else
				percent=$(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)
				time=$(acpi | awk 'NR=2 {print $5, $6}')
				echo " | $percent, $time"
			fi
		fi
		;;
	esac
}

internet() {
	case "$1" in
	-f | --full)
		simple=false
		;;
	-s | --simple | *)
		simple=true
		;;
	esac

	connection_type=$(nmcli d | grep connected | head -1 | awk '{print $1}')

	if [ "$connection_type" = "enp4s0" ]; then
		echo " | $(nmcli d | grep connected | awk '{print $4}')"
	elif [ "$connection_type" = "wlp5s0" ]; then
		signal=$(nmcli -g IN-USE,SIGNAL d wifi list | grep "*" | cut -d':' -f2)
		ssid=$(nmcli -g IN-USE,SSID d wifi list | grep "*" | cut -d':' -f2)
		if $simple; then
			echo " | $signal%"
		else
			echo " | $signal%, $ssid"
		fi
	else
		echo "internet: Disconnected"
	fi
}

taskwarrior() {
	case "$1" in
	-f | --full)
		simple=false
		;;
	-s | --simple | *)
		simple=true
		;;
	esac

	most_urgent_desc=$(task rc.verbose: rc.report.next.columns:description rc.report.next.labels:1 limit:1 next)
	most_urgent_urgency=$(task rc.verbose: rc.report.next.columns:urgency rc.report.next.labels:1 limit:1 next)
	most_urgent_due=$(task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next)

	if $simple; then
		if echo "$most_urgent_urgency >= 1" | bc -l; then
			echo " | $most_urgent_desc"
		fi
	else
		if echo "$most_urgent_urgency >= 1" | bc -l && [ -n "$most_urgent_due" ]; then
			echo " | $most_urgent_desc ·  $most_urgent_due"
		else
			echo " | $most_urgent_desc"
		fi
	fi
}

bluetooth() {
	power=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

	if [ "$power" = "no" ]; then
		echo " | Off"
	else
		devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
		counter=0

		for device in $devices_paired; do
			device_info=$(bluetoothctl info "$device")

			if echo "$device_info" | grep -q "Connected: yes"; then
				device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

				if [ $counter -gt 0 ]; then
					device_list="$device_list, $device_alias"
				else
					device_list="$device_alias"
				fi

				counter=$((counter + 1))
			fi
		done
		if [ -z "$devices_paired" ]; then
			echo " | on"
		else
			echo " | $device_list"
		fi
	fi
}

rdshift() {
	pgrep -x redshift >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		temp=$(redshift -p 2>/dev/null | grep "Color" | awk '{print $3}')
		echo " | $temp"
	else
		echo " | Disabled"
	fi
}

vpn() {
	connections=$(nmcli d | grep "vpn0\|acer")
	if [ -n "$connections" ]; then
		for c in $connections; do
			name=$(echo "$c" | awk '{print $1}')
			status=$(echo "$c" | awk '{print $3}')
			if [ $(echo "$connections" | wc -l) -gt 1 ]; then
				state="$state, $name $status"
			else
				state="$name $status"
			fi
		done
		echo " | $state"
	else
		echo " | No connections"
	fi
}
case "$1" in
--bspwm)
	wm=$(bspwm --full)
	printf "SEC:3\t$wm\n" >$XNOTIFY_FIFO
	;;
--calendar)
	cal=$(calendar --full)
	printf "SEC:3\t$cal\n" >$XNOTIFY_FIFO
	;;
--audio)
	sound=$(audio --full)
	printf "SEC:3\t$sound\n" >$XNOTIFY_FIFO
	;;
--brightness)
	light=$(brightness --full)
	printf "SEC:3\t$light\n" >$XNOTIFY_FIFO
	;;
--battery)
	power=$(battery --full)
	printf "SEC:3\t$power\n" >$XNOTIFY_FIFO
	;;
--internet)
	interweb=$(internet --full)
	prinyf "SEC:\t3\t$interweb\n" >$XNOTIFY_FIFO
	;;
--task)
	task=$(taskwarrior --full)
	printf "SEC:3\t$task\n" >$XNOTIFY_FIFO
	;;
--bluetooth)
	blue=$(bluetooth)
	printf "SEC:3\t$blue\n" >$XNOTIFY_FIFO
	;;
--redshift)
	red=$(rdshift)
	printf "SEC:3\t$red\n" >$XNOTIFY_FIFO
	;;
--vpn)
	vvpn=$(vpn)
	printf "SEC:3\t$vvpn\n" >$XNOTIFY_FIFO
	;;
--extra)
	vvvpn=$(vpn)
	bt=$(bluetooth)
	rs=$(rdshift)
	taskw=$(taskwarrior --full)
	extra=$(echo "$bt\t$rs\t$vvvpn\t$taskw")
	printf "SEC:5\t$extra\n" >$XNOTIFY_FIFO
	;;
--full)
	wm=$(bspwm --full)
	cal=$(calendar --full)
	sound=$(audio --full)
	light=$(brightness --full)
	power=$(battery --full)
	interweb=$(internet --full)
	task=$(taskwarrior --full)
	vvpn=$(vpn)
	bt=$(bluetooth)
	rs=$(rdshift)
	full=$(echo "$wm\t$cal\t$sound\t$light\t$power\t$interweb\t$bt\t$rs\t$vvpn\t$task")
	printf "SEC:5\t$full\n" >$XNOTIFY_FIFO
	;;
--simple | *)
	wm=$(bspwm --simple)
	cal=$(calendar --simple)
	sound=$(audio --simple)
	light=$(brightness --simple)
	power=$(battery --simple)
	interweb=$(internet --simple)
	simple=$(echo "$wm\n$cal\n$sound\n$light\n$power\n$interweb")
	printf "SEC:5\t$simple\n" >$XNOTIFY_FIFO
	;;
esac
