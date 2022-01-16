#!/usr/bin/env bash

hc() { "${herbstclient_command[@]:-herbstclient}" "$@"; }

# loads layouts for each tag coming from stdin
# the format is the one created by savestate.sh

# a common usage is:
# savestate.sh > mystate
# and sometime later:
# loadstate.sh < mystate

### Loads the frame layout
while IFS="" read -r line; do
    tag="${line%%: *}"
    tree="${line#*: }"
    hc add "$tag"
    hc load "$tag" "$tree"
done <~/.config/herbstluftwm/sessions/saved_session

##########################################################################

### Launches one shot rules
~/.config/herbstluftwm/sessions/saved_session_rules

##########################################################################

### Launches programs to fulfill rules
tmux kill-session -t Music
~/.config/herbstluftwm/sessions/saved_session_programs

##########################################################################

### Cleanup
rm ~/.config/herbstluftwm/sessions/saved_session
rm ~/.config/herbstluftwm/sessions/saved_session_rules
rm ~/.config/herbstluftwm/sessions/saved_session_programs
