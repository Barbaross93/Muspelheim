#!/bin/sh

size=420

art() {
	playerctl -p ncspot metadata mpris:artUrl --follow | stdbuf -oL awk NF |
		while read artUrl; do
			curl --output /tmp/large_cover.png $artUrl
			convert /tmp/large_cover.png -resize "$size"x"$size" /tmp/cover.png
		done
}

notify() {
	old=""
	# Notify on song change
	playerctl -p ncspot metadata xesam:title status --follow | stdbuf -oL awk NF |
		while read -r song; do
			spotplay
		done
}

#art 2>/dev/null &
notify 2>/dev/null &
ncspot 2>/dev/null
pkill playerctl
pkill cava
pkill lyrics-in-terminal
#killall ueberzug
tmux kill-session -t Spotify
