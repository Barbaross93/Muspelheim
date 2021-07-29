#!/usr/bin/env bash

##################################
#
# ░█░░░█▀▀░█▄█░█▀█░█▀█░█▀▄░█▀█░█▀▄
# ░█░░░█▀▀░█░█░█░█░█░█░█▀▄░█▀█░█▀▄
# ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀░░▀░▀░▀░▀
#
##################################

trap "jobs -p | xargs kill" SIGINT SIGTERM QUIT EXIT
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

. "$HOME/.config/bspwm/colorschemes/alduin.sh"

#Brought the color here b/c my theme switching script kept fucking it up
#theme=$(cat /tmp/theme_state)
#if [[ "$theme" == "dark" ]]; then
#	color18="#3c3836"
#elif [[ "$theme" == "light" ]]; then
#	color18="#ebdbb2"
#fi

#-xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso10646-*
FONTS="-f -misc-termsynu-medium-r-normal-*-14-*-*-*-*-*-iso10646-* -f -wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1 -f -slavfox-cozette-medium-r-normal--13-120-75-75-m-60-iso10646-1"
WIDTH=1920        # bar width
HEIGHT=36         # bar height
XOFF=0            # x offset
YOFF=0            # y offset
BBG=${background} # bar background color
BFG=${foreground}
BDR=${color16}

# Status constants
# Change these to modify bar behavior
BATTERY_10=98
BATTERY_9=90
BATTERY_8=80
BATTERY_7=70
BATTERY_6=60
BATTERY_5=50
BATTERY_4=40
BATTERY_3=30
BATTERY_2=20
BATTERY_1=10

# Sleep constants
CPU_SLEEP=3
RAM_SLEEP=2
TEMP_SLEEP=5
BATTERY_SLEEP=10
VPN_SLEEP=10
TIME_SLEEP=5
DATE_SLEEP=30
TRAY_SLEEP=3

#Colors
FOREGROUND="%{F$BFG}"
BLACK="%{F$color0}"
RED="%{F$color1}"
GREEN="%{F$color2}"
YELLOW="%{F$color3}"
BLUE="%{F$color4}"
MAGENTA="%{F$color5}"
CYAN="%{F$color6}"
WHITE="%{F$color7}"
GREY="%{F$color8}"
ORANGE="%{F$color16}"
CLR="%{B-}%{F-}"
FCLR="%{F-}"
LGTFG="%{F$color17}"
DRKFG="%{F$color18}"

BACKGROUND="%{B$BBG}"
LGTBG="%{B$color17}"
DRKBG="%{B$color18}"
UNDLN="%{U$BBG}"

# Formatting Strings
# I would reccomend not touching these :D
SEP=" ${BACKGROUND} ${CLR}"
SEP2="${DRKBG} ${CLR}"

