#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | wofi -i --dmenu --style ~/.config/wofi/src/mocha/style.css| awk '{print tolower($2)}' )

case $op in
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
		hyprlock
                ;;
        logout)
                hyprctl dispatch exit
                ;;
esac
