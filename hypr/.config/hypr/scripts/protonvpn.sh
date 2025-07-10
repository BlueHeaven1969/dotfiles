#!/bin/bash
# Retrieve IVPN status from CLI

cachefile=~/.cache/nm-conns
server=''
tag=''

nmcli connection show --active > $cachefile
if grep -qF Proton $cachefile; then
    tag='󰦝'
    if grep -qF ProtonVPN $cachefile; then
        server=$(grep -Po "[A-Z]{2}#[0-9]." $cachefile)
    else
        server=$(grep -Po "[A-Z]{2}-[0-9]." $cachefile)
    fi
    echo -e "{\"text\":\""$tag $server"\"}"
else
    echo -e "{\"text\":\"\"}"
fi


