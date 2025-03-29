#!/bin/bash

# Power menu options with icons
options=" Lock
 Logout
 Suspend
 Reboot
 Shutdown"

chosen=$(echo -e "$options" | rofi -dmenu -p "Power Menu" -theme-str 'window {width: 250px;}')

case $chosen in
    *Lock)
        # Use i3lock or your preferred lock method
        i3lock -c 000000 || loginctl lock-session
        ;;
    *Logout)
        # Adjust based on your window manager (i3, bspwm, etc.)
        i3-msg exit || bspc quit || xfce4-session-logout
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Shutdown)
        systemctl poweroff
        ;;
esac


