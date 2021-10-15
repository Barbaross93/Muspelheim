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
if xdotool search --onlyvisible --classname 'dropdown'; then
  if [[ $(herbstclient list_monitors | grep '[FOCUS]' | cut -d'"' -f2) == $(herbstclient attr clients.$(cat $dropdown) | grep 's - - tag' | awk '{ print $6 }' | tr -d \") ]]; then
    xdotool search --onlyvisible --classname 'dropdown' windowunmap
    exit
  fi
fi
if [[ -f $dropdown ]]; then
  if ! herbstclient bring $(cat $dropdown); then
    geometry
    xdotool search --classname 'dropdown' windowmap && exit
  fi
fi
if ! xdotool search --classname 'dropdown' windowmap; then
  geometry
  urxvt -name 'dropdown' -e tmux_startup.sh &
  xdotool search --sync --onlyvisible --classname 'dropdown'
  herbstclient attr clients.focus.winid >$dropdown
fi
