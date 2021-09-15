#!/bin/sh

geometry() {
  mon=$(bspc query -M -m)
  json=$(bspc query -T -m $mon)

  width=$(echo $json | jq '.rectangle | .width')
  height=$(echo $json | jq '.rectangle | .height')
  x=0
  y=39
  nwidth=$(echo "$width * 0.7" | bc -l | cut -d'.' -f1)
  nheight=$(echo "$height * 0.6" | bc -l | cut -d'.' -f1)
  nx=$(echo "$width * 0.15" | bc -l | cut -d'.' -f1)
  ny=$((y + 12))
  bspc rule -a URxvt:dropdown -o monitor=$mon rectangle=${nwidth}x${nheight}+${nx}+${ny}
}

# TODO: handle situation where tmp file was deleted but window exists
dropdown=/tmp/bspwm:dropdown
if [ ! -f $dropdown ] || [ -z "$(xdotool search --classname dropdown)" ]; then
  geometry
  urxvt -name 'dropdown' -e tmux_startup.sh &
  bspc query -N -n $(xdotool search --sync --onlyvisible --classname 'dropdown') >$dropdown
  exit
fi

id=$(cat $dropdown)
state=$(bspc query -T -n "$id" | jq '.hidden')
dtop=$(bspc query -D -d)
check=$(bspc query -N -d | grep "$id")

if ! [ "$check" = "$id" ]; then
  geometry
  bspc node "$id" -d "$dtop"
  xdotool windowmap "$id"
  #bspc node $id --flag hidden=off
  bspc node -f "$id"
elif [ "$check" = "$id" ] && [ "$state" = "true" ]; then
  geometry
  xdotool windowmap "$id"
  #bspc node $id --flag hidden=off
  bspc node -f "$id"
else
  xdotool windowunmap "$id"
  #bspc node $id --flag hidden=on
fi
