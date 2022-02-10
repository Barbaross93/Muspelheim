#!/bin/env bash

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

herbstclient --idle "tag_*" 2>/dev/null | {

	while true; do
		# Read tags into $tags as array
		IFS=$'\t' read -ra tags <<<"$(herbstclient tag_status)"
		for i in "${tags[@]}"; do
			# Read the prefix from each tag and render them according to that prefix
			case ${i:0:1} in
			'#')
				# the tag is viewed on the focused monitor
				info="f"
				;;
			':')
				# : the tag is not empty
				info="o"
				;;
			'!')
				# ! the tag contains an urgent window
				info="u"
				;;
			'-')
				# - the tag is viewed on a monitor that is not focused
				info="a"
				;;
			*)
				# . the tag is empty
				# There are also other possible prefixes but they won't appear here
				info="e"
				;;
			esac

			echo "tag_${i:1}|string|${info}"
		done

		echo ""
		# wait for next event from herbstclient --idle
		read -r || break
	done
} 2>/dev/null
