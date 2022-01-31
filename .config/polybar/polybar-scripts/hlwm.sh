#!/bin/bash

GLYWS1=""
GLYWS2=""
GLYWS3=""
GLYWS4=""
GLYWS5=""
GLYWS6=""
GLYWS7=""
GLYWS8=""
GLYWS9=""
GLYWS10=""

herbstclient --idle "tag_*" 2>/dev/null | {

    while true; do
        # Read tags into $tags as array
        IFS=$'\t' read -ra tags <<<"$(herbstclient tag_status)"
        {
            for f in "${tags[@]}"; do
                status+=(${f:0:1})
            done

            for i in "${!tags[@]}"; do
                if [[ ${tags[$i]} == *"1"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS1}"
                elif [[ ${tags[$i]} == *"2"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS2}"
                elif [[ ${tags[$i]} == *"3"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS3}"
                elif [[ ${tags[$i]} == *"4"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS4}"
                elif [[ ${tags[$i]} == *"5"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS5}"
                elif [[ ${tags[$i]} == *"6"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS6}"
                elif [[ ${tags[$i]} == *"7"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS7}"
                elif [[ ${tags[$i]} == *"8"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS8}"
                elif [[ ${tags[$i]} == *"9"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS9}"
                elif [[ ${tags[$i]} == *"0"* ]]; then
                    tags[$i]=${status[$i]}"${GLYWS10}"
                else
                    break && notify-send "Hlwm status broke"
                fi
            done
            count=1
            for i in "${tags[@]}"; do
                # Read the prefix from each tag and render them according to that prefix
                case ${i:0:1} in
                '#')
                    # the tag is viewed on the focused monitor
                    # TODO Add your formatting tags for focused workspaces
                    echo "%{F#af875f}%{B#262626}"
                    ;;
                ':')
                    # : the tag is not empty
                    # TODO Add your formatting tags for occupied workspaces
                    echo "%{F#dfdfaf}%{B#3a3a3a}"
                    ;;
                '!')
                    # ! the tag contains an urgent window
                    # TODO Add your formatting tags for workspaces with the urgent hint
                    echo "%{F#af5f5f}%{B#3a3a3a}"
                    ;;
                '-')
                    # - the tag is viewed on a monitor that is not focused
                    # TODO Add your formatting tags for visible but not focused workspaces
                    echo "%{F#87afaf}%{B#3a3a3a}"
                    ;;
                *)
                    # . the tag is empty
                    # There are also other possible prefixes but they won't appear here
                    echo "%{F#262626}%{B#3a3a3a}" # Add your formatting tags for empty workspaces
                    ;;
                esac

                if [ $count -eq 10 ]; then
                    count=0
                fi

                echo "%{A1:herbstclient use $count:} ${i:1} %{A}${CLR}"
                count=$((count + 1))
            done

            # reset foreground and background color to default
            echo "%{F-}%{B-}"
        } | tr -d "\n"

        echo

        # wait for next event from herbstclient --idle
        read -r || break
    done
} 2>/dev/null
