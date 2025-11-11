#!/bin/bash

declare -a config_dirs=(
  ".config/hypr"
  ".config/waybar"
  ".config/nvim"
  ".config/wpaperd"
  ".config/rofi"
  ".local/share/rofi"
)

if [[ "$1" == "pull" ]] then
    for dir in "${config_dirs[@]}"; do
        rsync -Rav --delete "$HOME/./$dir" .
    done
elif [[ "$1" == "push" ]] then
    for dir in "${config_dirs[@]}"; do
        rsync -Rav "./$dir" "$HOME/"
    done
else
    echo "USAGE: ./cmgr.sh <pull | push>"
fi
