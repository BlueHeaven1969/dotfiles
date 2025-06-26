#!/bin/bash
# Retrieve IVPN status from CLI

protonfile=~/.cache/Proton/VPN/connection/connection_persistence.json
if ip add show | grep -qF pvpn; then
    tag='󰦝'
else
    tag=''
fi

server=''
if [ -f $protonfile ]; then
    server=$(jq -r '.server.server_name' $protonfile)
fi


echo -e "{\"text\":\""$tag $server"\"}"

