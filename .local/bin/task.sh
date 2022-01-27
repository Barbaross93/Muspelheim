#!/usr/bin/env sh

ID=$(task export | jq -r 'sort_by( -.urgency )[] | [ (.id|tostring), .description ] | join("	")' | awk '!$1=="0"' |
  dmenu -p "Tasks:" |
  cut -f 1)
[ -z "$ID" ] && echo "Cancelled." && exit

ACTION=$(printf "add\nstart\nstop\nedit\ndelete\ndone" | dmenu -p "Action:")
[ -z "$ACTION" ] && echo "Cancelled." && exit

task "$ID" "$ACTION"
