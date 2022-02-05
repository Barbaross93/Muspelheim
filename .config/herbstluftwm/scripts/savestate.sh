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

descendent_pids() {
    pid=$(ps h -o pid --ppid $1)
    echo $pid
    for d in $pid; do
        descendent_pids $d
    done
}

for i in $(herbstclient complete 1 use); do
    wids=($(herbstclient list_clients --tag=$i))
    pids=()
    titles=()
    for w in "${wids[@]}"; do
        pids+=($(xdo pid "$w"))
        titles+=("$(herbstclient get_attr clients.$w.title)")
    done

    c=0
    for p in "${pids[@]}"; do
        pprocess="$(ps h -o command $p)"
        if [[ "$pprocess" == *"urxvt"* ]]; then
            cpid=$(descendent_pids $p | tail -2)
            spid=$(descendent_pids $p | head -2 | tail -1)
            cwd=$(pwdx $spid | cut -d' ' -f2-)
            tcmd=$(ps h -o command $cpid)
            # Ranger starts a fuckload of bg processes, so we just
            # correct it to call ranger directly
            if [[ "${titles[$c]}" =~ "ranger" ]]; then
                tcmd=$(echo "${titles[$c]}" | tr ":" " ")
            fi
            [ -z $cwd ] && cwd=/home/barbaross
            cmd="urxvt -title ${titles[$c]} -cd $cwd -e $tcmd"
        else
            cmd=$pprocess
        fi
        c=$((c + 1))
        echo $cmd | sed 's/^/setsid -f /' >>$session_dir/saved_session_programs
    done
done
chmod +x $session_dir/saved_session_programs

if [ -f $session_dir/saved_session ] && [ -f $session_dir/saved_session_programs ] && [ -f $session_dir/saved_session_rules ]; then
    notify-send -t 3000 -u normal "Session stored!"
fi
