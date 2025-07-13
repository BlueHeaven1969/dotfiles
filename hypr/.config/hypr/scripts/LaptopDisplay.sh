#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Monitor backlights (if supported) using brightnessctl

# Notify
notify_user() {
	notify-send -e -u low "Laptop Display" "$state"
}

# Execute accordingly
case "$1" in
	"--enable")
        hyprctl keyword monitor "eDP-1, preferred, auto, 1.5"
        state="Enabled"
		notify_user
		;;
	"--disable")
        hyprctl keyword monitor "eDP-1, disable"
        state="Disabled"
		notify_user
		;;
	*)
        state="Error"
		notify_user
		;;
esac
