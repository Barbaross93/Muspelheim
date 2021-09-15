#!/usr/bin/env bash

##
##  ▄█          ▄████████   ▄▄▄▄███▄▄▄▄    ▄██████▄  ███▄▄▄▄   ▀█████████▄     ▄████████    ▄████████
## ███         ███    ███ ▄██▀▀▀███▀▀▀██▄ ███    ███ ███▀▀▀██▄   ███    ███   ███    ███   ███    ███
## ███         ███    █▀  ███   ███   ███ ███    ███ ███   ███   ███    ███   ███    ███   ███    ███
## ███        ▄███▄▄▄     ███   ███   ███ ███    ███ ███   ███  ▄███▄▄▄██▀    ███    ███  ▄███▄▄▄▄██▀
## ███       ▀▀███▀▀▀     ███   ███   ███ ███    ███ ███   ███ ▀▀███▀▀▀██▄  ▀███████████ ▀▀███▀▀▀▀▀
## ███         ███    █▄  ███   ███   ███ ███    ███ ███   ███   ███    ██▄   ███    ███ ▀███████████
## ███▌    ▄   ███    ███ ███   ███   ███ ███    ███ ███   ███   ███    ███   ███    ███   ███    ███
## █████▄▄██   ██████████  ▀█   ███   █▀   ▀██████▀   ▀█   █▀  ▄█████████▀    ███    █▀    ███    ███
## ▀                                                                                       ███    ███
##

# A sorta simplified bar

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# Signal fifo; not sure how to make this more optimal
[[ -e /tmp/signal_bar ]] && rm /tmp/signal_bar
mkfifo /tmp/signal_bar
tail -f /tmp/signal_bar |
	while read -r line; do
		[[ "$line" == "die" ]] && pkill -P $$
		[[ "$line" == "skip" ]] && touch /tmp/notif_skip
		[[ "$line" == "pause" ]] && touch /tmp/notif_pause
		[[ "$line" == "resume" ]] && rm /tmp/notif_pause
	done &

# Colors!
. "$HOME/.config/bspwm/colorschemes/alduin.sh"

#-xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso10646-*
#-misc-termsynu-medium-r-normal-*-14-*-*-*-*-*-iso10646-*
#-romeovs-creep2-medium-r-normal--11-110-75-75-c-50-iso10646-1
#-sxthe-terra-medium-r-normal--12-120-72-72-c-60-iso8859-1
FONTS="-f -barbaross-creeper-medium-r-normal--13-101-100-100-c-70-iso8859-1 -f -wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1 -f -slavfox-cozette-medium-r-normal--13-120-75-75-m-60-iso10646-1 -f -barbaross-creeper-bold-r-normal--13-101-100-100-c-70-iso8859-1"
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
BATTERY_SLEEP=30
VPN_SLEEP=5
TIME_SLEEP=5
DATE_SLEEP=300

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
ORANGE="%{F$color19}"
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
GLYWS1=""
GLYWS2=""
GLYWS3=""
GLYWS4=""
GLYWS5=""
GLYWS6=""
GLYWS7=""
GLYWS8=""
GLYWS9=""
GLYWS10=""
GLYLYTH=$(echo -e "\ue26b")
GLYLYTV=$(echo -e "\ue004")
GLYLYTM=$(echo -e "\ue000")
GLYLYTG=$(echo -e "\ue005")
GLYVPN=$(echo -e "\ue1f7")

PANEL_FIFO=/tmp/panel-fifo
EXT_PANEL_FIFO=/tmp/ext-panel-fifo
OPTIONS=" ${FONTS} -g ${WIDTH}x${HEIGHT}+${XOFF}+${YOFF} -B ${BBG} -F ${BFG} -u 6 -n main"
EXTOPTIONS=" ${FONTS} -g ${WIDTH}x${HEIGHT}+${XOFF}+${YOFF} -B ${BBG} -F ${BFG} -u 6 -n ext-main"

[ -e "${PANEL_FIFO}" ] && rm "${PANEL_FIFO}"
mkfifo "${PANEL_FIFO}"

[ -e "${EXT_PANEL_FIFO}" ] && rm "${EXT_PANEL_FIFO}"
mkfifo "${EXT_PANEL_FIFO}"

##
## Helper functions
##

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

##
## Main functions
##

