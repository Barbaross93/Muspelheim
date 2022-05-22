#!/usr/bin/env bash

hc() {
  herbstclient "$@"
}

### Key/mouse bindings separate in order to 'lazy load' them

## Key bindings
# remove all existing keybindings
hc keyunbind --all

# Basics
hc keybind Mod4-Return or ',' and '.' compare tags.focus.frame_count = 1 '.' compare tags.focus.curframe_wcount = 0 '.' spawn alacritty ',' and '_' compare tags.focus.curframe_wcount = 0 '_' spawn alacritty ',' chain '-' split auto '-' cycle_frame '-' spawn alacritty #bsp-like spawning of terminal

hc keybind Mod4-Shift-Return spawn alacritty                                    #Spawn terminal
hc keybind Mod4-e spawn launch                                                  #Launcher
hc keybind Mod4-Shift-e spawn power                                             #Power menu
hc keybind Mod4-d spawn hlscrthpd.sh                                            #Dropdown terminal
hc keybind Mod4-space spawn task.sh                                             #Tasklist
hc keybind Mod4-a spawn ~/.config/herbstluftwm/scripts/key_help.sh              #Keybinding help
hc keybind Mod4-Shift-a spawn alacritty -e vim ~/.config/herbstluftwm/autostart #Edit hlwm config

# Window info/wm ctrls
hc keybind Mod4-w spawn rofi -show window                               #Switch windows
hc keybind Mod4-Control-w spawn ~/.config/herbstluftwm/toggle_titles.sh #Toggle window titles
hc keybind Mod4-Shift-r reload                                          #Reload hlwm

# Toggles
hc keybind Mod4-b spawn togglebar.sh            #Toggle bar
hc keybind Mod4-Shift-p spawn togglepicom       #Toggle compositor
hc keybind XF86Launch1 spawn toggle_touchpad.sh #Toggle touchpad
hc keybind XF86Display spawn caffeine.sh        #Toggle caffeine
hc keybind XF86Tools spawn kb_variant.sh        #Toggles between qwerty and colemak
#hc keybind Mod4-Shift-n spawn toggledunst     #Toggle notifications
#hc keybind XF86Tools spawn toggle_redshift.sh #Toggle redshift

# Utilities
hc keybind Mod4-u spawn unmount.sh                       #Unmount drives
hc keybind XF86Favorites spawn prtscr                    #Print Screen
hc keybind Mod4-XF86Favorites spawn prtregion            #Print region
hc keybind Mod4-x spawn clipmenu -i -p 'Clipboard:' -l 0 #Clipboard manager
hc keybind Mod4-Shift-c spawn colorpicker.sh             #Colorpicker
hc keybind Mod4-Shift-z spawn mag.sh                     #Zoom
hc keybind Mod4-Shift-m spawn emote                      #Kaomoji selector
hc keybind Mod4-z spawn mwarp.sh                         #Warp mouse
hc keybind Mod4-n spawn noise                            #Toggle brown noise
hc keybind Mod4-Shift-w spawn wttr                       #Current Weather Information

# Notification controls
hc keybind Control-grave spawn notif_hist.sh -q #Query last notification
hc keybind Control-space spawn notif_hist.sh -c #Close all notification history

# Volume/Brightness keys
hc keybind XF86MonBrightnessUp spawn bright up     #Increase brightness
hc keybind XF86MonBrightnessDown spawn bright down #Decrease brightness

hc keybind XF86AudioRaiseVolume spawn vol alsa up           #Increase Volume
hc keybind XF86AudioLowerVolume spawn vol alsa down         #Decrease volume
hc keybind XF86AudioMute spawn vol alsa mute                #Mute audio
hc keybind Mod4-XF86AudioLowerVolume spawn vol alsamic down #Decrease mic volume
hc keybind XF86AudioMicMute spawn vol alsamic mute          #mute mic

# Player controls
hc keybind Mod4-Control-Mod1-Left spawn playerctl previous #Previous audio
hc keybind Mod4-Control-Mod1-Right spawn playerctl next    #Next audio
hc keybind Mod4-Control-Mod1-Up spawn playerctl play-pause #Toggle play/pause audio
hc keybind Mod4-Control-Mod1-Down spawn playerctl stop     #Stop audio
hc keybind Mod4-Control-Mod1-h spawn playerctl previous    #Previous audio
hc keybind Mod4-Control-Mod1-l spawn playerctl next        #Next audio
hc keybind Mod4-Control-Mod1-k spawn playerctl play-pause  #Toggle play/pause audio
hc keybind Mod4-Control-Mod1-j spawn playerctl stop        #Stop audio

# Window/frame controls
hc keybind Mod4-q close                                                    #Close focused window
hc keybind Mod4-Shift-q close_and_remove                                   #Close window and frame if last window
hc keybind Mod4-m spawn ~/.config/herbstluftwm/scripts/maximize.sh         #Alternate tiled and monocle layout
hc keybind Mod4-i jumpto urgent                                            #Jump to urgent window
hc keybind Mod4-Shift-s spawn ~/.config/herbstluftwm//scripts/savestate.sh #Save current session
hc keybind Mod4-Tab cycle                                                  #Circulate focus on windows in frame
hc keybind Mod4-Shift-Tab cycle -1                                         #Circulate focus on windows in frame in reverse
hc keybind Mod4-grave cycle_monitor                                        #Circulate monitor focus

