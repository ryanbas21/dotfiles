#!/bin/bash

# Bluetooth device management script
bluetooth_toggle() {
    if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
        rfkill unblock bluetooth
        bluetoothctl power on
    else
        bluetoothctl power off
        rfkill block bluetooth
    fi
}

bluetooth_scan() {
    # Scan for devices and format for rofi
    bluetoothctl scan on &
    sleep 5
    bluetoothctl devices | awk '{print $2 " " $3" " $4}'
}

bluetooth_connect() {
    # Connect to selected device
    device=$(bluetoothctl devices | rofi -dmenu -p "Select Device")
    if [[ -n "$device" ]]; then
        mac=$(echo "$device" | awk '{print $1}')
        bluetoothctl connect "$mac"
    fi
}

bluetooth_disconnect() {
    # Disconnect from connected devices
    device=$(bluetoothctl connected-devices | rofi -dmenu -p "Disconnect Device")
    if [[ -n "$device" ]]; then
        mac=$(echo "$device" | awk '{print $1}')
        bluetoothctl disconnect "$mac"
    fi
}

# Rofi menu options
options=" Toggle Bluetooth
 Scan Devices
 Connect Device
 Disconnect Device"

chosen=$(echo -e "$options" | rofi -dmenu -p "Bluetooth Menu")

case "$chosen" in
    *"Toggle Bluetooth")
        bluetooth_toggle
        ;;
    *"Scan Devices")
        bluetooth_scan
        ;;
    *"Connect Device")
        bluetooth_connect
        ;;
    *"Disconnect Device")
        bluetooth_disconnect
        ;;
esac
