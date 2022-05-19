#!/bin/sh

remind -s3 ~/.local/share/office/reminders | rem2ics >~/.local/share/office/cullen.ross.som@gmail.com/reminders.ics
vdirsyncer sync
