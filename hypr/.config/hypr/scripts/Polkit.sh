#!/bin/bash

sleep 1
killall xdg-desktop-portal-hyprland
#killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
sleep 1
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal &
/usr/libexec/pam_kwallet_init --no-startup-id &
/usr/libexec/polkit-kde-authentication-agent-1 &
