#!/bin/sh

art=/tmp/cover.png

#Display album art
filepath=$(cmus-remote -C "format_print %f")
ffmpeg -loglevel panic -y -i "$filepath" "$art"
nsxiv -b "$art" && rm "$art"
