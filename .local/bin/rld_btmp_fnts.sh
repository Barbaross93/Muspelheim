#!/bin/sh

BTMP_FNT_DIR=~/.local/share/fonts/misc/

echo "Recreating X11 font index files..."
mkfontscale $BTMP_FNT_DIR
mkfontdir $BTMP_FNT_DIR
echo "Done!"

echo ""

echo "Refreshing X11 bitmap font database..."
xset -fp $BTMP_FNT_DIR
xset +fp $BTMP_FNT_DIR
echo "Done!"

# Want to know its XLFD name?
if [ -n "$*" ]; then
	echo""
	echo "XLFD Name(s:"
	xlsfonts | grep "$*"
fi
