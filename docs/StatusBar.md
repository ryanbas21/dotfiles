# Status Bar

## Polybar

- **Config**: `polybar/.config/polybar/config.ini`
- **Launch Script**: `polybar/.config/polybar/launch_polybar.sh` (called by both
  i3 and Xmonad startup hooks).
- **Visuals**:
  - Background/foreground sourced from Xresources with fallbacks.
  - Rounded corners (`radius = 10`), 24pt height, and a 98.8% width bar that
    leaves slight monitor margins.
  - Multi-font stack (Hack, FiraCode, JetBrains Mono) for icon coverage.
  - 3pt border and separators using the shared color palette.
- **Modules (Left → Center → Right)**:
  - `date`: primary clock.
  - `battery`: multi-stage icons with charging animation and warnings at 5%.
  - `xworkspaces`: active workspace highlight with color inversion.
  - `pulseaudio`: volume percentage with mute indicator.
  - `filesystem`: monitors `/`, `/home`, and `/docker`.
  - `network`: wireless status with ramp icons and SSID label.
- `wifi_menu`: script module that renders `󰤨`; hook it to Rofi or network
  helpers as needed.
- `tray`: system tray offset with spacing to accommodate applets.
- `power_menu`: custom script showing `⏻`; left click opens the Rofi power menu
  (`~/.config/rofi/powermenu/type-5/powermenu.sh`), right click opens the legacy
  Wi-Fi menu script (`~/.config/rofi.alopes/Rofi_Wifi_Menu.sh`).
- **Interactions**:
  - Network module hooks into `~/.local/bin/wifi-toggle` on left click and
    relaunches `nm-applet` on right click.
  - Polybar IPC is enabled (`enable-ipc = true`) to support scripted reloads.
- **i3/Xmonad Integration**: Launch binding `Mod+P` maps to the same
  `launch_polybar.sh` script in both window managers, so reloading the bar is
  consistent.
