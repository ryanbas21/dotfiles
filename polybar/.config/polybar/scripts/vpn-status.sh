#!/bin/bash
export PATH="/usr/bin:$PATH"

if sudo wg show interfaces | grep -q .; then
    echo "%{F#a6e3a1}󰌾 VPN%{F-}"
else
    echo "%{F#f38ba8}󰦞 VPN%{F-}"
fi
