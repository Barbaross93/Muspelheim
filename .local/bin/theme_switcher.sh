#!/bin/sh

# Place config files here to edit
#declare -a files
files="$HOME/.local/bin/ddmenu
$HOME/.config/polybar/config
$HOME/.config/polybar/polybar-scripts/pomo-info
$HOME/.config/polybar/polybar-scripts/redshift.sh
$HOME/.config/tmux/myrmidontmux
$HOME/.config/xob/styles.cfg
$HOME/.config/tmux/tmux.conf.local
$HOME/.config/qutebrowser/gruvbox/draw.py
$HOME/.config/qutebrowser/startpage/index.html
$HOME/.config/qt5ct/qss/custom-tooltip.qss
$HOME/.config/qt5ct/qss/custom-context-menu.qss
$HOME/.config/bspwm/colorschemes/gruvbox-dark.sh"

#dark to light theme
dtl() {
	#light=true
	echo "$files" | while read i; do
		echo "$i"
		sed -i 's/#282828/#fbf1c7/g' "$i"
		sed -i 's/#ebdbb2/#3c3836/g' "$i"
		sed -i 's/#504945/#d5c4a1/g' "$i"
		sed -i 's/#a89984/#7c6f64/g' "$i"
		sed -i 's/#928374/#928374/g' "$i"
		sed -i 's/#fb4934/#9d0006/g' "$i"
		sed -i 's/#b8bb26/#79740e/g' "$i"
		sed -i 's/#fabd2f/#b57614/g' "$i"
		sed -i 's/#83a598/#076678/g' "$i"
		sed -i 's/#d3869b/#8f3f71/g' "$i"
		sed -i 's/#8ec07c/#427b58/g' "$i"
	done

	#xwallpaper --center ~/Pictures/gruvgenome-light.png &
	sed -i 's|#include "/home/barbarossa/.config/x11/colorschemes/gruvbox-dark"|#include "/home/barbarossa/.config/x11/colorschemes/gruvbox-light"|g' ~/.config/x11/Xresources
	sed -i 's/set background=dark/set background=light/g' ~/.config/vim/vimrc
	#sed -i "28s/.*/(setq doom-theme 'doom-everforest-light)/" ~/.doom.d/config.el
	sed -i "s/c.colors.webpage.darkmode.enabled = True/c.colors.webpage.darkmode.enabled = False/g" ~/.config/qutebrowser/config.py
	#sed -i "s/colors: \*everforest_dark_soft/colors: \*everforest_light_soft/g" ~/.config/alacritty/alacritty.yml
	#paleta <~/.config/paleta/gruvbox/light.pal
	#sed -i "28s/dark/light/" ~/.local/bin/lock_msg.sh
	zathuraconf -f ~/.config/zathura/colorschemes/gruvbox-light.json
	echo "set font 'Terminus 10'" >>~/.config/zathura/zathurarc
	gtk_theme="Net/ThemeName \"gruvbox-light\"" #\nNet/CursorThemeName \"pixelfun3\""
	echo light >/tmp/theme_state
}

#light to dark theme
ltd() {
	#light=false
	echo "$files" | while read i; do
		echo "$i"
		sed -i 's/#fbf1c7/#282828/g' "$i"
		sed -i 's/#3c3836/#ebdbb2/g' "$i"
		sed -i 's/#d5c4a1/#504945/g' "$i"
		sed -i 's/#7c6f64/#a89984/g' "$i"
		sed -i 's/#928374/#928374/g' "$i"
		sed -i 's/#9d0006/#fb4934/g' "$i"
		sed -i 's/#79740e/#b8bb26/g' "$i"
		sed -i 's/#b57614/#fabd2f/g' "$i"
		sed -i 's/#076678/#83a598/g' "$i"
		sed -i 's/#8f3f71/#d3869b/g' "$i"
		sed -i 's/#427b58/#8ec07c/g' "$i"
	done

	#xwallpaper --center ~/Pictures/gruvgenome-dark.png &
	sed -i 's|#include "/home/barbarossa/.config/x11/colorschemes/gruvbox-light"|#include "/home/barbarossa/.config/x11/colorschemes/gruvbox-dark"|g' ~/.config/x11/Xresources
	sed -i 's/set background=light/set background=dark/g' ~/.config/vim/vimrc
	#sed -i "28s/.*/(setq doom-theme 'doom-everforest)/g" ~/.doom.d/config.el
	sed -i "s/c.colors.webpage.darkmode.enabled = False/c.colors.webpage.darkmode.enabled = True/g" ~/.config/qutebrowser/config.py
	#sed -i "s/colors: \*everforest_light_soft/colors: \*everforest_dark_soft/g" ~/.config/alacritty/alacritty.yml
	#paleta <~/.config/paleta/gruvbox/dark.pal
	#sed -i "28s/light/dark/" ~/.local/bin/lock_msg.sh
	zathuraconf -f ~/.config/zathura/colorschemes/gruvbox-dark.json
	echo "set font 'Terminus 10'" >>~/.config/zathura/zathurarc
	gtk_theme="Net/ThemeName \"gruvbox-dark\"" #\nNet/CursorThemeName \"pixelfun3-eclipse\""
	echo dark >/tmp/theme_state
}

