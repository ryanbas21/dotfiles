# Compositor & Visual Effects

## Picom

- **Configs**:
  - `picom/.config/picom/picom.conf` (primary, tuned for AC power).
  - `picom/.config/picom/picom.battery.conf` (lower-power profile).
- **Backend**: Uses the `glx` backend with `vsync` for tear-free rendering on AC.
- **Battery behavior**: `bin/.local/bin/picom-autoconfig` picks the battery
  profile automatically when AC power is unavailable.
- **Performance Tweaks**:
  - `glx-no-stencil`, `glx-no-rebind-pixmap`, and `use-damage = true` for better
    GPU utilization.
  - `unredir-if-possible = false` keeps fullscreen apps composited to avoid
    flicker with GLX pipelines.
- **Focus Detection**: Enables `detect-client-opacity`, `detect-transient`,
  `mark-wmwin-focused`, and `mark-ovredir-focused` for smoother fades and focus
  handling across floating windows.
- **Launch**: Autostarted from both i3 and Xmonad, so changes here impact every
  session. Remember to restart the WM after edits or run `pkill picom; picom &`
  for a live reload.
