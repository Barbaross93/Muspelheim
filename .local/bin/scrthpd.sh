#!/bin/sh
#set -euo pipefail

geometry() {
  mon=$(bspc query -M -m)
  json=$(bspc query -T -m $mon)

  width=$(echo $json | jq '.rectangle | .width')
  height=$(echo $json | jq '.rectangle | .height')
  x=0
  y=0
  nwidth=$(echo "$width * 0.7" | bc -l | cut -d'.' -f1)
  nheight=$(echo "$height * 0.6" | bc -l | cut -d'.' -f1)
  nx=$(echo "$width * 0.15" | bc -l | cut -d'.' -f1)
  ny=$((y + 12))
  bspc rule -a St:dropdown -o monitor=$mon rectangle=${nwidth}x${nheight}+${nx}+${ny}
}
# TODO: handle situation where tmp file was deleted but window exists
dropdown=/tmp/bspwm:dropdown
if [ "$(ps -x | grep -c 'dropdown')" -eq "1" ]; then
  geometry
  st -n 'dropdown' -e tmux_startup.sh &
  xdotool search --sync --onlyvisible --classname 'dropdown'
  bspc query -N -n >$dropdown
  exit
fi

id=$(cat $dropdown)
state=$(bspc query -T -n $id | jq '.hidden')
dtop=$(bspc query -D -d)
nodes_indtop="$(bspc query -N -d)"

check=$(echo "$nodes_indtop" | grep "$id")
if ! [ "$check" = "$id" ]; then
  geometry
  bspc node $id -d $dtop
  xdotool windowmap "$id"
  #bspc node $id --flag hidden=off
  bspc node -f $id
elif [ "$check" = "$id" ] && [ "$state" = "true" ]; then
  geometry
  xdotool windowmap "$id"
  #bspc node $id --flag hidden=off
  bspc node -f $id
else
  xdotool windowunmap "$id"
  #bspc node $id --flag hidden=on
fi
