#!/bin/bash
# Retrieve IVPN status from CLI

data=()
mapfile data < <(ivpn status)

case $(echo "${data[0]##*:}" | xargs) in
    "CONNECTED")
        server=$(echo "${data[1]}" | grep -Po "(?<=\[).*?(?=\.)")
        tag='󰦝'
        ;;
    "DISCONNECTED")
        server=''
        tag=''
        ;;
    *)
        server=''
        tag=''
        ;;
esac

tip=''
for i in "${data[@]}"; do
    tip=$(echo "${tip}$i\r")
done

echo -e "{\"text\":\""$tag ${server^^}"\", \"tooltip\":\""${tip}"\"}"

