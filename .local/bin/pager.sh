#!/usr/bin/env sh

temp_file=/tmp/pager_file

trap 'rm $temp_file' TERM EXIT INT

input=$(cat -)

echo "$input" >$temp_file

mime=$(file --mime-type -b $temp_file)

if [ "$mime" = "text/html" ]; then
	socksify w3m \
		-T $mime \
		-cols $(tput cols) \
		-o display_image=false \
		-o display_link_number=true \
		$temp_file
else
	less -R $temp_file
fi
