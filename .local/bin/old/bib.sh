#!/bin/sh

# Keep syncthing database updated when adding things in cobib
COBIB_DATABASE="$HOME/.local/share/cobib/literature.yaml"
BIB_DATABASE="$HOME/Documents/School/Bibliography/Library/Library.bib"

while inotifywait -q -q -e close_write "$COBIB_DATABASE"; do
	cobib export --bibtex ~/Documents/School/Bibliography/Library/Library.bib
	# Unfortunately, to get citations to work in vim, I need to "fix"
	# the bib file with pybtex and then replace the old bib file
	#pybtex-convert ~/Documents/School/Bibliography/Library/Library.bib Library2.bib
	#mv ~/Documents/School/Bibliography/Library/Library2.bib ~/Documents/School/Bibliography/Library/Library.bib
done &

cobib

kill -- -$$
