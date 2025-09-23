#!/usr/bin/env bash

ACTION="$(echo "Power off
Reboot
Logout
Lock
Suspend
Hibernate" | walker -nd)"

case $ACTION in
    "Power off")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Logout")
        hyprctl dispatch exit 0
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
