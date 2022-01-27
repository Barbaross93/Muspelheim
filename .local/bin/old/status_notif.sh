#!/bin/sh

#TODO:
# make rampable icons for audio, brightness, battery, wifi (might be a pita to implement this)
#fix bspwm node flags; they dont appear for some reason

sep='<span foreground="#878787">⏹</span>'

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
		echo "<span foreground='#af5f5f'></span> $sep $desktop_name"
		;;
	-f | --full)
		if [ -n "$sani_list" ]; then
			echo "<span foreground='#af5f5f'></span> $sep $desktop_name: $layout,$sani_list"
		else
			echo "<span foreground='#af5f5f'></span> $sep $desktop_name: $layout"
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
		echo " $sep $current_tag"
		;;
	-f | --full)
		echo " $sep $current_tag: $icon"
		;;
	esac
}

calendar() {
	time=$(date +"%I:%M %p")
	date=$(date +"%A, %B %d")

	case "$1" in
	-s | --simple)
		echo "<span foreground='#87875f'></span> $sep $time"
		;;
	-f | --full)
		env printf "<span foreground='#87875f'></span> $sep $time\n<span foreground='#af875f'></span> $sep $date"
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
			vol="Muted"
		fi

		if [ "$vol" = "Muted" ]; then
			echo "<span foreground='#57875f></span> $sep $vol"
		else
			echo "<span foreground='#57875f'></span> $sep $vol"
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
			echo "<span foreground='#57875f'></span> $sep $vol"
		else
			barFull=$(seq -s "$FULL" $((vol / 10)) | sed 's/[0-9]//g')
			barEmpty=$(seq -s "$EMPTY" $((11 - vol / 10)) | sed 's/[0-9]//g')

			printf "%b" "<span foreground='#57875f'></span> $sep $barFull$barEmpty $vol%%"
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
		echo "<span foreground='#af875f'></span> $sep $brightness%%"
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
		printf "%b" "<span foreground='#af875f'></span> $sep $barFull$barEmpty $brightness%%"
		;;
	esac
}

battery() {
	case "$1" in
	-s | --simple)
		if [ "$(acpi | wc -l)" = "1" ]; then
			if [ "$(acpi | awk '{print $3}')" = "Charging," ]; then
				echo "<span foreground='#87875f'></span> $sep $(acpi | awk '{print $4}' | cut -d',' -f1)%"
			elif [ "$(acpi | awk '{print $3}')" = "Full," ]; then
				echo "<span foreground='#87875f'></span> $sep Full"
			else
				echo "<span foreground='#87875f'></span> $sep $(acpi | awk '{print $4}' | cut -d',' -f1)%"
			fi
		else
			if [ "$(acpi | awk 'NR=2 {print $3}')" = "Charging," ]; then
				echo "<span foreground='#87875f'></span> $sep $(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)"
			elif [ "$(acpi | awk 'NR=2 {print $3}')" = "Full," ]; then
				echo "<span foreground='#87875f'></span> $sep Full"
			else
				echo "<span foreground='#87875f'></span> $sep $(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)%"
			fi
		fi
		;;
	-f | --full)
		if [ "$(acpi | wc -l)" = "1" ]; then
			state=$(acpi | awk '{print $3}')
			if [ "$state" = "Charging," ]; then
				percent=$(acpi | awk '{print $4}' | cut -d',' -f1)
				time=$(acpi | awk NR=1 | awk '{print $5, $6, $7}')
				echo "<span foreground='#87875f'></span> $sep $percent%, $time"
			elif [ "$state" = "Full," ]; then
				echo "<span foreground='#87875f'></span> $sep Full"
			else
				percent=$(acpi | awk '{print $4}' | cut -d',' -f1)
				time=$(acpi | awk NR=1 | awk '{print $5, $6}')
				echo "<span foreground='#87875f'></span> $sep $percent%, $time"
			fi
		else
			state=$(acpi | awk 'NR=2 {print $3}')
			if [ "$state" = "Charging," ]; then
				percent=$(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)
				time=$(acpi | awk 'NR=2 {print $5, $6, $7}')
				echo "<span foreground='#87875f'></span> $sep $percent%, $time"
			elif [ "$state" = "Full," ]; then
				echo " $sep Full"
			else
				percent=$(acpi | awk 'NR=2 {print $4}' | cut -d',' -f1)
				time=$(acpi | awk 'NR=2 {print $5, $6}')
				echo "<span foreground='#87875f'></span> $sep $percent%, $time"
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
		echo "<span foreground='#af8787'></span> $sep $(nmcli d | grep connected | awk '{print $4}')"
	elif [ "$connection_type" = "wlp5s0" ]; then
		signal=$(nmcli -g IN-USE,SIGNAL d wifi list | grep "*" | cut -d':' -f2)
		ssid=$(nmcli -g IN-USE,SSID d wifi list | grep "*" | cut -d':' -f2)
		if $simple; then
			echo "<span foreground='#af8787'></span> $sep $signal%%"
		else
			echo "<span foreground='#af8787'></span> $sep $signal%%, $ssid"
		fi
	else
		echo "<span foreground='#af8787'>Net</span> $sep: Disconnected"
	fi
}

