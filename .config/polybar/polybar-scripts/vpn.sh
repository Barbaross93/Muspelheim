#!/bin/bash

. "$HOME/.config/herbstluftwm/colorschemes/alduin.sh"
GLYVPN=""
RED="%{F$color1}"
GREY="%{F$color8}"

vpnicon() {
    cvpn=""
    vpn="$(ip addr | grep 'barbarossvpn\|tun0' | awk '{print $2}' | grep -v -E '^[0-9]+' | tr -d ':')"
    for v in $vpn; do
        case "$v" in
        barbarossvpn)
            cvpn+="${RED}%{A1:sudo -A wg-quick down barbarossvpn:}${GLYVPN}%{A}"
            ;;
        tun0)
            cvpn+="${ORANGE}%{A1:sudo -A pkill openvpn:}${GLYVPN}%{A}"
            ;;
        esac
    done
    [ -z "$cvpn" ] && cvpn="${GREY}%{A1:sudo wg-quick up barbarossvpn:}${GLYVPN}%{A}"

    echo " $cvpn "
}
vpnicon
ip monitor netconf |
    while read -r line; do
        echo "$line" | grep "barbarossvpn\|tun0" && vpnicon
    done
