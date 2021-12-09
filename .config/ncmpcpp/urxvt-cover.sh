#!/usr/bin/env bash

reset_background() {
	printf "\e]20;;100x100+1000+1000\a"
}

# For w/e reason urxvt will only show the image if it has a different file name, so we create every image w/ random names
tmp=$(mktemp --suffix ".png")
filepath=$(mpc current -f "http://192.168.0.2/%file%")
ffmpeg -y -i "$filepath" "$tmp" &>/dev/null
reset_background
printf "\e]20;${tmp};50x50+95+40:op=keep-aspect\x9c"
rm "$tmp"
