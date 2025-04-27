#!/bin/bash
# Retrieve IVPN status from CLI

data=()
mapfile data < <(ivpn status)

case $(echo "${data[0]##*:}" | xargs) in
    "CONNECTED")
        ivpn disconnect
        ;;
    "DISCONNECTED")
        ivpn connect -fastest -protocol wg -ipv6tunnel
        ;;
    *)
        ;;
esac

