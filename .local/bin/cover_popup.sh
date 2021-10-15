#!/usr/bin/env sh

albumart=$(playerctl metadata mpris:artUrl)
albumartfetch=$(curl -s --output /tmp/cover_popup.png $albumart)

nsxiv -b /tmp/cover_popup.png

rm /tmp/cover_popup.png
