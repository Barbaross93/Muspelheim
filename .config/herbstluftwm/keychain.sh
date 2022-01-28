#!/usr/bin/env bash

# Execute this (e.g. from your autostart) to obtain basic key chaining like it
# is known from other applications like screen.
#
# E.g. you can press Mod1-i 1 (i.e. first press Mod1-i and then press the
# 1-button) to switch to the first workspace
#
# The idea of this implementation is: If one presses the prefix (in this case
# Mod1-i) except the notification, nothing is really executed but new
# keybindings are added to execute the actually commands (like use_index 0) and
# to unbind the second key level (1..9 and 0) of this keychain. (If you would
# not unbind it, use_index 0 always would be executed when pressing the single
# 1-button).

hc() { "${herbstclient_command[@]:-herbstclient}" "$@"; }

# Create the array of keysyms, the n'th entry will be used for the n'th
# keybinding
keys=(m g)

# Build the command to unbind the keys
unbind=()
for k in "${keys[@]}" Escape; do
    unbind+=(, keyunbind "$k")
done

# Add the actual bind, after that, no new processes are spawned when using that
# key chain. (Except the spawn notify-send of course, which can be deactivated
# by only deleting the appropriate line)

# Recording binds

hc keybind Mod4-r chain \
    '->' spawn notify-send "hlwm" "Record mp4/gif (mg) or press Escape" \
    '->' keybind "${keys[0]}" chain "${unbind[@]}" , spawn mp4 \
    '->' keybind "${keys[1]}" chain "${unbind[@]}" , spawn gif \
    '->' keybind Escape chain "${unbind[@]}" #Keychain to record mp4 or gif fulscreen

#hc keybind Mod4-Mod1-r chain \
#    '->' spawn notify-send "hlwm" "Record mp4/gif selection (mg) or press Escape" \
#    '->' keybind "${keys[0]}" chain "${unbind[@]}" , spawn mp4 -s \
#    '->' keybind "${keys[1]}" chain "${unbind[@]}" , spawn gif -s \
#    '->' keybind Escape chain "${unbind[@]}" #Keychain to record mp4 or gif selection

#########################################################################################

# Music info
keys=(n a)

unbind=()
for k in "${keys[@]}" Escape; do
    unbind+=(, keyunbind "$k")
done

hc keybind Mod4-c chain \
    '->' spawn notify-send "hlwm" "Song info/cover art (na) or press Escape" \
    '->' keybind "${keys[0]}" chain "${unbind[@]}" , spawn ~/.config/cmus/cmus_notify.sh \
    '->' keybind "${keys[1]}" chain "${unbind[@]}" , spawn ~/.config/cmus/art.sh \
    '->' keybind Escape chain "${unbind[@]}" #Keychain for song info/art

#########################################################################################

# Toggle window states
keys=(p f a)

unbind=()
for k in "${keys[@]}" Escape; do
    unbind+=(, keyunbind "$k")
done

hc keybind Mod4-s chain \
    '->' spawn notify-send "hlwm" "Toggle window states (pfa) or press Escape" \
    '->' keybind "${keys[0]}" chain "${unbind[@]}" , pseudotile toggle \
    '->' keybind "${keys[1]}" chain "${unbind[@]}" , attr clients.focus.floating toggle \
    '->' keybind "${keys[2]}" chain "${unbind[@]}" , fullscreen toggle \
    '->' keybind Escape chain "${unbind[@]}" #Keychain for window states

#########################################################################################

# Pomo controls
keys=(s t k)

unbind=()
for k in "${keys[@]}" Escape; do
    unbind+=(, keyunbind "$k")
done

hc keybind Mod4-p chain \
    '->' spawn notify-send "hlwm" "Pomodoro controls (stk) or press Escape" \
    '->' keybind "${keys[0]}" chain "${unbind[@]}" , spawn pomo -s \
    '->' keybind "${keys[1]}" chain "${unbind[@]}" , spawn pomo -t \
    '->' keybind "${keys[2]}" chain "${unbind[@]}" , spawn pomo -k \
    '->' keybind Escape chain "${unbind[@]}" #Keychain for pomodoro ctrls

#########################################################################################
