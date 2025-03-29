#!/bin/bash

# NetworkManager Rofi Script for WiFi Management

wifi_connect() {
    # Scan and list available WiFi networks
    networks=$(nmcli -f SSID,SECURITY,BARS device wifi list | tail -n +2)

    # Select network using rofi
    selected_network=$(echo "$networks" | rofi -dmenu -p "Select WiFi Network" \
        -theme-str 'window {width: 500px;}' \
        -columns 3)

    if [[ -n "$selected_network" ]]; then
        # Extract SSID (first column)
        ssid=$(echo "$selected_network" | awk '{print $1}')

        # Prompt for password if network is secured
        if echo "$selected_network" | grep -q "WPA\|WEP"; then
            password=$(rofi -dmenu -p "Enter password for $ssid" -password)
            nmcli dev wifi connect "$ssid" password "$password"
        else
            # Connect to open networks
            nmcli dev wifi connect "$ssid"
        fi
    fi
}

wifi_disconnect() {
    # List connected networks
    connected_networks=$(nmcli -f NAME connection show --active)

    # Select network to disconnect
    selected_network=$(echo "$connected_networks" | rofi -dmenu -p "Disconnect Network")

    if [[ -n "$selected_network" ]]; then
        nmcli connection down "$selected_network"
    fi
}

toggle_wifi() {
    # Toggle WiFi on/off
    if nmcli radio wifi | grep -q "enabled"; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
}

# Rofi menu options
options=" Connect to WiFi
 Disconnect Network
 Toggle WiFi
 Show Connection Status"

chosen=$(echo -e "$options" | rofi -dmenu -p "Network Manager")

case "$chosen" in
    *"Connect to WiFi")
        wifi_connect
        ;;
    *"Disconnect Network")
        wifi_disconnect
        ;;
    *"Toggle WiFi")
        toggle_wifi
        ;;
    *"Show Connection Status")
        status=$(nmcli connection show --active)
        echo "$status" | rofi -dmenu -p "Active Connections" -theme-str 'window
