#!/bin/bash

declare -a config_dirs=(
    ".zshrc"
    ".config/hypr"
    ".config/waybar"
    ".config/nvim"
    ".config/wpaperd"
    ".config/rofi"
    ".config/matugen"
    ".local/share/rofi"
)

fn_pull() {
    for dir in "${config_dirs[@]}"; do
        rsync -Rav --delete "$HOME/./$dir" .
    done
}

fn_push() {
    for dir in "${config_dirs[@]}"; do
        rsync -Rav "./$dir" "$HOME/"
    done
}

if [[ "$1" == "pull" ]]; then
    fn_pull
elif [[ "$1" == "push" ]]; then
    fn_push
else
    echo "USAGE: ./cmgr.sh <pull | push | patch | apply>"
fi
