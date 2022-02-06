#!/bin/sh

import -window root -crop $(slop --color=0.874,0.874,0.686 -b 2) -resize 800% -filter Point /tmp/zoom.png && nsxiv -b /tmp/zoom.png && rm /tmp/zoom.png
#xmag -source $(hacksaw -c "#dfdfaf")
