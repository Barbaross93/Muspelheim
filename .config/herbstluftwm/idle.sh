#!/usr/bin/env bash

# Stuff to do on focus/fullscreen changes

herbstclient --idle "focus_changed|fullscreen" | while read -r event; do
  case "$event" in
  *focus_changed*)
    ### Summary of the ridiculous command below (sep. by '^')
    ### Two '#' indicate deactivated
    # Lock before changes
    # hide the frame border if the focused frame is empty
    # check if focused window is floating, if so, change active frame color (to reduce active window confusion)
    # All clear!
    herbstclient chain \
      ^ lock \
      ^ mktemp int OPACITY chain \
      : set_attr OPACITY 100 \
      : and . compare tags.focus.frame_count = 1 \
      . compare tags.focus.curframe_wcount = 0 \
      . set_attr OPACITY 0 \
      : substitute VAL OPACITY set frame_active_opacity VAL \
      ^ or \
      . and , compare tags.focus.floating_focused = true \
      , set frame_border_active_color '#1c1c1c' \
      . set frame_border_active_color '#af875f' \
      ^ unlock
    ;;
  *fullscreen*on*)
    # Pause notifications while in fullscreen
    echo pause >/tmp/signal_bar
    ;;
  *fullscreen*off*)
    # Resume notifications after fullscreen
    echo resume >/tmp/signal_bar
    ;;
  esac
done
