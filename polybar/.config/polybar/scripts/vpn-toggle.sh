#!/bin/bash
export PATH="/usr/bin:$PATH"

# Check if any WireGuard interface is active
active_vpn=$(sudo wg show interfaces | head -n1)

if [[ -n "$active_vpn" ]]; then
    # VPN is on - disconnect it
    sudo systemctl stop "wg-quick@${active_vpn}.service"
    notify-send "VPN" "Disconnected from $active_vpn"
else
    # VPN is off - connect to a random Denver VPN
    denver_vpn=$(sudo ls /etc/wireguard 2>/dev/null | grep -E '^us-den-' | sed 's/\.conf$//' | shuf -n1)
    if [[ -n "$denver_vpn" ]]; then
        sudo systemctl start "wg-quick@${denver_vpn}.service"
        notify-send "VPN" "Connected to $denver_vpn"
    else
        notify-send "VPN" "No Denver VPN found"
    fi
fi
