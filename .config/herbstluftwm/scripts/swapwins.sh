#!/usr/bin/env bash
old="$1"
new="$2" movbackdir="$3"
winarrold=$(herbstclient dump | grep -o ":[ 0-9a-z]* ${old}[ 0-9a-z]*)" | sed 's/:. // ; s/)//' - | tr [:blank:] '\n')
winarrnew=$(herbstclient dump | grep -o ":[ 0-9a-z]* ${new}[ 0-9a-z]*)" | sed 's/:. // ; s/)//' - | tr [:blank:] '\n')

for i in $winarrold; do
	herbstclient bring $i
done
herbstclient focus -e $movbackdir
for j in $winarrnew; do
	herbstclient bring $j
done