taskwarrior() {
	num=$(task active | wc -l)
	if [ "$num" -gt 1 ]; then
		active_task=$(task rc.gc=no rc.indent.report=4 rc.verbose= rc.report.next.columns=description.desc rc.report.next.labels= rc.defaultwidth=1000 next +ACTIVE 2>/dev/null </dev/null | sed -n '4 p' | awk '$1=$1')
		echo "<span foreground='#af8787'></span> $sep $active_task"
	else
		echo "<span foreground='#af8787'></span> $sep No active task"
	fi
}

rdshift() {
	pgrep -x redshift >/dev/null 2>&1
	if [ $? -eq 0 ]; then

		temp=$(redshift -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lat, .location.lng' | tr '\n' ':' | sed 's/:$//') -p 2>/dev/null | grep "Color" | awk '{print $3}')
		#temp=$(redshift -p 2>/dev/null | grep "Color" | awk '{print $3}')
		echo "<span foreground='#af5f5f'></span> $sep $temp"
	else
		echo "<span foreground='#af5f5f'></span> $sep Disabled"
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
		echo "<span foreground='#87afaf'></span> $sep $state"
	else
		echo "<span foreground='#87afaf'></span> $sep No connections"
	fi
}
case "$1" in
--bspwm)
	wm=$(bspwm --full)
	notify-send "Bspwm" "$wm"
	#printf "SEC:3\t$wm\n" >$XNOTIFY_FIFO
	;;
--calendar)
	cal=$(calendar --full)
	notify-send "Time" "$cal"
	#printf "SEC:3\t$cal\n" >$XNOTIFY_FIFO
	;;
--audio)
	sound=$(audio --full)
	notify-send "Audio" "$sound"
	#printf "SEC:3\t$sound\n" >$XNOTIFY_FIFO
	;;
--brightness)
	light=$(brightness --full)
	notify-send "Backlight" "$light"
	#printf "SEC:3\t$light\n" >$XNOTIFY_FIFO
	;;
--battery)
	power=$(battery --full)
	notify-send "Battery" "$power"
	#printf "SEC:3\t$power\n" >$XNOTIFY_FIFO
	;;
--internet)
	interweb=$(internet --full)
	notify-send "Internet" "$interweb"
	#printf "SEC:\t3\t$interweb\n" >$XNOTIFY_FIFO
	;;
--redshift)
	red=$(rdshift)
	notify-send "Redshift" "$red"
	#printf "SEC:3\t$red\n" >$XNOTIFY_FIFO
	;;
--taskwarrior)
	taskw=$(taskwarrior)
	notify-send "Taskwarrior" "$taskw"
	;;
--vpn)
	vvpn=$(vpn)
	notify-send "VPN" "$vvpn"
	#printf "SEC:3\t$vvpn\n" >$XNOTIFY_FIFO
	;;
--extra)
	vvpn=$(vpn)
	rs=$(rdshift)
	taskw=$(taskwarrior)
	ex=$(env printf "$vvpn\n$rs\n$taskw")
	notify-send -t 10000 "Extra Information:" "$ex"
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
	#bt=$(bluetooth)
	rs=$(rdshift)
	fulll=$(env printf "$wm\n$cal\n$sound\n$light\n$power\n$interweb\n$vvpn\n$rs\n$task")
	notify-send -t 15000 "Greetings, $USER" "$fulll"
	#printf "SEC:10\t$wm\t$cal\t$sound\t$light\t$power\t$interweb\t$bt\t$rs\t$vvpn\t$task\n" >$XNOTIFY_FIFO
	;;
--simple | *)
	wm=$(bspwm --simple)
	cal=$(calendar --simple)
	sound=$(audio --simple)
	light=$(brightness --simple)
	power=$(battery --simple)
	interweb=$(internet --simple)
	simple=$(env printf "$wm\n$cal\n$sound\n$light\n$power\n$interweb")
	notify-send -t 10000 "Greetings, $USER" "$simple"
	#printf "SEC:15\t$simple\n" >$XNOTIFY_FIFO
	;;
esac
