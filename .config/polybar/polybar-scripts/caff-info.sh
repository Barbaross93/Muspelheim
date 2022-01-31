#!/bin/sh

GLYCAFF=""

if [ "$(xset q | grep Enabled | awk '{print $3}')" = "Enabled" ]; then
    caffeine="%{F#626262}%{A1:caffeine.sh:}${GLYCAFF}%{A}"
else
    caffeine="%{F#af8787}%{A1:caffeine.sh:}${GLYCAFF}%{A}"
fi

echo " $caffeine "
