#!/usr/bin/env bash

ACTION="$(echo "Power off
Reboot
Logout
Lock
Suspend
Hibernate" | rofi -dmenu)"

case $ACTION in
    "Power off")
        hyprshutdown -t "Shutting Down..." -p "systemctl poweroff"
        ;;
    "Reboot")
        hyprshutdown -t "Rebooting..." -p reboot
        ;;
    "Logout")
        hyprshutdown -t "Logging out..."
        ;;
    "Lock")
        hyprlock
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Hibernate")
        systemctl hibernate
        ;;
    *)
        ;;
esac
