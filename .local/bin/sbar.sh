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

# Signal fifo; not sure how to optimize this
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
. "$HOME/.config/herbstluftwm/colorschemes/alduin.sh"

#-xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso10646-*
#-misc-termsynu-medium-r-normal-*-14-*-*-*-*-*-iso10646-*
#-romeovs-creep2-medium-r-normal--11-110-75-75-c-50-iso10646-1
#-sxthe-terra-medium-r-normal--12-120-72-72-c-60-iso8859-1
FONTS="-f -barbaross-creeper-medium-r-normal--15-150-100-100-m-80-iso8859-1 -f -wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1 -f -barbaross-creeper-bold-r-normal--15-150-100-100-m-80-iso8859-1"
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
TRAY_SLEEP=5

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
SEP=" ${BACKGROUND} ${CLR}"
SEP2="${DRKBG} ${CLR}"
SEP3="${BACKGROUND} ${CLR}"

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
GLYBATAC=""
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
GLYVPN=""
GLYRDSHFT=$(echo -e "\ue26e")
GLYNOTIFON=""
GLYNOTIFOFF=""
GLYBT=""
GLYCAFF=""
GLYMON=""

PANEL_FIFO=/tmp/panel-fifo
EXT_PANEL_FIFO=/tmp/ext-panel-fifo
OPTIONS=" ${FONTS} -g ${WIDTH}x${HEIGHT}+${XOFF}+${YOFF} -B ${BBG} -F ${BFG} -u 6 -n main"
EXTOPTIONS=" ${FONTS} -g ${WIDTH}x${HEIGHT}+${XOFF}+${YOFF} -B ${BBG} -F ${BFG} -u 6 -n ext-main"

[ -e "${PANEL_FIFO}" ] && rm "${PANEL_FIFO}"
mkfifo "${PANEL_FIFO}"

[ -e "${EXT_PANEL_FIFO}" ] && rm "${EXT_PANEL_FIFO}"
mkfifo "${EXT_PANEL_FIFO}"

