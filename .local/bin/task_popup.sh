#!/bin/sh
# found this code on http://taskwarrior.org/projects/1/wiki/Export-htmlpy
# For cron: */30 * * * * DISPLAY=:0.0 /home/User/configs/TaskNotify.sh
# Requires linux with notify-send and canberra-gtk-play which are default on Ubuntu

num=$(task active | wc -l)
if [ $num -gt "1" ]; then
  info="Active Tasks: $(task rc.gc=no rc.indent.report=4 rc.verbose= rc.report.next.columns=description.desc rc.report.next.labels= rc.defaultwidth=1000 next +ACTIVE 2>/dev/null </dev/null | sed -n '4 p' | awk '$1=$1')"
  notify-send "Taskwarrior" "$info"
  #printf "Active Tasks:\t$(task rc.gc=no rc.indent.report=4 rc.verbose= rc.report.next.columns=description.desc rc.report.next.labels= rc.defaultwidth=1000 next +ACTIVE 2>/dev/null </dev/null | sed -n '4 p' | awk '$1=$1')\n" >$XNOTIFY_FIFO
else
  info="No Active Tasks! C'mon! What are you doing?"
  notify-send "Taskwarrior" "$info"
  #printf "No Active Tasks\tC'mon! What are you doing?\n" >$XNOTIFY_FIFO
fi
