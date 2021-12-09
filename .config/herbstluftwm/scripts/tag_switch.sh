#!/bin/bash
# vim: set fileencoding=utf-8 ts=4 sts=4 sw=4 tw=80 expandtab :

# Copyright (C) 2012 Florian Bruhin <me@the-compiler.org>

# tagswitch is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# tagswitch is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with tagswitch  If not, see <http://www.gnu.org/licenses/>.

# Changes herbstluftwm tags

checkuse() {
	if [[ "${tags[$1]}" != [.!]* ]]; then # tag is not unused
		herbstclient use "${tags[$1]:1}"     # cutting off first char (.#:!)
		exit 0
	fi
}

tags=($(herbstclient tag_status))

# Find the currently active tag
for ((i = 0; i <= "${#tags[@]}"; i++)); do
	[[ "${tags[i]}" == "#"* ]] && activetag="$i"
done

if [[ "$1" == next ]]; then # next active tag
	for ((i = "$((activetag + 1))"; i < "${#tags[@]}"; i++)); do
		checkuse "$i"
	done
	# at the end of the taglist, wrap around
	for ((i = 0; i < "$activetag"; i++)); do
		checkuse "$i"
	done
elif [[ "$1" == prev ]]; then # previous active tag
	for ((i = "$((activetag - 1))"; i >= 0; i--)); do
		checkuse "$i"
	done
	# at the beginning of the taglist, wrap around
	for ((i = ${#tags[@]} - 1; i > $((activetag - 1)); i--)); do
		checkuse "$i"
	done
else
	echo "Usage: $0 [next|prev]"
	exit 1
fi
