#!/bin/sh

# Things to do between fullscreen states

herbstclient --idle "fullscreen" | while read -r event; do

  # Toggles notification state when fullscreen is active
  case "$event" in
  *on*)
    echo pause >/tmp/signal_bar
    ;;
  *off*)
    echo resume >/tmp/signal_bar
    ;;
  esac
done
