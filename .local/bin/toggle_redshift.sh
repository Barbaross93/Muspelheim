#!/bin/sh

if pidof redshift; then
    pkill redshift
    printf "SEC:3\tRedshift disabled\n" >$XNOTIFY_FIFO
else
    redshift -l "$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lat, .location.lng' | tr '\n' ':' | sed 's/:$//')" &
    printf "SEC:3\tRedshift enabled\n" >$XNOTIFY_FIFO
fi
