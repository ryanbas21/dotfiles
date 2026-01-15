
#!/bin/bash

# Get list of relays
selected=$(mullvad relay list | grep -E "^\s+\w+-\w+-wg-\d+" | awk '{print $1}' | rofi -dmenu -i -p "Select Server" -theme-str 'window {width: 400px;}')

if [[ -n "$selected" ]]; then
    mullvad relay set location "$selected"
    mullvad connect
    notify-send "VPN" "Connected to $selected"
fi
