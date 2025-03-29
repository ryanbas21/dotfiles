#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT1/capacity)
status=$(cat /sys/class/power_supply/BAT1/status)

case $status in
    "Charging")
        echo "CHG ${capacity}%"
        ;;
    "Discharging")
        echo "BAT ${capacity}%"
        ;;
    "Full")
        echo "FULL ${capacity}%"
        ;;
    *)
        echo "UNK ${capacity}%"
        ;;
esac
