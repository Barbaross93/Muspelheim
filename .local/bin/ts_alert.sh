#!/bin/sh

#Wrapper around task spooler's 'on finish' command
#Alert all relevant info passed to script

notify-send "Task Spooler" "Task $1 exited with code $2 and output at $3"
