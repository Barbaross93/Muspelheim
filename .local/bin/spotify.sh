#!/bin/sh

size=420

art() {
	playerctl metadata mpris:artUrl --follow 2>&/dev/null |
		while read artUrl; do
			curl --output /tmp/large_cover.png $artUrl
			convert /tmp/large_cover.png -resize "$size"x"$size" /tmp/cover.png
		done
}

notify() {
	old=""
	# Notify on song change
	playerctl metadata xesam:title status --follow | stdbuf -oL awk NF |
		while read -r song; do
			spotplay
		done
}

notify 2>/dev/null &
ncspot
#spotifyd && spt
killall playerctl
#killall spotifyd
killall cava
killall lyrics-in-terminal
#killall ueberzug
tmux kill-session -t Spotify
