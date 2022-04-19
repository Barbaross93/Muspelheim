#!/bin/sh

# Print a progrss bar for current track in cmus
# TODO: Optimize me; polling every second is a bit much :(

# Chars to represent each state
elapsed='━'
indc='━'
bar='━'

PBLK=$(printf "%b" "\x1b[38;2;58;58;58m")
RED="\e[31m"
PUR="\e[35m"
GRY="\e[90;1m"

tput civis
while :; do
	# pos/dur in seconds
	pos=$(cmus-remote -C "format_print %{position}" | awk -F: '{ print ($1 * 60) + $2 }')
	dur=$(cmus-remote -C "format_print %d" | awk -F: '{ print ($1 * 60) + $2 }')
	cols=$(tput cols)

	# right as in right side of equation: dur * x = pos * cols
	right=$((pos * cols))
	total_cols=$(echo "$right/$dur" | bc -l | awk '{printf("%d\n",$1 + 0.5)}')
	elapse_cols=$((total_cols - 1))
	test "$elapse_cols" -ne -1 && bar_cols=$((cols - total_cols)) || bar_cols=$((cols - 1))

	# Move cursor back to start
	printf '\r'
	for b in $(seq $elapse_cols); do
		printf "${PUR}${elapsed}"
	done

	printf "${PUR}$indc"

	for b in $(seq $bar_cols); do
		printf "${PBLK}$bar"
	done
	sleep 1
done