workspaces() {
	bspc subscribe report |
		while read -r line; do
			case $line in
			W*)
				# bspwm's state
				wm=
				state=
				flags=
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
								BG=${DRKBG}
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
								BG=${DRKBG}
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
								BG=${DRKBG}
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
					L*)
						# layout
						if [[ "${name}" == "T" ]]; then
							# tiled
							name=""
						elif [[ "${name}" == "M" ]]; then
							# Monocle
							name=""
						fi
						if [ -n "${name}" ]; then
							layout=" ${RED}${LGTBG} ${name} ${CLR}"
						fi
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
							state=" ${RED}${LGTBG} ${name} ${CLR}"
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
							flags=" ${RED}${LGTBG} ${name} ${CLR}"
						fi
						;;
					esac
					shift
				done
				;;
			esac
			echo "WORKSPACES ${wm}${layout}${state}${flags}${CLR}"
		done
}

workspaces | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

notif() {
	[[ -e /tmp/old_notifs ]] && rm /tmp/old_notifs
	mkfifo /tmp/old_notifs
	{
		tiramisu -o "#body" &
		tail -f /tmp/old_notifs &
	} |
		while read -r line; do
			[[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip
			if [[ -f "/tmp/notif_pause" ]]; then
				# Block foreground until file gets deleted
				inotifywait -q -q /tmp/notif_pause
			fi
			case "$line" in
			LOG*)
				line="${line#LOG }"
				;;
			*)
				echo "LOG $line" >>/tmp/notif_log
				;;
			esac
			if [ $(echo $line | wc -c) -gt 100 ]; then
				line="$(echo $line | cut -c -100)..."
			fi
			echo "NOTIF %{T4}${ORANGE}NOTIFICATION:%{T-}${CLR} $line"
			c=0
			while [[ "$c" != "10.0" ]]; do
				[[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip && break
				while [ $(xprintidle) -gt 120000 ] || pgrep -x "physlock" >/dev/null; do
					sleep 1
				done
				sleep 0.2
				c=$(echo "scale=1;$c + 0.2" | bc)
			done
			echo "NOTIF ${CLR}"
		done
}

notif | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

volume() {
	volicon() {
		local vol="$(amixer get Master | grep "Mono" | awk '{print $4}' | tr -d -c 0-9)"
		local mut="$(amixer get Master | grep "Mono" | awk '{print $6}' | sed -r '/^\s*$/d')"
		#local bar=$(draw $vol 8 ${FOREGROUND})
		local bar="$vol%%"

		if [[ ${mut} = "[off]" ]]; then
			label="${LGTBG} ${GREY}${GLYVOLM}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}$bar%{A}"
		elif [[ "$vol" -lt 20 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL1}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$bar%{A}%{A}%{A}"
		elif [[ "$vol" -lt 40 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL2}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$bar%{A}%{A}%{A}"
		elif [[ "$vol" -lt 60 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL3}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$bar%{A}%{A}%{A}"
		elif [[ "$vol" -lt 80 ]]; then
			label="${LGTBG} ${CYAN}${GLYVOL4}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$bar%{A}%{A}%{A}"
		else
			label="${LGTBG} ${CYAN}${GLYVOL5}${FCLR} ${DRKBG} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$bar%{A}%{A}%{A}"
		fi

		echo "VOLUME ${label}"
	}
	volicon
	stdbuf -i0 -o0 -e0 alsactl monitor |
		while read -r monitor; do
			volicon
		done
}

volume | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

#TODO Make me not need brightness watcher external script
brightness() {
	brighticon() {
		#local light=$(xbacklight -get)
		#local rounded=$(echo "($light)/1" | bc)
		local rounded=$(xbacklight -get)
		#local bar=$(draw $rounded 8 ${FOREGROUND})
		local bar="$rounded%%"

		if [[ "$rounded" -lt 25 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT1}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$bar%{A}%{A} "
		elif [[ "$rounded" -lt 50 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT2}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$bar%{A}%{A} "
		elif [[ "$rounded" -lt 75 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT3}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$bar%{A}%{A} "
		else
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT4}${FCLR} ${DRKBG} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$bar%{A}%{A}"
		fi
	}
	brighticon
	inotifywait -m -q -e modify /sys/class/backlight/intel_backlight/brightness |
		while read -r line; do
			brighticon
		done

}

brightness | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

battery() {
	while true; do
		local cap="$(cat /sys/class/power_supply/BAT0/capacity)"
		local stat="$(cat /sys/class/power_supply/BAT0/status)"
		#bar=$(draw $cap 8 ${RED} ${YELLOW} ${YELLOW} ${FOREGROUND} ${FOREGROUND})
		bar="$cap%%"

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
		local wifi=$(connmanctl services | grep --fixed-strings "*AO" | awk '{print $2}')
		local strength=$(connmanctl services | grep "$wifi" | awk '{print $3}' | xargs -I _ connmanctl services _ | grep "Strength" | cut -d'=' -f2)

		if [[ -z $wifi ]]; then
			local wifi="Disconnected"
			echo "WIRELESS ${LGTBG}${GREY} ${GLYWLAN1}${FCLR} ${DRKBG} %{A1:urxvtdc -e connmanctl:}${wifi}%{A}"
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
	connmanctl monitor tech |
		while read -r line; do
			if grep -q "Connected = False" <<<"$line"; then
				local wifi="Disconnected"
				echo "WIRELESS ${LGTBG}${GREY} ${GLYWLAN1}${FCLR} ${DRKBG} %{A1:urxvtdc -e connmanctl:}${wifi}%{A}"
			elif grep -q "Connected = True" <<<"$line"; then
				wifi_info
			fi
		done
}

wireless | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

vpn() {
	while :; do
		vpn="$(connmanctl services | grep --fixed-strings "* R acer" | awk '{print $3}')"

		if [ -n "$vpn" ]; then
			echo "VPN ${LGTBG} ${BLUE}${GLYVPN}${FCLR} ${DRKBG} $vpn "
		else
			echo "VPN ${LGTBG} ${BLUE}${GLYVPN}${FCLR} ${DRKBG} Off "
		fi
		sleep ${VPN_SLEEP}
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

cdate() {
	while :; do
		local date="$(date +'%A, %B %d')"
		echo "DATE ${LGTBG} ${ORANGE}${GLYDATE}${FCLR} ${DRKBG} ${date} "

		sleep ${DATE_SLEEP}
	done
}

cdate | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

echo "" | lemonbar -p -g 1920x39+0+0 -B "${BDR}" -n "bdr" &

while read -r line; do
	case $line in
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
	LAYOUT*)
		fn_layout="${line#LAYOUT }"
		;;
	VPN*)
		fn_vpn="${line#VPN }"
		;;
	NOTIF*)
		fn_notif="${line#NOTIF }"
		;;
	esac
	printf "%s\n" "${UNDLN}%{+u}%{+o}%{l} ${fn_work}${SEP}${fn_layout}${SEP}${fn_notif}%{r}${fn_bat}${SEP}${fn_bright}${SEP}${fn_vol}${SEP}${fn_wire}${SEP}${fn_vpn}${SEP}${fn_date}${SEP}${fn_time}${SEP2}${CLR} %{-u}%{-o}"
done <"${PANEL_FIFO}" | lemonbar ${OPTIONS} | sh >/dev/null &

if xrandr | grep "HDMI2 connected"; then
	echo "" | lemonbar -o HDMI2 -p -g ${WIDTH}x38+${XOFF}+${YOFF} -B "${BDR}" -n "ext-bdr" &

	while read -r line; do
		case $line in
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
		LAYOUT*)
			fn_layout="${line#LAYOUT }"
			;;
		VPN*)
			fn_vpn="${line#VPN }"
			;;
		NOTIF*)
			fn_notif="${line#NOTIF }"
			;;
		esac

		printf "%s\n" "${UNDLN}%{+u}%{+o}%{l} ${fn_work}${SEP}${fn_layout}${SEP}${fn_notif}%{r}${fn_bat}${SEP}${fn_bright}${SEP}${fn_vol}${SEP}${fn_wire}${SEP}${fn_vpn}${SEP}${fn_date}${SEP}${fn_time}${SEP2}${CLR} %{-u}%{-o}"
	done <"${EXT_PANEL_FIFO}" | lemonbar -o HDMI2 ${EXTOPTIONS} | sh >/dev/null &
else
	# For some bizarre reason, the main panel wont show anything until something is watching the external panel fifo
	tail -f "${EXT_PANEL_FIFO}" &>/dev/null &
fi
wait