# Glyphs used for both bars
GLYWIN=$(echo -e "\ue1d7")
GLYLIGHT1=$(echo -e "\ue025")
GLYLIGHT2=$(echo -e "\ue023")
GLYLIGHT3=$(echo -e "\ue024")
GLYLIGHT4=$(echo -e "\ue022")
GLYTIME=$(echo -e "\ue017")
GLYDATE=$(echo -e "\ue225")
GLYVOL1=$(echo -e "\ue04e")
GLYVOL2=$(echo -e "\ue050")
GLYVOL3=$(echo -e "\ue050")
GLYVOL4=$(echo -e "\ue05d")
GLYVOL5=$(echo -e "\ue05d")
GLYVOLM=$(echo -e "\ue04f")
GLYBAT1=$(echo -e "\ue242")
GLYBAT2=$(echo -e "\ue243")
GLYBAT3=$(echo -e "\ue244")
GLYBAT4=$(echo -e "\ue245")
GLYBAT5=$(echo -e "\ue246")
GLYBAT6=$(echo -e "\ue247")
GLYBAT7=$(echo -e "\ue248")
GLYBAT8=$(echo -e "\ue249")
GLYBAT9=$(echo -e "\ue24a")
GLYBAT10=$(echo -e "\ue24b")
GLYBATCHG=$(echo -e "\ue23a")
GLYWLAN1=$(echo -e "\ue218")
GLYWLAN2=$(echo -e "\ue219")
GLYWLAN3=$(echo -e "\ue21a")
GLYWLAN4=$(echo -e "\ue21a")
GLYWLAN5=$(echo -e "\ue21a")
GLYWS1=$(echo -e "\ue1a0")
GLYWS2=$(echo -e "\ue1a8")
GLYWS3=$(echo -e "\ue1d5")
GLYWS4=$(echo -e "\ue1ec")
GLYWS5=$(echo -e "\ue1e0")
GLYWS6=$(echo -e "\ue1a7")
GLYWS7=$(echo -e "\ue05c")
GLYWS8=$(echo -e "\ue1f5")
GLYWS9=$(echo -e "\ue1da")
GLYWS10=$(echo -e "\ue027")
GLYCPU=$(echo -e "\ue026")
GLYRAM=$(echo -e "\ue021")
GLYVPN=$(echo -e "\ue1f7")
GLYTEMP1=$(echo -e "\ue0cd")
GLYTEMP2=$(echo -e "\ue0cd")
GLYTEMP3=$(echo -e "\ue0cc")
GLYTEMP4=$(echo -e "\ue0cc")
GLYTEMP5=$(echo -e "\ue0cc")
GLYRDSHFT=$(echo -e "\ue26e")
GLYNOTIFON="%{T3}%{T-}"
GLYNOTIFOFF="%{T3}%{T-}"
GLYPOMO=$(echo -e "%{T3}\ue001%{T-}")
GLYPOMOACT=$(echo -e "%{T3}\ue003%{T-}")
GLYPOMOSB=$(echo -e "%{T3}\ue005%{T-}")
GLYPOMOLB=$(echo -e "%{T3}\ue006%{T-}")
GLYBT=""
# For progressbar
GLYFULL=$(echo -e "%{T3}\u25a0%{T-}")
GLYEMPTY=$(echo -e "%{T3}\u25a1%{T-}")

PANEL_FIFO=/tmp/panel-fifo
EXT_PANEL_FIFO=/tmp/ext-panel-fifo
OPTIONS=" ${FONTS} -g ${WIDTH}x${HEIGHT}+${XOFF}+${YOFF} -b -B ${BBG} -F ${BFG} -u 6 -n main"
EXTOPTIONS=" ${FONTS} -g ${WIDTH}x${HEIGHT}+${XOFF}+${YOFF} -b -B ${BBG} -F ${BFG} -u 6 -n ext-main"

[ -e "${PANEL_FIFO}" ] && rm "${PANEL_FIFO}"
mkfifo "${PANEL_FIFO}"

[ -e "${EXT_PANEL_FIFO}" ] && rm "${EXT_PANEL_FIFO}"
mkfifo "${EXT_PANEL_FIFO}"

wsicons() {
	if [ "$name" = "1" ]; then
		name="${GLYWS1}"
	elif [ "$name" = "2" ]; then
		name="${GLYWS2}"
	elif [ "$name" = "3" ]; then
		name="${GLYWS3}"
	elif [ "$name" = "4" ]; then
		name="${GLYWS4}"
	elif [ "$name" = "5" ]; then
		name="${GLYWS5}"
	elif [ "$name" = "6" ]; then
		name="${GLYWS6}"
	elif [ "$name" = "7" ]; then
		name="${GLYWS7}"
	elif [ "$name" = "8" ]; then
		name="${GLYWS8}"
	elif [ "$name" = "9" ]; then
		name="${GLYWS9}"
	elif [ "$name" = "10" ]; then
		name="${GLYWS10}"
	fi
}

