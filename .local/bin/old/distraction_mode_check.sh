#!/bin/sh

day_of_week=$(date "+%u")
current_hour=$(date "+%H")

current_setting=$(grep -A 1 content.blocking.method /home/barbaross/.config/qutebrowser/autoconfig.yml | grep -o "auto\|both")

if [ "$day_of_week" -ne 7 ] && [ "$day_of_week" -ne 6 ]; then
    if [ $current_hour -ge 9 ] || [ $current_hour -le 16 ] && [ "$current_setting" = "auto" ]; then
        /usr/bin/qutebrowser --nowindow ':set content.blocking.method both ;; set content.blocking.hosts.lists ["file://home/barbaross/.config/qutebrowser/host_block"] ;; adblock-update ;; message-info "Distraction free mode enabled"'
    elif [ $current_hour -lt 6 ] || [ $current_hour -gt 16 ] && [ "$current_setting" = "both" ]; then
        /usr/bin/qutebrowser --nowindow ':set content.blocking.method auto ;; adblock-update ;; message-info "Distraction free mode disabled"'
    fi
elif [ "$current_setting" = "both" ]; then
    /usr/bin/qutebrowser --nowindow ':set content.blocking.method auto ;; adblock-update ;; message-info "Distraction free mode disabled"'
fi
