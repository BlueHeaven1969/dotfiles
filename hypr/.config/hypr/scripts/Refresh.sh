#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing ags, waybar, rofi, swaync, wallust

SCRIPTSDIR=$HOME/.config/hypr/scripts

# Kill already running processes
_ps=(waybar rofi swaync ags-old)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# added since wallust sometimes not applying
killall -SIGUSR2 waybar 
killall -SIGUSR2 swaync

# quit ags & relaunch ags
ags-old -q && ags-old &

# some process to kill
for pid in $(pidof waybar rofi swaync ags-old swaybg); do
    kill -SIGUSR1 "$pid"
done

#Restart waybar
sleep 1
waybar &

# relaunch swaync
sleep 0.5
swaync > /dev/null 2>&1 &

# Relaunching rainbow borders if the script exists
sleep 1

exit 0
