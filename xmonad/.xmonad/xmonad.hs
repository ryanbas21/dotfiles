module Main (main) where

import XMonad (xmonad)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (docks)
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings)

import Config (myConfig)
import Keybindings (myKeysP, myMouseBindings)

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . docks
    $ myConfig
        `additionalKeysP` myKeysP
        `additionalMouseBindings` myMouseBindings
