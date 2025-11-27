{-# OPTIONS_GHC -Wno-missing-signatures #-}
module Layouts (myLayoutHook) where

import XMonad
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Layout.Accordion (Accordion (..))
import XMonad.Layout.Gaps (Direction2D (..), gaps)
import XMonad.Layout.MultiToggle (EOT (..), mkToggle, (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (NBFULL))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.Tabbed (shrinkText, tabbed)

import Theme (myGaps, mySpacing, myTabConfig)

--------------------------------------------------------------------------------
-- Layout Hook
--------------------------------------------------------------------------------

myLayoutHook =
  smartBorders
    . avoidStruts
    . fullscreenToggle
    . withGaps
    . withSpacing
    $ layouts
  where
    fullscreenToggle = mkToggle (NBFULL ?? EOT)
    withGaps         = gaps [(U, myGaps), (D, myGaps), (L, myGaps), (R, myGaps)]
    withSpacing      = spacing mySpacing

--------------------------------------------------------------------------------
-- Available Layouts
--------------------------------------------------------------------------------

layouts = tiled ||| Mirror tiled ||| tabs ||| Accordion
  where
    -- Default tiling: master on left, stack on right
    tiled = Tall nmaster delta ratio

    -- Tabbed layout with custom theme
    tabs = tabbed shrinkText myTabConfig

    -- Layout parameters
    nmaster = 1      -- Number of windows in master pane
    ratio   = 1 / 2  -- Proportion of screen for master
    delta   = 3 / 100 -- Resize increment
