#!/bin/sh

if [ $# -lt 2 ]; then
	printf "usage: %s minutes pre-command -- post-command\n" "$(basename $0)" 2>&1
	exit 1
fi

timeout=$(($1 * 60 * 1000))
shift
cmd="$@"
del="--"
cmds=$(perl -E 'say for split quotemeta shift, shift' -- "$del" "$cmd")
precmd=$(echo "$cmds" | head -n1)
postcmd=$(echo "$cmds" | tail -n1)
triggered=false

while true; do
	tosleep=$(((timeout - $(xssstate -i)) / 1000))
	if [ $tosleep -le 0 ]; then
		$triggered || $precmd
		triggered=true
	else
		$postcmd
		triggered=false
		sleep $tosleep
	fi
done
