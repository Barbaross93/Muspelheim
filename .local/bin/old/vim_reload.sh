#!/usr/bin/env sh

servers=$(vim --serverlist)

for s in $servers; do
	vim --servername "$s" --remote-send ":source $MYVIMRC<CR>"
done