workspaces() {
	bspc subscribe report |
		while read -r line; do
			case $line in
			W*)
				# bspwm's state
				wm=
				IFS=':'
				set -- ${line#?}
				c=0
				while [ $# -gt 0 ]; do
					item=$1
					name=${item#?}
					case $item in
					[mM]*)
						case $item in
						m*)
							# monitor
							FG=${CYAN}
							on_focused_monitor=
							;;
						M*)
							# focused monitor
							FG=${YELLOW}
							on_focused_monitor=1
							;;
						esac
						shift && continue
						#wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B-}%{F-}"
						;;
					[fFoOuU]*)
						c=$((c + 1))
						case $item in
						f*)
							# free desktop
							FG=${DRKFG}
							BG=${LGTBG}
							wsicons
							;;
						F*)
							if [ "$on_focused_monitor" ]; then
								# focused free desktop
								FG=${YELLOW}
								BG=${LGTBG}
								wsicons
							else
								# active free desktop
								FG=${CYAN}
								BG=${LGTBG}
								wsicons
							fi
							;;
						o*)
							# occupied desktop
							FG=${WHITE}
							BG=${LGTBG}
							wsicons
							;;
						O*)
							if [ "$on_focused_monitor" ]; then
								# focused occupied desktop
								FG=${YELLOW}
								BG=${LGTBG}
								UL=${BBG}
								wsicons
							else
								# active occupied desktop
								FG=${CYAN}
								BG=${LGTBG}
								wsicons
							fi
							;;
						u*)
							# urgent desktop
							FG=${RED}
							BG=${LGTBG}
							wsicons
							;;
						U*)
							if [ "$on_focused_monitor" ]; then
								# focused urgent desktop
								FG=${YELLOW}
								BG=${LGTBG}
								UL=${BBG}
								wsicons
							else
								# active urgent desktop
								FG=${RED}
								BG=${LGTBG}
								wsicons
							fi
							;;
						esac
						wm="${wm}${FG}${BG}%{A:bspc desktop -f ${c}:} ${name} %{A}%{B-}%{F-}"
						;;
					T*)
						# state
						if [[ "${name}" == "T" ]]; then
							#tiled
							name=
						elif [[ "${name}" == "F" ]]; then
							#Floating
							name=""
						elif [[ "${name}" == "P" ]]; then
							#Pseudo-tiled
							name=""
						elif [[ "${name}" == "=" ]]; then
							#Fullscreen
							name=""
						fi
						if [ -n "${name}" ]; then
							wm="%{F$color1}${LGTBG} ${name} ${CLR} ${wm}"
						fi
						;;
					G*)
						#flags
						if [[ "${name}" == "S" ]]; then
							#sticky
							name=""
						elif [[ "${name}" == "P" ]]; then
							#private
							name=""
						elif [[ "${name}" == "L" ]]; then
							#locked
							name=""
						elif [[ "${name}" == "M" ]]; then
							#marked
							name=""
						fi
						if [ -n "${name}" ]; then
							wm="%{F$color1}${LGTBG} ${name} ${CLR} ${wm}"
						fi
						;;
					esac
					shift
				done
				;;
			esac
			echo "WORKSPACES ${wm}${CLR}"
		done
}

workspaces | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

