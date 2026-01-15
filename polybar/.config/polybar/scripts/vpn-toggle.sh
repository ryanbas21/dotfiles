#!/bin/bash

if mullvad status | grep -q "Connected"; then
    mullvad disconnect
    notify-send "VPN" "Disconnected"
else
    mullvad connect
    notify-send "VPN" "Connected"
fi
