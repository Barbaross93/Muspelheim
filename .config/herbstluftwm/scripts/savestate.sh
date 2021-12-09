#!/usr/bin/env bash

hc() { "${herbstclient_command[@]:-herbstclient}" "$@"; }

session_dir="$HOME/.config/herbstluftwm/sessions"

# prints a machine readable format of all tags and its layouts
# one tag with its layout per line

# a common usage is:
# savestate.sh > mystate
# and sometime later:
# loadstate.sh < mystate

### Saves the frame layout
{
    hc complete 1 use |
        while read tag; do
            echo -n "$tag: "
            hc dump "$tag"
        done
} >$session_dir/saved_session

#########################################################################################################

### Saves what programs were opened and creates one shot rules for their subsequent launch
echo "#!/usr/bin/env bash" >$session_dir/saved_session_rules
for id in $(herbstclient foreach C clients. echo C | grep -oE '0x[0-9a-fA-F]*'); do
    client="clients.${id}"
    rule=(
        class="$(herbstclient get_attr ${client}.class)"
        instance="$(herbstclient get_attr ${client}.instance)"
        tag="$(herbstclient get_attr ${client}.tag)"
    )
    ## Rules for when to acquire the title as well
    if [[ "${rule[0]}" =~ (class=URxvt|class=Zathura) ]]; then
        rule+=(
            "title=\"$(herbstclient get_attr ${client}.title)\""
        )
    fi
    if herbstclient compare "${client}.floating" = on; then
        rule+=("floating=on")
        consequence=
    else
        rule+=(
            "index=$(herbstclient get_attr ${client}.parent_frame.index)"
        )
    fi
    echo herbstclient rule once "${rule[@]}" >>$session_dir/saved_session_rules
done

chmod +x $session_dir/saved_session_rules

#########################################################################################################

### Create launch list
echo "#!/usr/bin/env bash" >$session_dir/saved_session_programs

programs=($(cat $session_dir/saved_session_rules | awk '{print $5}' | cut -d'=' -f2-))

## Loop programs and correct them if needed
for i in "${!programs[@]}"; do
    n=$((i + 2))
    # Generally, a terminal is running something, be it fish or some other running process
    if [[ "${programs[$i]}" == "urxvt" ]]; then
        title=$(cat $session_dir/saved_session_rules | sed -n -e $n\p | grep -o '".*"' | tr -d '"')
        if grep "ncmpcpp" <(echo "$title"); then
            title=ncmpcpp
        elif grep "WeeChat" <(echo "$title"); then
            title=weechat
        fi
        programs[$i]="urxvt -title '$title' -e $title"
    fi

    # Special spotify tmux session
    if [[ "${programs[$i]}" == "Spotify" ]]; then
        programs[$i]="urxvt -name \"Spotify\" -e bash -ic \"tmux new-session -s Spotify 'tmux source-file ~/.config/spotifyd/tmux_session'\""
    fi

    # Correction for dropdown term
    if [[ "${programs[$i]}" == "dropdown" ]]; then
        programs[$i]="hlscrthpd.sh"
    fi

    # Reload zathura instances
    if [[ "${programs[$i]}" == "org.pwmt.zathura" ]]; then
        title=$(cat $session_dir/saved_session_rules | sed -n -e $n\p | grep -o '".*"' | tr -d '"')
        #sed -i "s|title=\"$title\"||" $session_dir/saved_session_rules
        programs[$i]="zathura $title"
    fi

    # mpv
    if [[ "${programs[$i]}" == "mpv" ]]; then
        title=$(cat $session_dir/saved_session_rules | sed -n -e $n\p | grep -o '".*"' | tr -d '"')
        programs[$i]="$title"
    fi

    echo setsid -f "${programs[$i]}" >>$session_dir/saved_session_programs
done

chmod +x $session_dir/saved_session_programs

if [ -f $session_dir/saved_session ] && [ -f $session_dir/saved_session_programs ] && [ -f $session_dir/saved_session_rules ]; then
    notify-send -t 3000 -u normal "Session stored!"
fi
