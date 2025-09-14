module Main where

import qualified Data.Map as M
import Data.Monoid
import System.Exit
import XMonad
-- import XMonad.Actions.FloatKeys   -- not needed; functions are in XMonad
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Accordion
import XMonad.Layout.Gaps
-- import XMonad.Layout.ToggleLayouts  -- removed (we'll use MultiToggle)

-- Fullscreen done via MultiToggle (robust with modifiers)
import XMonad.Layout.MultiToggle (EOT (..), Toggle (..), mkToggle, (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (NBFULL))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- The preferred terminal program
myTerminal = "ghostty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth = 1

-- Alt as mod
myModMask = mod1Mask

-- Workspaces
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

-- Border colors
myNormalBorderColor = "#dddddd"

myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ -- launch a terminal
      ((modm, xK_Return), spawn $ XMonad.terminal conf),
      -- rofi launcher (your script)
      ((modm, xK_space), spawn "~/.config/rofi/launchers/type-1/launcher.sh"),
      -- rofi window switcher (like alt+tab)
      ((modm, xK_Tab), spawn "rofi -show window"),
      -- close focused window
      ((modm .|. shiftMask, xK_q), kill),
      -- cycle layouts
      ((modm, xK_c), sendMessage NextLayout),
      -- reset layouts on this workspace
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- focus movement
      ((modm, xK_j), windows W.focusDown),
      ((modm, xK_k), windows W.focusUp),
      ((modm, xK_m), windows W.focusMaster),
      -- swapping
      ((modm .|. shiftMask, xK_Return), windows W.swapMaster),
      ((modm .|. shiftMask, xK_j), windows W.swapDown),
      ((modm .|. shiftMask, xK_k), windows W.swapUp),
      -- resizing master
      ((modm, xK_h), sendMessage Shrink),
      ((modm, xK_l), sendMessage Expand),
      -- sink
      ((modm, xK_t), withFocused $ windows . W.sink),
      -- change master count
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      ((modm, xK_period), sendMessage (IncMasterN (-1))),
      -- toggle bar gap
      ((modm, xK_b), sendMessage ToggleStruts),
      -- quit / restart xmonad
      ((modm .|. shiftMask, xK_e), io (exitWith ExitSuccess)),
      ((modm .|. shiftMask, xK_r), spawn "xmonad --recompile; xmonad --restart"),
      -- arrows helpers
      ((modm, xK_Left), windows W.focusUp),
      ((modm, xK_Down), windows W.focusDown),
      ((modm, xK_Up), windows W.focusUp),
      ((modm, xK_Right), windows W.focusDown),
      ((modm .|. shiftMask, xK_Left), windows W.swapUp),
      ((modm .|. shiftMask, xK_Down), windows W.swapDown),
      ((modm .|. shiftMask, xK_Up), windows W.swapUp),
      ((modm .|. shiftMask, xK_Right), windows W.swapDown),
      -- FULLSCREEN (MultiToggle)
      ((modm, xK_f), sendMessage $ Toggle NBFULL),
      -- jump-to-layout helpers (names must match)
      ((modm, xK_s), sendMessage $ JumpToLayout "Accordion"),
      ((modm, xK_w), sendMessage $ JumpToLayout "Tabbed Simplest"),
      -- focus parent (master)
      ((modm, xK_a), windows W.focusMaster),
      -- lock screen
      ((modm .|. shiftMask, xK_x), spawn "loginctl lock-session"),
      -- Volume
      ((0, 0x1008ff13), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%"), -- XF86AudioRaiseVolume
      ((0, 0x1008ff11), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%"), -- XF86AudioLowerVolume
      ((0, 0x1008ff12), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"), -- XF86AudioMute
      ((0, 0x1008ffb2), spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle"), -- Mic mute

      -- Brightness
      ((0, 0x1008ff02), spawn "brightnessctl set +10%"), -- XF86MonBrightnessUp
      ((0, 0x1008ff03), spawn "brightnessctl set 10%-"), -- XF86MonBrightnessDown

      -- Polybar
      ((modm, xK_p), spawn "~/.config/polybar/launch_polybar.sh"),
      -- Setup/display scripts
      ((modm .|. shiftMask, xK_s), spawn "~/.config/i3/setup_layout.sh"),
      ((modm .|. shiftMask, xK_w), spawn "~/.config/scripts/display-setup.sh"),
      -- Screenshots
      ((0, xK_F12), spawn "flameshot gui"),
      ((shiftMask, xK_F12), spawn "flameshot full -p ~/Documents/screenshots"),
      ((modm, xK_Print), spawn "flameshot full -p ~/Documents/screenshots")
    ]
      ++ [ ((m .|. modm, k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
           (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
         ]
      ++ [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
         | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
           (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]

------------------------------------------------------------------------
-- Mouse bindings
myMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster),
      ((modm, button2), \w -> focus w >> windows W.shiftMaster),
      ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]

------------------------------------------------------------------------
-- Layouts
myLayout =
  smartBorders $
    avoidStruts $
      mkToggle (NBFULL ?? EOT) $
        gaps [(U, 20), (D, 20), (L, 20), (R, 20)] $
          spacing 6 $
            (tiled ||| Mirror tiled ||| tabbed shrinkText def ||| Accordion)
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

------------------------------------------------------------------------
-- Window rules
myManageHook =
  composeAll
    [ className =? "MPlayer" --> doFloat,
      className =? "Gimp" --> doFloat,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

------------------------------------------------------------------------
-- Events / Logs
myEventHook = mempty

myLogHook = return ()

------------------------------------------------------------------------
-- Startup
myStartupHook = do
  spawnOnce "picom"
  spawnOnce "feh --bg-scale \"/home/ryan/Pictures/i3-bg.png\""
  spawnOnce "/usr/bin/dunst"
  spawnOnce "nm-applet"
  spawnOnce "~/.config/polybar/launch_polybar.sh"
  spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
  spawnOnce "flameshot"

-- spawn "dex --autostart --environment xmonad --exclude \"org.kde.plasmashell\" --exclude \"org.kde.plasma-fallback-session-restore\""

------------------------------------------------------------------------
-- Main
main =
  xmonad $
    ewmhFullscreen $
      ewmh $
        docks $
          def
            { terminal = myTerminal,
              focusFollowsMouse = myFocusFollowsMouse,
              clickJustFocuses = myClickJustFocuses,
              borderWidth = myBorderWidth,
              modMask = myModMask,
              workspaces = myWorkspaces,
              normalBorderColor = myNormalBorderColor,
              focusedBorderColor = myFocusedBorderColor,
              keys = myKeys,
              mouseBindings = myMouseBindings,
              layoutHook = myLayout,
              manageHook = myManageHook,
              handleEventHook = myEventHook,
              logHook = myLogHook,
              startupHook = myStartupHook
            }

-- | Help text
help :: String
help =
  unlines
    [ "The default modifier key is 'alt'. Default keybindings:",
      "",
      "-- launching and killing programs",
      "mod-Enter        Launch terminal",
      "mod-Space        Launch rofi",
      "mod-Tab          Window switcher",
      "mod-Shift-q      Close/kill the focused window",
      "mod-Shift-e      Quit XMonad",
      "mod-Shift-r      Restart XMonad",
      "",
      "-- move focus up or down the window stack",
      "mod-j            Move focus to the next window",
      "mod-k            Move focus to the previous window",
      "mod-h            Shrink the master area",
      "mod-l            Expand the master area",
      "mod-m            Move focus to the master window",
      "",
      "-- modifying the window order",
      "mod-Return       Swap the focused window and the master window",
      "mod-Shift-j      Swap the focused window with the next window",
      "mod-Shift-k      Swap the focused window with the previous window",
      "",
      "-- fullscreen toggle",
      "mod-f            Toggle borderless fullscreen (MultiToggle)",
      "",
      "-- Workspaces & screens",
      "mod-[1..9,0]     Switch to workspace N",
      "mod-Shift-[...]  Move client to workspace N",
      "mod-[w,e,r]      View screen 1/2/3",
      "mod-Shift-[w,e,r]Move client to screen 1/2/3",
      "",
      "-- Mouse bindings",
      "mod-button1      Float+move by dragging",
      "mod-button2      Raise window",
      "mod-button3      Float+resize by dragging"
    ]
