#!/usr/bin/env sh

ID=$(task export | jq -r 'sort_by( -.urgency )[] | [ (.id|tostring), .description ] | join("	")' | awk '!$1=="0"' |
  dmenu -i -p "Tasks:" |
  cut -f 1)

case "$ID" in
'')
  exit
  ;;
*[0-9]*)
  ACTION=$(printf "start\nstop\nedit\ndelete\ndone" | dmenu -i -p "Action:")
  ;;
*)
  ACTION="add"
  ;;
esac

[ -z "$ACTION" ] && exit
task "$ID" "$ACTION"