# focusing clients
hc keybind Mod4-Left focus left   #Focus left
hc keybind Mod4-Down focus down   #Focus down
hc keybind Mod4-Up focus up       #focus up
hc keybind Mod4-Right focus right #Focus right
hc keybind Mod4-h focus left      #Focus left
hc keybind Mod4-j focus down      #Focus down
hc keybind Mod4-k focus up        #focus up
hc keybind Mod4-l focus right     #Focus right

# moving clients
hc keybind Mod4-Shift-Left shift left   #Move window left
hc keybind Mod4-Shift-Down shift down   #Move window down
hc keybind Mod4-Shift-Up shift up       #Move window up
hc keybind Mod4-Shift-Right shift right #Move window right
hc keybind Mod4-Shift-h shift left      #Move window left
hc keybind Mod4-Shift-j shift down      #Move window down
hc keybind Mod4-Shift-k shift up        #Move window up
hc keybind Mod4-Shift-l shift right     #Move window right

# Cycle focus through tags
hc keybind Mod4-period spawn ~/.config/herbstluftwm/scripts/tag_switch.sh next #Switch to next non-empty tag

hc keybind Mod4-comma spawn ~/.config/herbstluftwm/scripts/tag_switch.sh prev #Switch to prev non-empty tag

# Create frames
frac="0.5"
hc keybind Mod4-Control-Left split left $frac   #Create frame to left
hc keybind Mod4-Control-Right split right $frac #Create frame to right
hc keybind Mod4-Control-Up split top $frac      #Create frame up
hc keybind Mod4-Control-Down split bottom $frac #Create frame down
hc keybind Mod4-Control-h split left $frac      #Create frame to left
hc keybind Mod4-Control-j split right $frac     #Create frame to right
hc keybind Mod4-Control-k split top $frac       #Create frame up
hc keybind Mod4-Control-l split bottom $frac    #Create frame down
hc keybind Mod4-Control-space split explode     #Explode current frame

# resizing frames
resizestep=0.02
hc keybind Mod4-Mod1-Left resize left +$resizestep   #Resize frame leftwards
hc keybind Mod4-Mod1-Down resize down +$resizestep   #Resize frames downwards
hc keybind Mod4-Mod1-Up resize up +$resizestep       #Resize frame upwards
hc keybind Mod4-Mod1-Right resize right +$resizestep #Resize frame rightwards
hc keybind Mod4-Mod1-h resize left +$resizestep      #Resize frame leftwards
hc keybind Mod4-Mod1-j resize down +$resizestep      #Resize frames downwards
hc keybind Mod4-Mod1-k resize up +$resizestep        #Resize frame upwards
hc keybind Mod4-Mod1-l resize right +$resizestep     #Resize frame rightwards

# Misc. frame ctrls
hc keybind Mod4-f set always_show_frame toggle #Toggle frame visibility
hc keybind Mod4-Control-r rotate               #Rotate frame layout by 90 degrees

# Adjust gaps
hc keybind Mod4-minus spawn ~/.config/herbstluftwm/scripts/gap_adjust.sh -win       #Minus window gap
hc keybind Mod4-equal spawn ~/.config/herbstluftwm/scripts/gap_adjust.sh +win       #Plus window gap
hc keybind Mod4-Shift-minus spawn ~/.config/herbstluftwm/scripts/gap_adjust.sh -frm #Minus frame gap
hc keybind Mod4-Shift-equal spawn ~/.config/herbstluftwm/scripts/gap_adjust.sh +frm #Plus frame gap
hc keybind Mod4-BackSpace spawn ~/.config/herbstluftwm/scripts/gap_adjust.sh        #Reset gaps

# swapping frames (actually just transferring windows across frames)
hc keybind Mod4-Shift-Ctrl-Right substitute OLDWIN clients.focus.winid chain , focus -e right , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN left #Swap frames to the right
hc keybind Mod4-Shift-Ctrl-Left substitute OLDWIN clients.focus.winid chain , focus -e left , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN right  #Swap frames to the left
hc keybind Mod4-Shift-Ctrl-Up substitute OLDWIN clients.focus.winid chain , focus -e up , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN down       #Swap frames to the top
hc keybind Mod4-Shift-Ctrl-Down substitute OLDWIN clients.focus.winid chain , focus -e down , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN up     #Swap frames tothe bottom

hc keybind Mod4-Shift-Ctrl-h substitute OLDWIN clients.focus.winid chain , focus -e right , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN left #Swap frames to the right
hc keybind Mod4-Shift-Ctrl-l substitute OLDWIN clients.focus.winid chain , focus -e left , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN right #Swap frames to the left
hc keybind Mod4-Shift-Ctrl-k substitute OLDWIN clients.focus.winid chain , focus -e up , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN down    #Swap frames to the top
hc keybind Mod4-Shift-Ctrl-j substitute OLDWIN clients.focus.winid chain , focus -e down , substitute NEWWIN clients.focus.winid spawn ~/.config/herbstluftwm/scripts/swapwins.sh OLDWIN NEWWIN up    #Swap frames tothe bottom

## Mouse bindings
# remove any existing mouse bindings
hc mouseunbind --all
hc mousebind Mod4-Button1 move
hc mousebind Mod4-Button2 zoom
hc mousebind Mod4-Button3 resize
