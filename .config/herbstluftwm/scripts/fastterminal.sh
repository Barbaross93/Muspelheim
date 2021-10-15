#!/usr/bin/env bash

# give some space very fast for a terminal
# requires bc

# usage: 

bottom=false
orientation=vertical

while test $# -gt 0; do
    case "$1" in
        -b)
            bottom=true
            shift
            ;;
        -t)
            bottom=false
            shift
            ;;
        -v)
            orientation=vertical
            shift
            ;;
        -h)
            orientation=horizontal
            shift
            ;;
        --help)
            echo "Usage: $0 [--help] [-h|-v] [-b|-t] [RATIO]" && exit
            ;;
        *)
            ratio="$1"
            break
            ;;
    esac
done

if [ -z "$ratio" ]; then
    ratio=0.5
fi

vertical(){
    child1="(clients horizontal:0)"
    child2=""
    focus=0 # 1 means old, 0 means new frame

    if $bottom ; then
        focus=$(echo "1-$focus"|bc)
        ratio=$(echo "1-$ratio"|bc -l)
        child2="$child1"
        child1=""
    fi

    args="vertical:0$ratio:$focus"
    herbstclient load "(split $args $child1 $(herbstclient dump) $child2 )"
}

#bottom=false means split left; bottom=true means split right
horizontal() {
    #ratio=${1:-0.5}
    child1="(clients vertical:0)"
    child2=""
    focus=0 # 1 means old, 0 means new frame

    if $bottom ; then
        focus=$(echo "1-$focus"|bc)
        ratio=$(echo "1-$ratio"|bc -l)
        child2="$child1"
        child1=""
    fi

    args="horizontal:0$ratio:$focus"
    herbstclient load "(split $args $child1 $(herbstclient dump) $child2 )"
}
if [[ "$orientation" == "vertical" ]]; then
    vertical
else
    horizontal
fi




