{-# OPTIONS_GHC -Wno-missing-signatures #-}

module Config
  ( myConfig,
    myTerminal,
    myModMask,
    myWorkspaces,
  )
where

import Layouts (myLayoutHook)
import ManageHook (myManageHook)
import Theme
  ( myBorderWidth,
    myFocusedBorderColor,
    myNormalBorderColor,
  )
import XMonad
import XMonad.Util.SpawnOnce (spawnOnce)

--------------------------------------------------------------------------------
-- Core Settings
--------------------------------------------------------------------------------

myTerminal :: String
myTerminal = "ghostty"

myModMask :: KeyMask
myModMask = mod1Mask -- Alt key

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1 .. 9 :: Int]

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

--------------------------------------------------------------------------------
-- Base Configuration
--------------------------------------------------------------------------------

myConfig =
  def
    { terminal = myTerminal,
      focusFollowsMouse = myFocusFollowsMouse,
      clickJustFocuses = myClickJustFocuses,
      borderWidth = myBorderWidth,
      modMask = myModMask,
      workspaces = myWorkspaces,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      layoutHook = myLayoutHook,
      manageHook = myManageHook,
      handleEventHook = mempty,
      logHook = pure (),
      startupHook = myStartupHook
    }

--------------------------------------------------------------------------------
-- Startup Hook (matches i3 exec statements)
--------------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
  -- Compositor
  spawnOnce "picom"
  -- Wallpaper
  spawnOnce "feh --bg-scale /home/ryan/Pictures/i3-bg.png"
  -- Notifications
  spawnOnce "dunst"
  -- Network applet
  spawnOnce "nm-applet"
  -- Status bar
  spawnOnce "~/.config/polybar/launch_polybar.sh"
  -- Screenshots
  spawnOnce "flameshot"
  -- Polkit agent (for GUI sudo prompts)
  spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
  -- XDG autostart
  spawnOnce "dex --autostart --environment xmonad"
