#!/usr/bin/env sh

case "$1" in
#*reddit*)
#	tuir "$1"
#	;;
*)
	if [ -z "$*" ]; then
		exit 1
	else
		lynx -assume_charset=utf-8 -display_charset=utf-8 "$1"
		#lynx "$1"
		#w3m "$1"
	fi
	;;
esac
