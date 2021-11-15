#!/usr/bin/env bash

### URxvt method below
function reset_background {
	printf "\e]20;;100x100+1000+1000\a"
}

# For w/e reason urxvt will only show the image if it has a different file name, so we create copies w/ random names
tmp=$(mktemp --suffix ".png")
albumartspot=$(playerctl metadata mpris:artUrl)
albumartfetchspot=$(curl -s --output /tmp/cover.png $albumartspot)
cp /tmp/cover.png "$tmp"
reset_background
printf "\e]20;${tmp};50x50+95+45:op=keep-aspect\a"
rm "$tmp"
