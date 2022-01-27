#!/bin/sh

##
##   ██████ ▄▄▄█████▓ ▄▄▄     ▄▄▄█████▓ █    ██   ██████
## ▒██    ▒ ▓  ██▒ ▓▒▒████▄   ▓  ██▒ ▓▒ ██  ▓██▒▒██    ▒
## ░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄ ▒ ▓██░ ▒░▓██  ▒██░░ ▓██▄
##   ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██░ ▓██▓ ░ ▓▓█  ░██░  ▒   ██▒
## ▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒ ▒██▒ ░ ▒▒█████▓ ▒██████▒▒
## ▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░ ▒ ░░   ░▒▓▒ ▒ ▒ ▒ ▒▓▒ ▒ ░
## ░ ░▒  ░ ░    ░      ▒   ▒▒ ░   ░    ░░▒░ ░ ░ ░ ░▒  ░ ░
## ░  ░  ░    ░        ░   ▒    ░       ░░░ ░ ░ ░  ░  ░
##       ░                 ░  ░           ░           ░
##
##  ███▄    █  ▒█████  ▄▄▄█████▓ ██▓  █████▒
##  ██ ▀█   █ ▒██▒  ██▒▓  ██▒ ▓▒▓██▒▓██   ▒
## ▓██  ▀█ ██▒▒██░  ██▒▒ ▓██░ ▒░▒██▒▒████ ░
## ▓██▒  ▐▌██▒▒██   ██░░ ▓██▓ ░ ░██░░▓█▒  ░
## ▒██░   ▓██░░ ████▓▒░  ▒██▒ ░ ░██░░▒█░
## ░ ▒░   ▒ ▒ ░ ▒░▒░▒░   ▒ ░░   ░▓   ▒ ░
## ░ ░░   ░ ▒░  ░ ▒ ▒░     ░     ▒ ░ ░
##    ░   ░ ░ ░ ░ ░ ▒    ░       ▒ ░ ░ ░
##          ░     ░ ░            ░

#TODO:
# fix bspwm node flags; they dont appear for some reason
# Separate internet info as third option (so vpn, SSID, signal)
# replace with pomo info, bluetooth

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
		sani_list="_$sani_list"
	fi

	if [ "$desktop_layout" = "tiled" ]; then
		layout=
	else
		layout=
	fi

	case "$1" in
	-s | --simple)
		echo "$desktop_name"
		;;
	-f | --full)
		if [ -n "$sani_list" ]; then
			echo "$layout,$sani_list"
		else
			echo "$layout"
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
		echo "$current_tag"
		;;
	-f | --full)
		echo "$icon"
		;;
	esac
}

calendar() {
	time=$(date +"%I:%M_%p")
	date=$(date +"%A,_%B_%d")

	case "$1" in
	-s | --simple)
		echo "$time"
		;;
	-f | --full)
		echo "$date"
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
			vol="$vol%%"
		elif [ "$mute_state" = "[off]" ]; then
			vol="0%%"
		fi

		printf "%s" "$vol"
		;;
	esac
}

brightness() {
	case "$1" in
	-s | --simple)
		#brightness=$(busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get "s" "" | awk '{print $3*100}')
		#brightness=$(echo "($brightness+0.5)/1" | bc)
		brightness=$(echo "$(xbacklight)/1" | bc)
		echo "$brightness%%"
		;;
	esac
}

battery() {
	case "$1" in
	-s | --simple)
		if [ "$(acpi | wc -l)" = "1" ]; then
			if [ "$(acpi | awk '{print $3}')" = "Charging," ]; then
				echo "$(acpi | awk '{print $4}' | cut -d',' -f1)%"
			elif [ "$(acpi | awk '{print $3}')" = "Full," ]; then
				echo "Full"
			else
				echo "$(acpi | awk '{print $4}' | cut -d',' -f1)%"
			fi
		else
			if [ "$(acpi | awk 'NR=2 {print $3}')" = "Charging," ]; then
				echo "$(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)"
			elif [ "$(acpi | awk 'NR=2 {print $3}')" = "Full," ]; then
				echo "Full"
			else
				echo "$(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)%"
			fi
		fi
		;;
	-f | --full)
		if [ "$(acpi | wc -l)" = "1" ]; then
			state=$(acpi | awk '{print $3}')
			if [ "$state" = "Charging," ]; then
				time=$(acpi | awk NR=1 | awk '{print $5}')
				echo "$time"
			elif [ "$state" = "Full," ]; then
				echo "Full"
			else
				time=$(acpi | awk NR=1 | awk '{print $5}')
				echo "$time"
			fi
		else
			state=$(acpi | awk 'NR=2 {print $3}')
			if [ "$state" = "Charging," ]; then
				time=$(acpi | awk 'NR=2 {print $5}')
				echo "$time"
			elif [ "$state" = "Full," ]; then
				echo "Full"
			else
				time=$(acpi | awk 'NR=2 {print $5}')
				echo "$time"
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
		echo "$(nmcli d | grep connected | awk '{print $4}')"
	elif [ "$connection_type" = "wlp5s0" ]; then
		signal=$(nmcli -g IN-USE,SIGNAL d wifi list | grep "*" | cut -d':' -f2)
		ssid=$(nmcli -g IN-USE,SSID d wifi list | grep "*" | cut -d':' -f2)
		if $simple; then
			echo "$signal%%"
		else
			echo "$ssid"
		fi
	else
		echo "None"
	fi
}

