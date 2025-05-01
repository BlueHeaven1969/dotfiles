#!/bin/bash
# Retrieve IVPN status from CLI

data=()
mapfile data < <(ivpn status)

case $(echo "${data[0]##*:}" | xargs) in
    "CONNECTED")
        ivpn disconnect
        ivpn firewall -off
        ;;
    "DISCONNECTED")
        ivpn connect -fastest -protocol wg -ipv6tunnel
        ivpn firewall -on
        ;;
    *)
        ;;
esac

