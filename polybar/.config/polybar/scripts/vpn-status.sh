#!/bin/bash

if mullvad status | grep -q "Connected"; then
    echo "%{F#a6e3a1}󰌾 VPN%{F-}"
else
    echo "%{F#f38ba8}󰦞 VPN%{F-}"
fi
