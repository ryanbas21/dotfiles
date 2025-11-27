module Theme
  ( -- * Border settings
    myBorderWidth
  , myNormalBorderColor
  , myFocusedBorderColor
    -- * Layout spacing
  , myGaps
  , mySpacing
    -- * Tabbed layout theme
  , myTabConfig
  ) where

import XMonad (Dimension)
import XMonad.Layout.Tabbed (Theme (..), def)

--------------------------------------------------------------------------------
-- Border Settings
--------------------------------------------------------------------------------

myBorderWidth :: Dimension
myBorderWidth = 1

myNormalBorderColor :: String
myNormalBorderColor = "#dddddd"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ff0000"

--------------------------------------------------------------------------------
-- Layout Spacing
--------------------------------------------------------------------------------

-- | Gap size for screen edges (top, bottom, left, right)
myGaps :: Int
myGaps = 20

-- | Spacing between windows
mySpacing :: Int
mySpacing = 6

--------------------------------------------------------------------------------
-- Tabbed Layout Theme
--------------------------------------------------------------------------------

myTabConfig :: Theme
myTabConfig = def
  { activeColor         = "#556064"
  , inactiveColor       = "#2f3d44"
  , urgentColor         = "#fdf6e3"
  , activeBorderColor   = "#454948"
  , inactiveBorderColor = "#454948"
  , urgentBorderColor   = "#268bd2"
  , activeTextColor     = "#80fff9"
  , inactiveTextColor   = "#1abc9c"
  , urgentTextColor     = "#1abc9c"
  , fontName            = "xft:JetBrainsMono Nerd Font:size=10:antialias=true"
  }
