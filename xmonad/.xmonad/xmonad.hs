module Main (main) where

import Config (myConfig)
import Keybindings (myKeysP, myMouseBindings)
import XMonad (xmonad)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (docks)
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings)

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . docks
    $ myConfig
      `additionalKeysP` myKeysP
      `additionalMouseBindings` myMouseBindings
