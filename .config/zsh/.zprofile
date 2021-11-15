# Auto start X
if [ -z "${DISPLAY}" ] && [ "$(fgconsole)" -eq 1 ]; then
	clear
	exec sx &>/dev/null
	#export XAUTHORITY="/tmp/Xauthority"
	#exec startx ${HOME}/.config/x11/xinitrc -- ${HOME}/.config/x11/xserverrc -background none &>/dev/null
fi