# progress bar
draw() {
	perc=$1
	shift
	size=$1
	shift
	inc=$((perc * size / 100))
	out=
	colors=("$@")
	# Color multiplier to expand each color in array
	colmult=$((size / ${#colors[@]}))
	# Color remainder with last color in array
	colend=$((size % ${#colors[@]}))
	c=
	for i in ${colors[@]}; do
		for n in $(seq 1 $colmult); do
			# Color array expanded to match size
			colexpand+=("$i")
		done
		c=$((c + 1))
		if [ "$c" -eq ${#colors[@]} ] && [ "$colend" -ne 0 ]; then
			for x in $(seq 1 $colend); do
				# if there was a remainder, make the rest the last color
				colexpand+=("$i")
			done
		fi
	done
	c=
	for v in $(seq 0 $((size - 1))); do
		if [ "$v" -le "$inc" ]; then
			out="${out}${colexpand[$c]}${GLYFULL}"
			c=$((c + 1))
		else
			out="${out}${LGTFG}${GLYEMPTY}"
		fi
	done
	echo $out
}

cpu() {
	while :; do
		cpu=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1); }' <(grep 'cpu ' /proc/stat) <(
			sleep 1
			grep 'cpu ' /proc/stat
		))
		rounded=$(printf "%.0f\n" "$cpu")
		bar=$(draw $rounded 8 ${FOREGROUND} ${FOREGROUND} ${YELLOW} ${YELLOW} ${RED})
		echo "CPU ${LGTBG} ${MAGENTA}${GLYCPU} ${DRKBG} $bar "
		sleep $CPU_SLEEP
	done
}

cpu | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

ram() {
	while :; do
		ram=$(free -m | awk 'NR==2{printf "%.0f\n", $3*100/$2 }')
		bar=$(draw $ram 8 ${FOREGROUND} ${FOREGROUND} ${YELLOW} ${YELLOW} ${RED})
		echo "RAM ${LGTBG} ${BLUE}${GLYRAM} ${DRKBG} $bar "
		sleep $RAM_SLEEP
	done
}

ram | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

temp() {
	while :; do
		temp=$(sensors | grep -oP 'Package.*?\+\K[0-9]+')

		if [[ "$temp" -le 20 ]]; then
			label="${LGTBG}${RED} ${GLYTEMP1}${FCLR} ${DRKBG} %{A1:sterm -e htop:}$temp°C%{A}"
		elif [[ "$temp" -lt 40 ]]; then
			label="${LGTBG}${RED} ${GLYTEMP2}${FCLR} ${DRKBG} %{A1:sterm -e htop:}$temp°C%{A}"
		elif [[ "$temp" -lt 60 ]]; then
			label="${LGTBG}${RED} ${GLYTEMP3}${FCLR} ${DRKBG} %{A1:sterm -e htop:}$temp°C%{A}"
		elif [[ "$temp" -lt 80 ]]; then
			label="${LGTBG}${RED} ${GLYTEMP4}${FCLR} ${DRKBG} %{A1:sterm -e htop:}$temp°C%{A}"
		else
			label="${LGTBG}${RED} ${GLYTEMP5}${FCLR} ${DRKBG} %{A1:sterm -e htop:}$temp°C%{A}"
		fi
		echo "TEMP $label"
		sleep $TEMP_SLEEP
	done
}

temp | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

volume() {
	volicon() {
		local vol="$(amixer get Master | grep "Mono" | awk '{print $4}' | tr -d -c 0-9)"
		local mut="$(amixer get Master | grep "Mono" | awk '{print $6}' | sed -r '/^\s*$/d')"

		if [[ ${mut} = "[off]" ]]; then
			label="${LGTBG} ${GREY}${GLYVOLM}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}$vol%%%{A}"
		elif [[ "$vol" -lt 20 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL1}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		elif [[ "$vol" -lt 40 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL2}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		elif [[ "$vol" -lt 60 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL3}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		elif [[ "$vol" -lt 80 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL4}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		else
			label="${LGTBG} ${CYAN}${GLYVOL5}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		fi

		echo "VOLUME ${label}"
	}
	volicon
	unbuffer alsactl monitor |
		while read -r monitor; do
			volicon
		done
}

volume | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

#TODO Make me not need brightness watcher external script
brightness() {
	brighticon() {
		local light=$(xbacklight)
		local rounded=$(echo "($light)/1" | bc)
		if [[ "$rounded" -lt 25 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT1}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A} "
		elif [[ "$rounded" -lt 50 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT2}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A} "
		elif [[ "$rounded" -lt 75 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT3}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A} "
		else
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT4}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A}"
		fi
	}
	brighticon
	while inotifywait -q -q -e modify /sys/class/backlight/intel_backlight/brightness; do
		brighticon
	done

}

brightness | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

battery() {
	while true; do
		local cap="$(cat /sys/class/power_supply/BAT0/capacity)"
		local stat="$(cat /sys/class/power_supply/BAT0/status)"
		bar=$(draw $cap 8 ${RED} ${YELLOW} ${YELLOW} ${FOREGROUND} ${FOREGROUND})

		if [[ ${stat} = "Charging" ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBATCHG}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_1} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT1}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_2} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT2}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_3} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT3}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_4} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT4}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_5} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT5}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_6} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT6}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_7} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT7}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_8} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT8}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		elif [[ ${cap} -lt ${BATTERY_9} ]]; then
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT9}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		else
			echo "BATTERY ${LGTBG}${GREEN} ${GLYBAT10}${FCLR} ${DRKBG} %{A1:powertime:}${bar}%{A}"
		fi

		sleep ${BATTERY_SLEEP}
	done
}

