#!/bin/bash

declare -a config_dirs=(
    ".zshrc"
    ".config/hypr"
    ".config/waybar"
    ".config/nvim"
    ".config/wpaperd"
    ".config/rofi"
    ".config/matugen"
    ".config/kitty"
    ".config/fontconfig"
    ".local/share/rofi"
)

declare -a sudo_config=(
    "/etc/ly/config.ini"
)

fn_pull() {
    for dir in "${config_dirs[@]}"; do
        printf "\nPulling from $dir\n"
        rsync -Rav --delete "$HOME/./$dir" .
    done
    # We dont need sudo as the system wide config files stored are not sensible and have the other read perm
    for dir in "${sudo_config[@]}"; do
        printf "\nPulling from $dir\n"
        rsync -Rav --delete "$dir" system
    done
}

fn_push() {
    for dir in "${config_dirs[@]}"; do
        printf "\nPushing to $dir\n"
        rsync -Rav "./$dir" "$HOME/"
    done
    if [[ $EUID -ne 0 ]]; then
        printf "\nScript not run as root, ignoring system-wide config files\n"
    else
        for dir in "${config_dirs[@]}"; do
            printf "\nPushing to $dir\n"
            rsync -Rav "system$dir" "/"
        done
    fi
}

if [[ "$1" == "pull" ]]; then
    fn_pull
elif [[ "$1" == "push" ]]; then
    fn_push
else
    echo "USAGE: ./cmgr.sh <pull | push | patch | apply>"
fi
