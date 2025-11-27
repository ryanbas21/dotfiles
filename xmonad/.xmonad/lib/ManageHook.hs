module ManageHook (myManageHook) where

import XMonad
import XMonad.Hooks.ManageDocks (manageDocks)

--------------------------------------------------------------------------------
-- Window Rules (ManageHook)
--
-- Use `xprop` to find window class names:
--   xprop | grep WM_CLASS
--------------------------------------------------------------------------------

myManageHook :: ManageHook
myManageHook = manageDocks <> composeAll
  [ className =? "MPlayer"         --> doFloat
  , className =? "Gimp"            --> doFloat
  , resource  =? "desktop_window"  --> doIgnore
  , resource  =? "kdesktop"        --> doIgnore

  -- Add more rules here as needed:
  -- , className =? "Firefox"       --> doShift "2"
  -- , className =? "Slack"         --> doShift "9"
  -- , isDialog                     --> doFloat
  ]
