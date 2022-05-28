#!/bin/sh

grim -g "$(slurp -b 00000000 -c dfdfaf)" /tmp/zoom.png
convert /tmp/zoom.png -resize 800% -filter Point /tmp/zoom.png && imv /tmp/zoom.png && rm /tmp/zoom.png
#import -window root -crop $(slop --color=0.874,0.874,0.686 -b 2) -resize 800% -filter Point /tmp/zoom.png && nsxiv -b /tmp/zoom.png && rm /tmp/zoom.png
#xmag -source $(hacksaw -c "#dfdfaf")
