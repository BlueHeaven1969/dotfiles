#!/bin/bash
# Retrieve IVPN status from CLI

if ip add show | grep -qF pvpn; then
    tag='󰦝'
else
    tag=''
fi

echo -e "{\"text\":\""$tag"\"}"

