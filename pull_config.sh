#!/bin/bash

declare -a config_dirs=(
  ".config/hypr"
  ".config/waybar"
  ".config/nvim"
  ".config/wpaperd"
  ".config/rofi"
  ".local/share/rofi"
)

for dir in "${config_dirs[@]}"; do
    rsync -Rav --delete "$HOME/./$dir" .
done
