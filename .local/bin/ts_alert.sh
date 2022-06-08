#!/bin/sh

#Wrapper around task spooler's 'on finish' command
#Alert all relevant info passed to script

if [ "$2" -eq 0 ]; then
	notify-send "Task Spooler" "Task $1 completed successfully!"
else
	notify-send "Task Spooler" "Task $1 exited with an error! Output can be found at $3"
fi
