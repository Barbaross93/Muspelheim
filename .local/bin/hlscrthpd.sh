#!/usr/bin/env bash
#set -euo pipefail

geometry() {
  mrect=($(herbstclient monitor_rect ""))

  width=${mrect[2]}
  height=${mrect[3]}
  x=${mrect[0]}
  y=${mrect[1]}
  rect=(
    $(bc -l <<<"$width * 0.7" | cut -d'.' -f1)
    $(bc -l <<<"$height * 0.6" | cut -d'.' -f1)
    #$(($x+$(bc -l <<< "$width * 0.15" | cut -d'.' -f1)))
    $(bc -l <<<"$width * 0.15" | cut -d'.' -f1)
    $((y + 16))
  )
  herbstclient rule once instance=dropdown floating_geometry=${rect[0]}x${rect[1]}+${rect[2]}+${rect[3]}
}

dropdown=/tmp/herbstluftwm:dropdown
if xdo id -n dropdown; then
  if [[ $(herbstclient list_monitors | grep '[FOCUS]' | cut -d'"' -f2) == $(herbstclient attr clients.$(cat $dropdown) | grep 's - - tag' | awk '{ print $6 }' | tr -d \") ]]; then
    xdo hide -n 'dropdown'
    exit
  fi
fi
if [[ -f $dropdown ]]; then
  if ! herbstclient bring $(cat $dropdown); then
    geometry
    xdo show -n 'dropdown' && exit
  fi
fi
if ! xdo show -n 'dropdown'; then
  geometry
  setsid -f alacritty --class 'dropdown' -e tmux new -As Dropdown
  xdo id -m -n 'dropdown' | tr "[:upper:]" "[:lower:]" | sed -r 's/0x([0]+)/0x/' >$dropdown
fi