battery | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

wireless() {
	wifi_info() {
		local wifi=$(nmcli -g IN-USE,SSID d wifi list | grep "*" | cut -d':' -f2)
		local strength=$(nmcli -g IN-USE,SIGNAL d wifi list | grep "*" | cut -d':' -f2)

		if [[ -z $wifi ]]; then
			local wifi="Disconnected"
			echo "WIRELESS ${LGTBG}${GREY} ${GLYWLAN1}${FCLR} ${DRKBG} %{A1:sterm -e nmtui:}${wifi}%{A}"
		elif [[ "$strength" -lt 20 ]]; then
			echo "WIRELESS ${LGTBG}${MAGENTA} ${GLYWLAN1}${FCLR} ${DRKBG} ${wifi} "
		elif [[ "$strength" -lt 40 ]]; then
			echo "WIRELESS ${LGTBG}${MAGENTA} ${GLYWLAN2}${FCLR} ${DRKBG} ${wifi} "
		elif [[ "$strength" -lt 60 ]]; then
			echo "WIRELESS ${LGTBG}${MAGENTA} ${GLYWLAN3}${FCLR} ${DRKBG} ${wifi} "
		elif [[ "$strength" -lt 80 ]]; then
			echo "WIRELESS ${LGTBG}${MAGENTA} ${GLYWLAN4}${FCLR} ${DRKBG} ${wifi} "
		else
			echo "WIRELESS ${LGTBG}${MAGENTA} ${GLYWLAN5}${FCLR} ${DRKBG} ${wifi} "
		fi
	}
	wifi_info
	nmcli device monitor wlp5s0 |
		while read -r line; do
			if [[ "$line" == "wlp5s0: disconnected" ]]; then
				local wifi="Disconnected"
				echo "WIRELESS ${LGTBG}${GREY} ${GLYWLAN1}${FCLR} ${DRKBG} %{A1:sterm -e nmtui:}${wifi}%{A}"
			elif [[ "$line" == "wlp5s0: connected" ]]; then
				wifi_info
			fi
		done
}

wireless | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

vpn() {
	vpn_info() {
		vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep "vpn\|acer" | head -1 | cut -d ':' -f 1)"

		if [ -n "$vpn" ]; then
			echo "VPN ${LGTBG} ${BLUE}${GLYVPN}${FCLR} ${DRKBG} $vpn "
		else
			echo "VPN ${LGTBG} ${BLUE}${GLYVPN}${FCLR} ${DRKBG} Off "
		fi
	}

	vpn_info
	nmcli d monitor |
		while read -r line; do
			if [[ "$line" == "acer: connected" ]]; then
				vpn_info
			elif [[ "$line" == "acer: disconnected" ]]; then
				vpn_info
			elif [[ "$line" == "tun0: connected (externaly)" ]]; then
				vpn_info
			elif [[ "$info" == "tun0: disconnected" ]]; then
				vpn_info
			fi
		done
}

vpn | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

