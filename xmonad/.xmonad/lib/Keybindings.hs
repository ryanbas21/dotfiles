module Keybindings
  ( myKeysP
  , myMouseBindings
  ) where

import System.Exit (exitSuccess)

import XMonad
import XMonad.Actions.CycleWS (nextWS, prevWS, shiftToNext, shiftToPrev)
import XMonad.Hooks.ManageDocks (ToggleStruts (..))
import XMonad.Layout.MultiToggle (Toggle (..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (NBFULL))
import qualified XMonad.StackSet as W

import Config (myTerminal)
import Scripts (myLauncher, myWindowSwitcher, myLockScreen, myPolybarLaunch,
                mySetupLayout, myDisplaySetup, myVolumeUp, myVolumeDown,
                myVolumeMute, myMicMute, myBrightnessUp, myBrightnessDown,
                myScreenshotGui, myScreenshotFull)

--------------------------------------------------------------------------------
-- Keybindings (EZConfig style)
--
-- Modifier keys:
--   M  = mod key (Alt)
--   S  = Shift
--   C  = Control
--   M1 = Alt (explicit)
--   M4 = Super/Windows key
--------------------------------------------------------------------------------

myKeysP :: [(String, X ())]
myKeysP = concat
  [ launchersKeys
  , windowKeys
  , layoutKeys
  , workspaceKeys
  , mediaKeys
  , systemKeys
  ]

--------------------------------------------------------------------------------
-- Launchers & Applications
--------------------------------------------------------------------------------

launchersKeys :: [(String, X ())]
launchersKeys =
  [ ("M-<Return>", spawn myTerminal)
  , ("M-<Space>",  spawn myLauncher)
  , ("M-<Tab>",    spawn myWindowSwitcher)
  , ("M-p",        spawn myPolybarLaunch)
  ]

--------------------------------------------------------------------------------
-- Window Management
--------------------------------------------------------------------------------

windowKeys :: [(String, X ())]
windowKeys =
  -- Focus
  [ ("M-j",   windows W.focusDown)
  , ("M-k",   windows W.focusUp)
  , ("M-m",   windows W.focusMaster)
  , ("M-a",   windows W.focusMaster)  -- Alternative binding

  -- Focus with arrows
  , ("M-<Left>",  windows W.focusUp)
  , ("M-<Down>",  windows W.focusDown)
  , ("M-<Up>",    windows W.focusUp)
  , ("M-<Right>", windows W.focusDown)

  -- Swap
  , ("M-S-<Return>", windows W.swapMaster)
  , ("M-S-j",        windows W.swapDown)
  , ("M-S-k",        windows W.swapUp)

  -- Swap with arrows
  , ("M-S-<Left>",  windows W.swapUp)
  , ("M-S-<Down>",  windows W.swapDown)
  , ("M-S-<Up>",    windows W.swapUp)
  , ("M-S-<Right>", windows W.swapDown)

  -- Actions
  , ("M-S-q", kill)                              -- Close window
  , ("M-t",   withFocused $ windows . W.sink)    -- Push to tiling
  , ("M-n",   refresh)                           -- Resize to correct size
  ]

--------------------------------------------------------------------------------
-- Layout Control
--------------------------------------------------------------------------------

layoutKeys :: [(String, X ())]
layoutKeys =
  [ ("M-c",       sendMessage NextLayout)
  , ("M-f",       sendMessage $ Toggle NBFULL)         -- Toggle fullscreen
  , ("M-b",       sendMessage ToggleStruts)            -- Toggle bar gap

  -- Resize master area
  , ("M-h", sendMessage Shrink)
  , ("M-l", sendMessage Expand)

  -- Master window count
  , ("M-,", sendMessage $ IncMasterN 1)
  , ("M-.", sendMessage $ IncMasterN (-1))

  -- Jump to specific layouts (names must match Layouts.hs)
  , ("M-s", sendMessage $ JumpToLayout "Accordion")
  , ("M-w", sendMessage $ JumpToLayout "Tabbed Simplest")
  ]

--------------------------------------------------------------------------------
-- Workspace Navigation
--------------------------------------------------------------------------------

workspaceKeys :: [(String, X ())]
workspaceKeys =
  -- Cycle workspaces
  [ ("M-]",   nextWS)
  , ("M-[",   prevWS)
  , ("M-S-]", shiftToNext)
  , ("M-S-[", shiftToPrev)
  ]
  ++
  -- Switch to workspace N with M-1..M-0
  [ ("M-" ++ show (n :: Int), windows $ W.greedyView ws)
  | (n, ws) <- zip ([1..9] ++ [0]) (map show ([1..10] :: [Int]))
  ]
  ++
  -- Move window to workspace N with M-S-1..M-S-0
  [ ("M-S-" ++ show (n :: Int), windows $ W.shift ws)
  | (n, ws) <- zip ([1..9] ++ [0]) (map show ([1..10] :: [Int]))
  ]

--------------------------------------------------------------------------------
-- Media & Hardware Keys
--------------------------------------------------------------------------------

mediaKeys :: [(String, X ())]
mediaKeys =
  [ ("<XF86AudioRaiseVolume>",  spawn myVolumeUp)
  , ("<XF86AudioLowerVolume>",  spawn myVolumeDown)
  , ("<XF86AudioMute>",         spawn myVolumeMute)
  , ("<XF86AudioMicMute>",      spawn myMicMute)
  , ("<XF86MonBrightnessUp>",   spawn myBrightnessUp)
  , ("<XF86MonBrightnessDown>", spawn myBrightnessDown)
  ]

--------------------------------------------------------------------------------
-- System & Screenshots
--------------------------------------------------------------------------------

systemKeys :: [(String, X ())]
systemKeys =
  [ ("M-S-e", io exitSuccess)                           -- Quit XMonad
  , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
  , ("M-S-x", spawn myLockScreen)

  -- Setup scripts
  , ("M-S-s", spawn mySetupLayout)
  , ("M-S-w", spawn myDisplaySetup)

  -- Screenshots
  , ("<F12>",     spawn myScreenshotGui)
  , ("S-<F12>",   spawn myScreenshotFull)
  , ("M-<Print>", spawn myScreenshotFull)
  ]

--------------------------------------------------------------------------------
-- Mouse Bindings
--------------------------------------------------------------------------------

myMouseBindings :: [((KeyMask, Button), Window -> X ())]
myMouseBindings =
  [ ((mod1Mask, button1), mouseAction mouseMoveWindow)
  , ((mod1Mask, button2), mouseAction id')
  , ((mod1Mask, button3), mouseAction mouseResizeWindow)
  ]
  where
    mouseAction f w = focus w >> f w >> windows W.shiftMaster
    id' = const $ pure ()
