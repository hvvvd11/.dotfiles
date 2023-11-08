import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Util.EZConfig (additionalKeysP, additionalKeys)  -- Import for both keybinding methods
import XMonad.Util.Run (spawnPipe)  -- For the spawn function

myStartupHook :: X ()
myStartupHook = do
    spawn "setxkbmap -layout us,ua -variant , -option grp:caps_toggle"
    spawn "xbindkeys"

myAdditionalKeysP =
    [ ("M-<Print>", spawn "sleep 0.2; scrot -s -e 'mv $f ~/Pictures/'")  -- Mod + Print for region select
    , ("<Print>", spawn "scrot -e 'mv $f ~/Pictures/'")  -- Just Print for full screenshot
    ]

main = xmonad $ def
    { terminal    = "kitty"
    , modMask     = mod4Mask
    , startupHook = myStartupHook
    }
    `additionalKeysP` myAdditionalKeysP