workspaces() {
	herbstclient --idle "tag_*" 2>/dev/null | {

		while true; do
			# Read tags into $tags as array
			IFS=$'\t' read -ra tags <<<"$(herbstclient tag_status)"
			{
				for f in "${tags[@]}"; do
					status+=(${f:0:1})
				done

				for i in "${!tags[@]}"; do
					if [[ ${tags[$i]} == *"1"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS1}"
					elif [[ ${tags[$i]} == *"2"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS2}"
					elif [[ ${tags[$i]} == *"3"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS3}"
					elif [[ ${tags[$i]} == *"4"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS4}"
					elif [[ ${tags[$i]} == *"5"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS5}"
					elif [[ ${tags[$i]} == *"6"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS6}"
					elif [[ ${tags[$i]} == *"7"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS7}"
					elif [[ ${tags[$i]} == *"8"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS8}"
					elif [[ ${tags[$i]} == *"9"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS9}"
					elif [[ ${tags[$i]} == *"0"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS10}"
					else
						break && notify-send "Hlwm status broke"
					fi
				done
				count=1
				for i in "${tags[@]}"; do
					# Read the prefix from each tag and render them according to that prefix
					if [ "$count" -eq 1 ]; then
						echo "WORKSPACES ${LGTBG}"
					fi
					case ${i:0:1} in
					'#')
						# the tag is viewed on the focused monitor
						# TODO Add your formatting tags for focused workspaces
						echo "${YELLOW}${DRKBG}"
						;;
					':')
						# : the tag is not empty
						# TODO Add your formatting tags for occupied workspaces
						echo "${WHITE}${LGTBG}"
						;;
					'!')
						# ! the tag contains an urgent window
						# TODO Add your formatting tags for workspaces with the urgent hint
						echo "${RED}${LGTBG}"
						;;
					'-')
						# - the tag is viewed on a monitor that is not focused
						# TODO Add your formatting tags for visible but not focused workspaces
						echo "${CYAN}${LGTBG}"
						;;
					*)
						# . the tag is empty
						# There are also other possible prefixes but they won't appear here
						echo "${DRKFG}${LGTBG}" # Add your formatting tags for empty workspaces
						;;
					esac

					if [ $count -eq 10 ]; then
						count=0
					fi

					echo "%{A1:herbstclient use $count:} ${i:1} %{A}${CLR}"
					count=$((count + 1))
				done

			} | tr -d "\n"

			echo

			# wait for next event from herbstclient --idle
			read -r || break
		done
	} 2>/dev/null
}

workspaces | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

layout() {
	layouticon() {
		layout=$(herbstclient attr tags.focus.tiling.focused_frame.algorithm)
		count=$(herbstclient attr tags.focus.curframe_wcount)

		if [[ "$layout" == "horizontal" ]]; then
			icon="${GLYLYTH}"
		elif [[ "$layout" == "vertical" ]]; then
			icon="${GLYLYTV}"
		elif [[ "$layout" == "max" ]]; then
			icon="${GLYLYTM}"
		elif [[ "$layout" == "grid" ]]; then
			icon="${GLYLYTG}"
		fi

		#if [[ "$layout" == "max" ]]; then
		#	echo "LAYOUT ${RED}${LGTBG} $icon%{F-} $count"
		#else
		echo "LAYOUT ${RED}${LGTBG} $icon%{F-}"
		#fi
	}
	layouticon
	herbstclient watch tags.focus.tiling.focused_frame.algorithm
	herbstclient --idle "(focus|attribute)_changed" |
		while read -r line; do
			layouticon
		done
}

#layout | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

notif() {
	[[ -e /tmp/old_notifs ]] && rm /tmp/old_notifs
	mkfifo /tmp/old_notifs
	{
		tiramisu -o "#summary\t#body\t#timeout" &
		tail -f /tmp/old_notifs &
	} |
		while read -r line; do
			# Easy to spam binding, clean up first before cont.
			[[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip

			# We block the foreground until rofi is dead, if its running
			pid=$(pgrep -x rofi)
			if [ -n "$pid" ]; then
				tail --pid="$pid" -f /dev/null
			fi

			# If pause signal was sent to script
			if [[ -f "/tmp/notif_pause" ]]; then
				# Block foreground until file gets deleted
				inotifywait -q -q /tmp/notif_pause
			fi

			# Duplicate any '%' to process them as literal '%' in lemonbar
			line=${line//%/%%}

			case "$line" in
			LOG*)
				line="${line#LOG }"
				pretext="NOTIF %{T3}${ORANGE}NOTIF HISTORY:%{T-}${CLR} "
				;;
			*)
				echo "LOG $line" >>/tmp/notif_log
				pretext="NOTIF %{T3}${ORANGE}NOTIFICATION:%{T-}${CLR} "
				;;
			esac
			body="$(echo -e "$line" | cut -f1 -)"
			summary="$(echo -e "$line" | cut -f2 -)"
			timeout="$(echo -e "$line" | cut -f3 -)"
			notif="$summary"

			# Determine actual timeout in secs
			if [ "$timeout" = "-1" ]; then
				time=10.0
			else
				time=$(echo "scale=1;$timeout/1000" | bc)
			fi

			# If summary is blank, display body instead
			[ -z "$notif" ] && notif="$body"

			# Scroll if greater than 70 characters
			if [ ${#notif} -gt 70 ]; then
				end=$((SECONDS + ${time%.*}))
				while [ $SECONDS -lt $end ]; do
					[[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip && break
					c=0
					length=${#notif}
					while [ $c -le $length ]; do
						[ $SECONDS -ge $end ] && break
						[[ -f "/tmp/notif_skip" ]] && break
						scrollstart=${notif:$c:70}
						if [ ${#scrollstart} -eq 70 ]; then
							echo "$pretext$scrollstart..."
							[ $c -eq 0 ] && sleep 1
						else
							echo "$pretext$scrollstart"
						fi
						c=$((c + 1))
						sleep 0.2
					done
				done
			else
				echo "$pretext$notif"
				c=0
				while (($(echo "$c <= $time" | bc -l))); do
					[[ -f "/tmp/notif_skip" ]] && rm /tmp/notif_skip && break
					sleep 0.2
					c=$(echo "scale=1;$c + 0.2" | bc)
				done
			fi

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

brightness() {
	brighticon() {
		local light=$(light -G)
		local rounded=$(echo "($light)/1" | bc)
		#local rounded=$(xbacklight -get)
		#local bar=$(draw $rounded 8 ${FOREGROUND})
		local bar="$rounded%%"

		if [[ "$rounded" -lt 25 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT1}${FCLR} ${DRKBG} %{A4:light -A 5:}%{A5:light -U 5:}$bar%{A}%{A} "
		elif [[ "$rounded" -lt 50 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT2}${FCLR} ${DRKBG} %{A4:light -A 5:}%{A5:light -U 5:}$bar%{A}%{A} "
		elif [[ "$rounded" -lt 75 ]]; then
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT3}${FCLR} ${DRKBG} %{A4:light -A 5:}%{A5:light -U 5:}$bar%{A}%{A} "
		else
			echo "BRIGHTNESS ${LGTBG} ${YELLOW}${GLYLIGHT4}${FCLR} ${DRKBG} %{A4:light -A 5:}%{A5:light -U 5:}$bar%{A}%{A}"
		fi
	}
	brighticon
	inotifywait -m -q -e close_write /sys/class/backlight/intel_backlight/brightness |
		while read -r line; do
			brighticon
		done

}

brightness | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

batstat() {
	battery -s | uq |
		while read -r line; do
			stat=$(echo "$line" | cut -f1 -d' ')
			cap=$(echo "$line" | cut -f2 -d' ')

			bar="$cap%%"

			if [[ ${stat} = "Not" ]]; then
				echo "BATTERY ${LGTBG}${GREEN} ${GLYBATAC}${FCLR} ${DRKBG} %{A1:powertime:}AC%{A}"
			elif [[ ${stat} = "Charging" ]]; then
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
		done
}

batstat | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

wireless() {
	wirelessicon() {
		local wifi=$(iwctl station wlp5s0 show | grep "Connected network" | xargs | cut -d' ' -f3-)
		local raw=$(cat /proc/net/wireless | grep wlp5s0 | awk '{print $4}' | tr -d '.')
		local strength=$(echo "2*($raw+100)" | bc)

		if [[ -z $wifi ]]; then
			local wifi="Disconnected"
			echo "WIRELESS ${LGTBG}${GREY} ${GLYWLAN1}${FCLR} ${DRKBG} %{A1:urxvtdc -e iwctl:}${wifi}%{A}"
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

	wirelessicon
	ip monitor route dev wlp5s0 |
		while read -r line; do
			echo "$line" | grep "broadcast" && wirelessicon
		done
}

wireless | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

vpninfo() {
	vpnicon() {
		cvpn=""
		vpn="$(ip addr | grep 'barbarossvpn\|tun0' | awk '{print $2}' | grep -v -E '^[0-9]+' | tr -d ':')"
		for v in $vpn; do
			case "$v" in
			barbarossvpn)
				cvpn+="${RED}%{A1:sudo -A wg-quick down barbarossvpn:}${GLYVPN}%{A}"
				;;
			tun0)
				cvpn+="${ORANGE}%{A1:sudo -A pkill openvpn:}${GLYVPN}%{A}"
				;;
			esac
		done
		[ -z "$cvpn" ] && cvpn="${GREY}%{A1:sudo wg-quick up barbarossvpn:}${GLYVPN}%{A}"

		echo "VPN ${DRKBG} $cvpn"
	}
	vpnicon
	ip monitor netconf |
		while read -r line; do
			echo "$line" | grep "barbarossvpn\|tun0" && vpnicon
		done
}

vpninfo | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

bltth() {
	rfkill event |
		while read -r line; do
			status=$(echo "$line" | grep "type 2" | awk '{print $10}')

			if [ "$status" -eq 1 ]; then
				bt="${GREY}${GLYBT}"
			elif [ "$status" -eq 0 ]; then
				bt="${CYAN}${GLYBT}"
			fi

			echo "BLTTH ${DRKBG} $bt"

		done
}

bltth | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

ctime() {
	clock -sf "CLOCK ${LGTBG} ${ORANGE}${GLYDATE}${FCLR} ${DRKBG} %A, %B %d${SEP}${LGTBG} ${GREEN}${GLYTIME}${FCLR} ${DRKBG} %I:%M %p " | uq
}

ctime | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

tray() {
	while :; do
		# Redshift info
		#if [ "$(pgrep -x redshift)" ]; then
		#	loc=$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lat, .location.lng' | tr '\n' ':' | sed 's/:$//')
		#	temp=$(redshift -l "$loc" -p 2>/dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")
		#
		#	if [ -z "$temp" ]; then
		#		redshift="${GREY}${GLYRDSHFT}"
		#	elif [ "$temp" -ge 5000 ]; then
		#		redshift="${BLUE}${GLYRDSHFT}"
		#	elif [ "$temp" -ge 4000 ]; then
		#		redshift="${RED}${GLYRDSHFT}"
		#	else
		#		redshift="${YELLOW}${GLYRDSHFT}"
		#	fi
		#else
		#	redshift="${GREY}${GLYRDSHFT}"
		#fi

		# Caffeine status
		if xset q | grep Enabled >/dev/null; then
			caffeine="${GREY}%{A1:caffeine.sh:}${GLYCAFF}%{A}"
		else
			caffeine="${MAGENTA}%{A1:caffeine.sh:}${GLYCAFF}%{A}"
		fi

		# Notification status
		#if [ ! -f /tmp/notif_pause ]; then
		#	notif="${YELLOW}%{A1:echo pause >/tmp/signal_bar:}${GLYNOTIFON}%{A}"
		#else
		#	notif="${GREY}%{A1:echo resume >/tmp/signal_bar:}${GLYNOTIFOFF}%{A}"
		#fi

		echo "TRAY ${DRKBG} $caffeine" | uq
		sleep ${TRAY_SLEEP}
	done
}

tray | tee "${PANEL_FIFO}" >"${EXT_PANEL_FIFO}" &

# For funsies
monster="${LGTBG}${RED} %{A1:launch:}%{A3:power:}${GLYMON}%{A}%{A}"

# Grey bottom border
echo "" | lemonbar -p -g 1920x3+0+36 -B "${BDR}" -n "bdr" &

while read -r line; do
	case $line in
	CLOCK*)
		fn_time="${line#CLOCK }"
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
	BLTTH*)
		fn_bltth="${line#BLTTH }"
		;;
	NOTIF*)
		fn_notif="${line#NOTIF }"
		;;
	TRAY*)
		fn_tray="${line#TRAY }"
		;;
	esac
	printf "%s\n" "${UNDLN}%{+u}%{+o}%{l} ${monster}${SEP}${fn_work}${SEP3}${fn_notif}%{r}${fn_bltth}${fn_tray}${fn_vpn}${SEP}${fn_bat}${SEP}${fn_bright}${SEP}${fn_vol}${SEP}${fn_wire}${SEP}${fn_time}${SEP2}${CLR} %{-u}%{-o}"
done <"${PANEL_FIFO}" | lemonbar ${OPTIONS} | sh >/dev/null &

if xrandr | grep "HDMI-2 connected"; then
	echo "" | lemonbar -o HDMI-2 -p -g ${WIDTH}x3+0+36 -B "${BDR}" -n "ext-bdr" &

	while read -r line; do
		case $line in
		CLOCK*)
			fn_time="${line#CLOCK }"
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
		BLTTH*)
			fn_bltth="${line#BLTTH }"
			;;
		NOTIF*)
			fn_notif="${line#NOTIF }"
			;;
		TRAY*)
			fn_tray="${line#TRAY }"
			;;
		esac

		printf "%s\n" "${UNDLN}%{+u}%{+o}%{l} ${monster}${SEP}${fn_work}${SEP3}${fn_notif}%{r}${fn_bltth}${fn_tray}${fn_vpn}${SEP}${fn_bat}${SEP}${fn_bright}${SEP}${fn_vol}${SEP}${fn_wire}${SEP}${fn_time}${SEP2}${CLR} %{-u}%{-o}"
	done <"${EXT_PANEL_FIFO}" | lemonbar -o HDMI-2 ${EXTOPTIONS} | sh >/dev/null &
else
	# For some bizarre reason, the main panel wont show anything until something is watching the external panel fifo
	tail -f "${EXT_PANEL_FIFO}" &>/dev/null &
fi

# Make bars below all windows
for i in main bdr ext-main ext-bdr; do
	id=$(xdo id -a $i)
	herbstclient lower "$id"
done

wait
