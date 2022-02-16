#!/bin/env bash

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

bltth() {
	rfkill event |
		while read -r line; do
			status=$(echo "$line" | grep "type 2" | awk '{print $10}')

			[ -z "$status" ] && status=1
			echo "bluetooth|int|${status}"

		done
}

vpninfo() {
	vpnicon() {
		cvpn=""
		vpn="$(ip addr | grep 'barbarossvpn\|tun0' | awk '{print $2}' | grep -v -E '^[0-9]+' | tr -d ':')"
		for v in $vpn; do
			case "$v" in
			barbarossvpn)
				cvpn+="wireguard"
				;;
			tun0)
				cvpn+="openvpn"
				;;
			esac
		done
		[ -z "$cvpn" ] && cvpn="none"

		echo "vpn|string|${cvpn}"
	}
	vpnicon
	ip monitor netconf |
		while read -r line; do
			echo "$line" | grep "barbarossvpn\|tun0" && vpnicon
		done
}

caffeine() {
	[ -e /tmp/caffeine.fifo ] && rm /tmp/caffeine.fifo
	mkfifo /tmp/caffeine.fifo
	tail -f /tmp/caffeine.fifo |
		while read -r event; do
			# Caffeine status
			echo "caffeine|bool|${event}"
		done
}

kb() {
	[ -e /tmp/kb.fifo ] && rm /tmp/kb.fifo
	mkfifo /tmp/kb.fifo
	tail -f /tmp/kb.fifo |
		while read -r layer; do
			echo "kb|string|${layer}"
		done
}

{
	bltth &
	vpninfo &
	caffeine &
	kb &
} |
	while read -r line; do
		[[ "$line" =~ ^bluetooth.* ]] && bluetooth=$line
		[[ "$line" =~ ^vpn.* ]] && vpn=$line
		[[ "$line" =~ ^caffeine.* ]] && caffeine=$line
		[[ "$line" =~ ^kb.* ]] && kb=$line

		[[ -z $caffeine ]] && caffeine=false
		[[ -x $kb ]] && kb=qwerty
		# Every time there is an update, everything needs to be redrawn;
		# otherwise non-updated modules get cleared. The above saves the last update
		# from the module, so that we can simply echo it rather than query it
		echo "$bluetooth"
		echo "$vpn"
		echo "$caffeine"
		echo "$kb"
		echo ""
	done
wait