clock() {
	while true; do
		local clock="$(date +'%I:%M %p')"
		echo "CLOCK ${LGTBG} ${GREEN}${GLYTIME}${FCLR} ${DRKBG} ${clock} "

		sleep ${TIME_SLEEP}
	done
}

clock | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

bdate() {
	while :; do
		local date="$(date +'%a, %b %d')"
		echo "DATE ${LGTBG} ${YELLOW}${GLYDATE}${FCLR} ${DRKBG} ${date} "

		sleep ${DATE_SLEEP}
	done
}

bdate | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

tray() {
	while :; do
		if [ "$(pgrep -x redshift)" ]; then
			temp=$(redshift -l 39.2904:-76.6122 -p 2>/dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")

			if [ -z "$temp" ]; then
				redshift="${GREY}${GLYRDSHFT}"
			elif [ "$temp" -ge 5000 ]; then
				redshift="${CYAN}${GLYRDSHFT}"
			elif [ "$temp" -ge 4000 ]; then
				redshift="${RED}${GLYRDSHFT}"
			else
				redshift="${YELLOW}${GLYRDSHFT}"
			fi
		else
			redshift="${GREY}${GLYRDSHFT}"
		fi

		#notifstatus=$(pgrep xnotify)
		if pgrep xnotify; then
			notif="${YELLOW}%{A1:pkill xnotify:}${GLYNOTIFON}%{A}"
		else
			notif="${GREY}%{A1:notif.sh:}${GLYNOTIFOFF}%{A}"
		fi

		## For state: 1 equals active, 0 is paused
		#state=$(pomod info 2>/dev/null | cut -d ';' -f2)
		## For phase: 0 is pomodoro, 1 is short break, 2 is long break
		#phase=$(pomod info 2>/dev/null | cut -d ';' -f1)
		#time_left=$(pomod info 2>/dev/null | cut -d ';' -f4)
		#num='^[0-9]+$'
		#if ! [[ $state =~ $num ]]; then
		#	pomo="%{F#3c3836}${GLYPOMO}"
		#else
		#	if [[ $state -eq 1 ]] && [[ $phase -eq 0 ]]; then
		#		pomo="${RED}${GLYPOMOACT}"
		#	elif [[ $state -eq 0 ]] && [[ $phase -eq 0 ]]; then
		#		pomo="${GREY}${GLYPOMOACT}"
		#	elif [[ $state -eq 1 ]] && [[ $phase -eq 1 ]]; then
		#		pomo="${CYAN}${GLYPOMOSB}"
		#	elif [[ $state -eq 0 ]] && [[ $phase -eq 1 ]]; then
		#		pomo="${GREY}${GLYPOMOSB}"
		#	elif [[ $state -eq 1 ]] && [[ $phase -eq 2 ]]; then
		#		pomo="${CYAN}${GLYPOMOLB}"
		#	elif [[ $state -eq 0 ]] && [[ $phase -eq 2 ]]; then
		#		pomo="${GREY}${GLYPOMOLB}"
		#	fi
		#fi

		echo "TRAY ${LGTBG} $redshift $notif "
		sleep ${TRAY_SLEEP}
	done
}

tray | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

bluetooth_print() {
	bluetoothctl | while read -r; do
		if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
			echo "BLUETOOTH ${GREY} ${GLYBT}"

			devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
			counter=0
			for device in $devices_paired; do
				device_info=$(bluetoothctl info "$device")
				if echo "$device_info" | grep -q "Connected: yes"; then
					echo "BLUETOOTH ${BLUE} ${GLYBT}"
				fi
			done

		else
			echo "BLUETOOTH ${GREY} ${GLYBT}"
		fi
	done
}

bluetooth_print | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

echo "" | lemonbar -p -g 1920x38+0+0 -b -B "${BDR}" -n "bdr" &

while read -r line; do
	case $line in
	CPU*)
		fn_cpu="${line#CPU }"
		;;
	RAM*)
		fn_ram="${line#RAM }"
		;;
	TEMP*)
		fn_temp="${line#TEMP }"
		;;
	CLOCK*)
		fn_time="${line#CLOCK }"
		;;
	DATE*)
		fn_date="${line#DATE }"
		;;
	VOLUME*)
		fn_vol="${line#VOLUME }"
		;;
	BRIGHTNESS*)
		fn_bright="${line#BRIGHTNESS }"
		;;
	BATTERY*)
		fn_bat="${line#BATTERY }"
		;;
	WORKSPACES*)
		fn_work="${line#WORKSPACES }"
		;;
	WIRELESS*)
		fn_wire="${line#WIRELESS }"
		;;
	VPN*)
		fn_vpn="${line#VPN }"
		;;
	TRAY*)
		fn_tray="${line#TRAY }"
		;;
	BLUETOOTH*)
		fn_bluetooth="${line#BLUETOOTH }"
		;;
	esac
	printf "%s\n" "${UNDLN}%{+u}%{+o}%{l} ${fn_cpu}${SEP}${fn_ram}${SEP}${fn_bat}${SEP}${fn_temp}${SEP}${fn_vol}${SEP}${fn_bright}${SEP2}%{c}${fn_work}%{r}${fn_tray}${fn_bluetooth}${SEP}${fn_vpn}${SEP}${fn_wire}${SEP}${fn_date}${SEP}${fn_time}${SEP2}${CLR} %{-u}%{-o}"
