#!/usr/bin/env bash

ratio=0.5

case "$1" in
	-l)			
		herbstclient split left $ratio
		herbstclient cycle_frame -1
		;;
	-r)	
		herbstclient split right $ratio
		herbstclient cycle_frame 1
		;;
	-t)	
		herbstclient split top $ratio
		herbstclient cycle_frame -1
		;;
	-b)	
		herbstclient split bottom $ratio
		herbstclient cycle_frame 1
		;;
	-h)
		echo "$0 usage: [-l|-r|-t|-b] create a frame and focus it in given direction"
		exit
		;;
	*)	
		echo "$0 usage: [-l|-r|-t|-b] create a frame and focus it in given direction"
		exit
		;;
esac
