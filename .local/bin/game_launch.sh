#!/bin/sh

# Simple wrapper script to launch steam games

# Most of these games use an old version of libs, so I keep them seperately
# in the steam folder
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/barbaross/.steam/aux_libs

case "$1" in
bgee)
	cd ~/Public/Games/Steam/Baldurs_Gate/
	./BaldursGate
	;;
bge2)
	cd ~/Public/Games/Steam/Baldurs_Gate_II/
	./BaldursGateII
	;;
iwdd)
	cd ~/Public/Games/Steam/Icewind_Dale/
	./IcewindDale
	;;
pstm)
	cd ~/Public/Games/Steam/Planescape_Torment/
	./Torment64
	;;
nvwn)
	cd ~/Public/Games/Steam/Neverwinter_Nights/bin/linux-x86/
	./nwmain-linux
	;;
*)
	echo "usage: $(basename $0) <game>"
	echo "games: "
	echo "    bgee: Baldur's Gate"
	echo "    bge2: Baldur's Gate II"
	echo "    iwdd: Icewind Dale"
	echo "    pstm: Planescape Torment"
	echo "    nvwn: Neverwinter Nights"
	;;
esac