reload() {
	xrdb ~/.config/x11/Xresources
	killall -USR1 st
	killall -USR1 tabbed
	#pkill xcompmgr && xcompmgr & # Sadly, tabbed doesnt update colors w/o some sort of external refresh. Need to figure out how to apply the refresh internally
	pkill -f "bash+.bar*"
	killall lemonbar
	bar.sh &
	#polybar-msg cmd restart
	pkill xnotify
	notif.sh &
	#killall -USR1 urxvt && killall -USR1 urxvtd
	vim_reload.sh &
	#nvim-reload.py &
	tmux source-file ~/.config/tmux/tmux.conf
	if pgrep qutebrowser; then
		qutebrowser ':config-source'
		#qutebrowser ':restart'
	fi
	pkill xob
	xob_startup.sh &
	pkill xsettingsd
	env printf "$gtk_theme" >/tmp/gtk_theme
	xsettingsd -c /tmp/gtk_theme &
	bspc wm -r
	#disown -a
	## Doesn't reload or could be done better
	# zathura: Have to manually source it in window
	# dunst; have to kill it first
}

time_vars() {
	latitude="39.2904N"
	#latitude="$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lat' | tr '\n' ':' | sed 's/:$//')N"
	longitude="76.6122W"
	#longitude="$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lng' | tr '\n' ':' | sed 's/:$//')W"
	sunrise=$(sunwait list daylight rise $latitude $longitude)
	sunset=$(sunwait list daylight set $latitude $longitude)

	sunrise_hour=$(echo "$sunrise" | cut -d':' -f1)
	sunrise_minute=$(echo "$sunrise" | cut -d':' -f2)
	sunset_hour=$(echo "$sunset" | cut -d':' -f1)
	sunset_minute=$(echo "$sunset" | cut -d':' -f2)

	unix_now=$(date +%s)
	unix_sunrise=$(date --date="$sunrise" +%s)
	unix_sunset=$(date --date="$sunset" +%s)
}

cron_setup() {
	time_vars
	crontab -l >/tmp/cronlist
	sed -i '/theme_switcher.sh/d' /tmp/cronlist
	# sunrise cronjob
	echo "$sunrise_minute $sunrise_hour * * * /home/barbarossa/.local/bin/theme_switcher.sh -s -w" >>/tmp/cronlist
	# Sunset cronjob
	echo "$sunset_minute $sunset_hour * * * /home/barbarossa/.local/bin/theme_switcher.sh -s -w" >>/tmp/cronlist
	crontab /tmp/cronlist && rm /tmp/cronlist
}

mouse() {
	# Load mouse theme on startup. Unfortunately, I can't live reload a mouse completely in a running X session
	time_vars
	if [ "$unix_now" -ge "$unix_sunrise" ] && [ "$unix_now" -le "$unix_sunset" ]; then
		sed -i '5s/.*/gtk-cursor-theme-name=pixelfun3/' ~/.config/gtk-3.0/settings.ini
		sed -i '5s/.*/Inherits=pixelfun3/' ~/.local/share/icons/default/index.theme
		sed -1 '1s/.*/Xcursor.theme: pixelfun3/' ~/.config/x11/Xresources
		xrdb ~/.config/x11/Xresources
	elif [ "$unix_now" -ge "$unix_sunset" ] || [ "$unix_now" -le "$unix_sunrise" ]; then
		sed -i '5s/.*/gtk-cursor-theme-name=pixelfun3-eclipse/' ~/.config/gtk-3.0/settings.ini
		sed -i '5s/.*/Inherits=pixelfun3-eclipse/' ~/.local/share/icons/default/index.theme
		sed -1 '1s/.*/Xcursor.theme: pixelfun3-eclipse/' ~/.config/x11/Xresources
		xrdb ~/.config/x11/Xresources
	else
		echo "No switch needed."
	fi
}

wallpaper() {
	time_vars
	if [ "$unix_now" -ge "$unix_sunrise" ] && [ "$unix_now" -le "$unix_sunset" ]; then
		xwallpaper --center ~/Pictures/gruvgenome-light.png
	elif [ "$unix_now" -ge "$unix_sunset" ] || [ "$unix_now" -le "$unix_sunrise" ]; then
		xwallpaper --center ~/Pictures/gruvgenome-dark.png
	else
		echo "No switch needed."
	fi
}
main() {
	time_vars
	# First time run is simple... I think?
	if [ ! -f /tmp/theme_state ]; then
		if [ "$unix_now" -ge "$unix_sunrise" ] && [ "$unix_now" -le "$unix_sunset" ]; then
			dtl
			reload
		else
			ltd
			reload
		fi
		exit
	fi

	# Only change state if needed
	state=$(cat /tmp/theme_state)
	if [ "$unix_now" -ge "$unix_sunrise" ] && [ "$unix_now" -le "$unix_sunset" ] && [ "$state" = "dark" ]; then
		dtl
		reload
	elif [ "$unix_now" -ge "$unix_sunset" ] || [ "$unix_now" -le "$unix_sunrise" ] && [ "$state" = "light" ]; then
		ltd
		reload
	else
		echo "No switch needed."
	fi
}

while test $# -gt 0; do
	case "$1" in
	--cron | -c)
		cron_setup
		shift
		;;
	--switch | -s)
		main
		shift
		;;
	--light | -l)
		dtl
		xwallpaper --center ~/Pictures/gruvgenome-light.png
		reload
		shift
		;;
	--dark | -d)
		ltd
		xwallpaper --center ~/Pictures/gruvgenome-dark.png
		reload
		shift
		;;
	--mouse | -m)
		mouse
		shift
		;;
	--wallpaper | -w)
		wallpaper
		shift
		;;
	*)
		break
		;;
	esac
done
