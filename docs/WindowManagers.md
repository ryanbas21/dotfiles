# Window Managers

## i3

- **Config**: `i3/.config/i3/config`
- **Mod Key**: `Mod1` (left Alt) keeps shortcuts distinct from terminal control.
- **Gaps**: Inner gap of 8px and outer gap of 30px for a clean tiling aesthetic.
- **Autostart**:
  - `picom` compositor
  - `feh` background at `~/Pictures/i3-bg.png`
  - `dunst` notifications
  - `nm-applet` tray networking
  - Polybar via `~/.config/polybar/launch_polybar.sh`
  - `flameshot` screenshot tool
  - `dex` XDG autostart excluding KDE desktop items
- **Workspace Model**: Workspaces `1`–`5` anchored to `eDP-1`, `6`–`10` to
  `HDMI-1`, providing a stable dual-monitor layout. `Mod+Ctrl+Arrow` moves an
  entire workspace between monitors.
- **Key Highlights**:
  - `Mod+Return` launches Ghostty.
  - `Mod+Space` runs the themed Rofi launcher
    (`~/.config/rofi/launchers/type-1/launcher.sh`).
  - Media keys and `brightnessctl` bindings adjust system volume/brightness.
  - `Mod+Shift+s` runs `~/.config/i3/setup_layout.sh` to rebuild window layout.
  - Flameshot bindings cover region (`F12`) and full-screen capture
    (`Shift+F12`, `Mod+Print`).
- **Utility Scripts**: `setup_layout.sh` and a custom display script at
  `~/.config/scripts/display-setup.sh` (referenced, stow separately).

## Xmonad

- **Config**: `xmonad/.xmonad/xmonad.hs`
- **Terminal & Mod**: Ghostty as the default terminal, `mod1Mask` (Alt) as the
  modifier for parity with i3.
- **Layout Stack**:
  - Tiled, mirrored tiled, tabbed (simplest), and accordion layouts.
  - Gaps of 20px and spacing of 6px keep layouts airy.
  - Toggleable fullscreen via `Toggle NBFULL` while preserving gaps.
- **Startup Hooks**: Mirrors i3—`picom`, `feh`, `dunst`, `flameshot`,
  Polybar, `nm-applet`, and a Polkit agent.
- **Keybindings**:
  - `Mod+Space` launches the themed Rofi script.
  - `Mod+Tab` shows the Rofi window switcher.
  - `Mod+P` restarts Polybar.
  - Volume, mic mute, and brightness use the same pactl/brightnessctl commands
    as i3, keeping muscle memory intact.
  - `Mod+Shift+S/W` integrate with the layout/setup scripts used in i3.
  - Workspace cycling (`Mod+[` and `Mod+]`) and shift-to-prev/next are added to
    pair with gesture tooling (see [Gestures & Navigation](Gestures.md)).
- **Reusable Bindings**: Additional arrow-key helpers mirror Vim-style focus
  movement for consistency across keyboards and touchpad gestures.
