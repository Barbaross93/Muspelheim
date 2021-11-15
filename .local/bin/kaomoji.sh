#!/bin/sh

cat ~/Documents/personal/kaomoji.tsv | rofi -dmenu -p "Kaomoji:" | cut -f1 - | tr -d '\n' | xsel -ib
