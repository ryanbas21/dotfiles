#!/bin/bash
export PATH="/usr/bin:$PATH"

# Get current active VPN (if any)
active_vpn=$(sudo wg show interfaces | head -n1)

# Get all WireGuard configs from /etc/wireguard/
vpn_list=$(sudo ls /etc/wireguard 2>/dev/null | grep '\.conf$' | sed 's/\.conf$//' | sort)

if [[ -z "$vpn_list" ]]; then
    notify-send "VPN" "No WireGuard configs found"
    exit 1
fi

# Add disconnect option if VPN is active
if [[ -n "$active_vpn" ]]; then
    vpn_list="󰦞 Disconnect ($active_vpn)"$'\n'"$vpn_list"
fi

# Show rofi menu
selected=$(echo "$vpn_list" | rofi -dmenu -i -p "Select VPN" -theme-str 'window {width: 400px;}')

if [[ -z "$selected" ]]; then
    exit 0
fi

# Handle disconnect option
if [[ "$selected" == "󰦞 Disconnect"* ]]; then
    sudo systemctl stop "wg-quick@${active_vpn}.service"
    notify-send "VPN" "Disconnected from $active_vpn"
else
    # Disconnect current VPN first if active
    if [[ -n "$active_vpn" ]]; then
        sudo systemctl stop "wg-quick@${active_vpn}.service" 2>/dev/null
    fi
    # Connect to selected VPN
    if sudo systemctl start "wg-quick@${selected}.service"; then
        notify-send "VPN" "Connected to $selected"
    else
        notify-send "VPN" "Failed to connect to $selected"
    fi
fi