rdshift() {
	pgrep -x redshift >/dev/null 2>&1
	if [ $? -eq 0 ]; then

		temp=$(redshift -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lat, .location.lng' | tr '\n' ':' | sed 's/:$//') -p 2>/dev/null | grep "Color" | awk '{print $3}')
		#temp=$(redshift -p 2>/dev/null | grep "Color" | awk '{print $3}')
		echo "$temp"
	else
		echo "Disabled"
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
		echo "$(echo $state | tr ' ' '_')"
	else
		echo "None"
	fi
}

# TODO: I should optimize the first part of the spacing of the printf statements in order to allow greatest flexibility for second part
case "$1" in
--extra)
	wm=$(env printf "%-45.45s %65.65s\n" "Window_properties<span_foreground='#626262'>_" "_</span><span_foreground='#af8787'><b>$(bspwm --full)</b></span>")
	cal=$(env printf "%-38.38s %71.71s\n" "Today_is<span_foreground='#626262'>_" "_</span><span_foreground='#af5f5f'><b>$(calendar --full)</b></span>")
	ssid=$(env printf "%-45.45s %64.64s\n" "Connected_to<span_foreground='#626262'>_" "_</span><span_foreground='#878787'><b>$(internet --full)</b></span>")
	interweb=$(env printf "%-56.56s %54.54s\n" "Wifi_signal_strength_is_at<span_foreground='#626262'>_" "_</span><span_foreground='#87875f'><b>$(internet --simple)</b></span>")
	vvpn=$(env printf "%-55.55s %54.54s\n" "Active_vpn_connections<span_foreground='#626262'>_" "_</span><span_foreground='#87afaf'><b>$(vpn)</b></span>")
	rs=$(env printf "%-49.49s %60.60s\n" "Current_screen_temp_is<span_foreground='#626262'>_" "_</span><span_foreground='#af875f'><b>$(rdshift)</b></span>")
	ex=$(env printf "$wm\n$cal\n$ssid\n$interweb\n$vvpn\n$rs" | tr " " "." | tr "_" " ")
	notify-send -t 10000 "Wasn't enough for you?" "$ex"
	;;
--simple | *)
	wm=$(env printf "%-58.58s %51.51s\n" "You_are_on_workspace<span_foreground='#626262'>_" "_</span><span_foreground='#af8787'><b>$(bspwm --simple)</b></span>")
	cal=$(env printf "%-51.51s %58.58s\n" "It_is_currently<span_foreground='#626262'>_" "_</span><span_foreground='#af5f5f'><b>$(calendar --simple)</b></span>")
	sound=$(env printf "%-50.50s %60.60s\n" "Volume_is_at<span_foreground='#626262'>_" "_</span><span_foreground='#87afaf'><b>$(audio --simple)</b></span>")
	light=$(env printf "%-56.56s %54.54s\n" "Backlight_is_set_to<span_foreground='#626262'>_" "_</span><span_foreground='#af875f'><b>$(brightness --simple)</b></span>")
	power=$(env printf "%-56.56s %54.54s\n" "Battery_is_at<span_foreground='#626262'>_" "_</span><span_foreground='#87875f'><b>$(battery --simple)</b></span>")
	pwrtm=$(env printf "%-52.52s %57.57s\n" "Battery_time_remaining<span_foreground='#626262'>_" "_</span><span_foreground='#878787'><b>$(battery --full)</b></span>")
	fanc=$(env printf "$wm\n$cal\n$sound\n$light\n$power\n$pwrtm" | tr " " "." | tr "_" " ")
	notify-send -t 10000 "Greetings, $USER" "$fanc"
	;;
esac
