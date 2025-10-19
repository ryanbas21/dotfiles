# Gestures & Navigation

Gestures here refer to the muscle-memory moves that make both window managers
feel the same—keyboard-driven motions, touchpad swipes that trigger key events,
and helper scripts that keep layouts predictable.

## Keyboard Navigation Parity

- **Directional Focus**:
  - i3: `Mod+j/k/h/l` or arrow keys.
  - Xmonad: same bindings via EZConfig, plus `Mod+m` to focus master.
- **Window Moves**:
  - i3: `Mod+Shift+j/k/h/l` (and arrow equivalents) move containers.
  - Xmonad: `Mod+Shift+Return/j/k` swap master/down/up.
- **Workspace Cycling**:
  - i3: `Mod+1`–`Mod+0` to jump; pair with external gesture tools that send the
    same numeric shortcuts.
  - Xmonad: Adds `Mod+[ / Mod+]` (`prevWS` / `nextWS`) and `Mod+Shift+[ / ]`
    to push windows across workspaces—ideal for swipe gestures that emit
    bracket keys.
- **Layout Toggles**:
  - i3: `Mod+s/w/e` for stacking/tabbed/split layouts, `Mod+Shift+d` toggles
    floating, `Mod+f` for fullscreen.
  - Xmonad: `Mod+c` cycles layouts, `Mod+f` toggles fullscreen, `Mod+s` jumps to
    Accordion, `Mod+w` to Tabbed.

## Pointer & Touchpad Support

- **i3 Tiling Drag**: `tiling_drag modifier titlebar` lets you drag a tiling
  window with `Mod + Left Click`—pair this with touchpad gestures that hold Alt
  while swiping.
- **Xmonad Mouse Bindings**: `Mod + Button1/2/3` replicate the same drag/move
  behavior used in i3.

## Scripts & Hooks

- **Layout Reset**:
  - i3 binds `Mod+Shift+s` to `~/.config/i3/setup_layout.sh`, useful for gesture
    daemons that fire shell commands (e.g., three-finger tap).
  - Xmonad mirrors this with the same key combo via `spawn`.
- **Display Switching**: `Mod+Shift+w` launches
  `~/.config/scripts/display-setup.sh`, keeping monitor swaps consistent across
  both WMs—map this to secondary gestures if you regularly dock/undock.

## Tips for Future Gestures

- Use `xdotool` or `ydotool` in gesture managers to emit the bracket-based
  workspace cycle bindings so i3 and Xmonad respond the same way.
- Document any new gesture daemons (libinput-gestures, fusuma, etc.) in this
  file, including the commands they emit, so you can recreate the experience on
  fresh installs.
