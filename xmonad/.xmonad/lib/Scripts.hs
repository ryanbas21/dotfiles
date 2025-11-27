module Scripts
  ( -- * Launchers
    myLauncher
  , myWindowSwitcher
    -- * System
  , myLockScreen
  , myPolybarLaunch
  , mySetupLayout
  , myDisplaySetup
    -- * Volume
  , myVolumeUp
  , myVolumeDown
  , myVolumeMute
  , myMicMute
    -- * Brightness
  , myBrightnessUp
  , myBrightnessDown
    -- * Screenshots
  , myScreenshotGui
  , myScreenshotFull
  ) where

--------------------------------------------------------------------------------
-- Launchers
--------------------------------------------------------------------------------

myLauncher :: String
myLauncher = "~/.config/rofi/launchers/type-1/launcher.sh"

myWindowSwitcher :: String
myWindowSwitcher = "rofi -show window"

--------------------------------------------------------------------------------
-- System
--------------------------------------------------------------------------------

myLockScreen :: String
myLockScreen = "loginctl lock-session"

myPolybarLaunch :: String
myPolybarLaunch = "~/.config/polybar/launch_polybar.sh"

mySetupLayout :: String
mySetupLayout = "~/.config/i3/setup_layout.sh"

myDisplaySetup :: String
myDisplaySetup = "~/.config/scripts/display-setup.sh"

--------------------------------------------------------------------------------
-- Volume Control
--------------------------------------------------------------------------------

myVolumeUp :: String
myVolumeUp = "~/.local/bin/osd-volume +10"

myVolumeDown :: String
myVolumeDown = "~/.local/bin/osd-volume -10"

myVolumeMute :: String
myVolumeMute = "pactl set-sink-mute @DEFAULT_SINK@ toggle && ~/.local/bin/osd-volume +0"

myMicMute :: String
myMicMute = "pactl set-source-mute @DEFAULT_SOURCE@ toggle"

--------------------------------------------------------------------------------
-- Brightness Control
--------------------------------------------------------------------------------

myBrightnessUp :: String
myBrightnessUp = "~/.local/bin/osd-brightness +10%"

myBrightnessDown :: String
myBrightnessDown = "~/.local/bin/osd-brightness -10%"

--------------------------------------------------------------------------------
-- Screenshots
--------------------------------------------------------------------------------

myScreenshotGui :: String
myScreenshotGui = "flameshot gui"

myScreenshotFull :: String
myScreenshotFull = "flameshot full -p ~/Documents/screenshots"