done <"${PANEL_FIFO}" | lemonbar ${OPTIONS} | sh >/dev/null &

if xrandr | grep "HDMI2 connected"; then
	echo "" | lemonbar -o HDMI2 -b -p -g ${WIDTH}x38+${XOFF}+${YOFF} -B "${BDR}" -n "ext-bdr" &

	while read -r line; do
		case $line in
		CPU*)
			fn_cpu="${line#CPU }"
			;;
		RAM*)
			fn_ram="${line#RAM }"
			;;
		TEMP*)
			fn_temp="${line#TEMP }"
			;;
		CLOCK*)
			fn_time="${line#CLOCK }"
			;;
		DATE*)
			fn_date="${line#DATE }"
			;;
		VOLUME*)
			fn_vol="${line#VOLUME }"
			;;
		BRIGHTNESS*)
			fn_bright="${line#BRIGHTNESS }"
			;;
		BATTERY*)
			fn_bat="${line#BATTERY }"
			;;
		WORKSPACES*)
			fn_work="${line#WORKSPACES }"
			;;
		WIRELESS*)
			fn_wire="${line#WIRELESS }"
			;;
		VPN*)
			fn_vpn="${line#VPN }"
			;;
		TRAY*)
			fn_tray="${line#TRAY }"
			;;
		BLUETOOTH*)
			fn_bluetooth="${line#BLUETOOTH }"
			;;
		esac

		printf "%s\n" "${UNDLN}%{+u}%{+o}%{l} ${fn_cpu}${SEP}${fn_ram}${SEP}${fn_bat}${SEP}${fn_temp}${SEP}${fn_vol}${SEP}${fn_bright}%{SEP2}%{c}${fn_work}%{r}${fn_tray}${fn_bluetooth}${SEP}${fn_vpn}${SEP}${fn_wire}${SEP}${fn_date}${SEP}${fn_time}${SEP2}${CLR} %{-u}%{-o}"
	done <"${EXT_PANEL_FIFO}" | lemonbar -o HDMI2 ${EXTOPTIONS} | sh >/dev/null &
else
	# For some bizarre reason, the main panel wont show anything until something is watching the external panel fifo
	tail -f "${EXT_PANEL_FIFO}" >/dev/null &
fi

# Needed to keep the bar below all windows
names=("main" "bdr") #"ext-main" "ext-bdr")
for name in ${names[@]}; do
	wids+=($(xdo id -m -a "$name"))
done
for wid in ${wids[@]}; do
	xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"
done

wait
