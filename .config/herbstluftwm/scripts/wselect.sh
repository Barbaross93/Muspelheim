#!/usr/bin/env bash

# a window selection utility
# dependencies: wmctrl, awk,
#               dmenu with multiline support (command line flag -l)

#xdotool getactivewindow windowsize 448 413 windowmove 732 331

hc() { ${herbstclient_command:-herbstclient} "$@"; }
dm() { ${dmenu_command:-dmenu} "$@"; }
dmenu_lines=${dmenu_lines:-10}

case "$1" in

bring)
    # bring the selected window to the current tag and focus it
    name='Bring: '
    action() { hc bring "$@"; }
    ;;

select_here | *)
    # first focus the tag of the selected window and then select the window
    # this enforces that the setting swap_monitors_to_get_tag is respected:
    # if set, the tag is brought to the focused monitor and the window gets focused.
    # if unset, the focused jumps to the desired window and its position on
    # the screen(s) remains the same.
    name='Select: '
    action() {
        local winid=$(sed 's,0x[0]*,0x,' <<<"$*")
        local tag=$(hc attr clients."$winid".tag)
        hc lock
        hc use "$tag"
        hc jumpto "$*"
        hc unlock
    }
    ;;

select)
    # switch to the selected window and focus it
    action() { hc jumpto "$@"; }
    name='Select: '
    ;;
esac

#wmctrl -l |cat -n| sed 's/\t/) /g'| sed 's/^[ ]*//' \
id=$(hc foreach C clients. sprintf ATTR_V '%c.minimized' C and , compare ATTR_V != true , sprintf ATTR_TITLE '%c.title' C substitute TITLE ATTR_TITLE echo C TITLE | cut -d'.' -f2- | grep -v 'wselect.sh' | cat -n | sed 's/\t/) /g' | sed 's/^[ ]*//' |
    dm -p "$name") &&
    action $(awk '{ print $2 ; }' <<<"$id")
