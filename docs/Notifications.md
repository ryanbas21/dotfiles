# Notifications

## Dunst

- **Config**: `dunst/.config/dunst/dunstrc`
- **Placement**: Top-right corner with a 30px × 60px offset; notifies follow
  the mouse focus so alerts appear on the active display.
- **Sizing**:
  - Width 400px, height up to 300px.
  - Progress bar enabled (10px height, width 150–300px).
  - 15px text padding and a 3px frame colored `#cfcbc9`.
- **Look & Feel**:
  - Terminus font at size 18 for readability.
  - Separator lines between stacked notifications.
  - Transparency disabled (`0`) to keep contrast consistent with Catppuccin and
    Polybar themes.
- **Behavior**:
  - Idle threshold of 120 seconds keeps notifications until you return.
  - Sorting by urgency ensures critical alerts surface first.
  - `history_length = 20` (default) allows recent review—adjust if you need more
    persistence.
- **Urgency Colors**:
  - Low: background `#1a1a1a`, foreground `#888888`.
  - Normal: background `#141c21`, foreground `#cfcbc9`.
  - Critical: same background with a red frame and 5s timeout.
- **Integration**: i3 and Xmonad launch Dunst on startup. Restart it with
  `pkill dunst; dunst &` after edits to apply changes without logging out.
