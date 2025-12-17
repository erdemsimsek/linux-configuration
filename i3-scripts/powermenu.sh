#!/bin/bash
# Simple Rofi Power Menu

# Options
shutdown="⏻ Shutdown"
reboot="↺ Reboot"
lock="🔒 Lock"
logout="🚪 Logout"

# Variable passed to rofi
options="$lock\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")"

case $chosen in
    $lock)
        # Use your new betterlockscreen or i3lock
        betterlockscreen -l dim
        ;;
    $logout)
        i3-msg exit
        ;;
    $reboot)
        systemctl reboot
        ;;
    $shutdown)
        systemctl poweroff
        ;;
esac
