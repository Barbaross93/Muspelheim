#!/usr/bin/env bash

modifier=$(grep "hc keybind" ~/.config/herbstluftwm/bindings.sh | awk '{$1=$1};1' | sed '/^#/d' | cut -d' ' -f3- | sed 's/Mod4/Super/g' | sed 's/Mod1/Alt/g' | awk '{print $1}' | tr -d '"')
chainmods=$(grep "hc keybind" ~/.config/herbstluftwm/keychain.sh | awk '{$1=$1};1' | sed '/^#/d' | cut -d' ' -f3- | sed 's/Mod4/Super/g' | sed 's/Mod1/Alt/g' | awk '{print $1}' | tr -d '"')
finmods="$modifier
$chainmods"

description=$(grep 'hc keybind' ~/.config/herbstluftwm/bindings.sh | awk '{$1=$1};1' | sed '/^#/d' | sed 's/^[^#]*#//g' | sed "s/.*hc.*//")
chaindesc=$(grep 'keybind Escape' ~/.config/herbstluftwm/keychain.sh | awk '{$1=$1};1' | sed '/^#/d' | sed 's/^[^#]*#//g' | sed "s/.*hc.*//")
findesc="$description
$chaindesc"

final=$(paste -d '\t' <(echo "$finmods") <(echo "$findesc") | column -s $'\t' -t)

echo "$final" | dmenu -i -p "Help:"
