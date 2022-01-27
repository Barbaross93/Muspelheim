#!/bin/sh

greenclip print | sed '/^$/d' | dmenu -p Clipboard: | xargs -r -d'\n' -I '{}' greenclip print '{}'
