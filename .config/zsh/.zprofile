# Auto start X on tty1
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
	clear
	#exec ~/.local/bin/x &>/dev/null
	export XAUTHORITY="${HOME}/.local/share/x11/xauthority"
	exec startx ${HOME}/.config/x11/xinitrc -- ${HOME}/.config/x11/xserverrc &>/dev/null
fi
