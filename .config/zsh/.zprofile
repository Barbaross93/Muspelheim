# Auto start X on tty1, autostart wayland on tty2
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
	clear
	#exec ~/.local/bin/x &>/dev/null
	export MESA_LOADER_DRIVER_OVERRIDE=i965
	export XAUTHORITY="${HOME}/.local/share/x11/xauthority"
	exec startx ${HOME}/.config/x11/xinitrc -- ${HOME}/.config/x11/xserverrc -background none &>/dev/null
fi
