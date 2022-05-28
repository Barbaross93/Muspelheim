#!/bin/sh

# Simple wrapper script to launch games

# Old libs needed by some games
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/barbaross/Public/Games/libs

# Needed for sounds in doom
export SDL_SOUNDFONTS=/usr/share/soundfonts/FluidR3_GM.sf2

case "$1" in
bgee)
	cd ~/Public/Games/Baldurs_Gate/ || exit
	./BaldursGate >/dev/null 2>&1
	;;
bge2)
	cd ~/Public/Games/Baldurs_Gate_II/ || exit
	./BaldursGateII >/dev/null 2>&1
	;;
iwdd)
	cd ~/Public/Games/Icewind_Dale/ || exit
	./IcewindDale >/dev/null 2>&1
	;;
pstm)
	cd ~/Public/Games/Planescape_Torment/ || exit
	./Torment64 >/dev/null 2>&1
	;;
nvwn)
	cd ~/Public/Games/Neverwinter_Nights/bin/linux-x86/ || exit
	./nwmain-linux >/dev/null 2>&1
	;;
doom)
	doomretro -iwad ~/Public/Games/Doom/DOOM.WAD >/dev/null
	;;
dom2)
	doomretro -iwad ~/Public/Games/Doom/DOOM2.WAD >/dev/null
	;;
*)
	echo "usage: $(basename $0) <game>"
	echo "games: "
	echo "    bgee: Baldur's Gate"
	echo "    bge2: Baldur's Gate II"
	echo "    iwdd: Icewind Dale"
	echo "    pstm: Planescape Torment"
	echo "    nvwn: Neverwinter Nights"
	echo "    doom: Doom"
	echo "    dom2: Doom 2"
	;;
esac
