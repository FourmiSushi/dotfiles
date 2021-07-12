import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import System.Exit
import XMonad.StackSet as W
import XMonad.Layout.Spiral
import XMonad.Hooks.ManageHelpers

main :: IO()
main = do
     xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myConfig = defaultConfig {
  terminal = myTerminal
  ,startupHook = myStartupHook
  ,modMask = mod4Mask
  ,borderWidth = myBorderWidth
  ,normalBorderColor = myNormalBorderColor
  ,focusedBorderColor = myFocusedBorderColor
  ,layoutHook = myLayout
  ,manageHook = myManageHook
  } `additionalKeysP` myAdditionalKeysP

blackColor = "#6e5773"
darkerColor = "#d45d79"
lighterColor = "#ea9085"
whiteColor = "#e9e2d0"

myTerminal = "alacritty"
myFileManager = "thunar"
myScreenshotRegion = "flameshot gui"
myScreenshotCopy = "flameshot screen -c"
myScreenshotSave = "flameshot screen"
myLauncher = "dmenu_run -fn 'Misc Fixed-9' -nb '" ++ blackColor ++ "' -nf '" ++ whiteColor ++ "' -sb '" ++ lighterColor ++ "' -sf '" ++ whiteColor ++ "'"
myShutdown = "shutdown now"

myStartupHook = do
  spawn "feh --bg-scale --randomize ~/Wallpapers"
  spawn "fcitx"

myBorderWidth = 1
myNormalBorderColor = blackColor
myFocusedBorderColor = lighterColor

myLayout = spiral (3/4)

myPP = xmobarPP {
  ppCurrent = xmobarColor lighterColor ""
  ,ppTitle = \x -> ""
  ,ppLayout = \x -> ""
  }

myManageHook = fmap not isDialog --> doF avoidMaster
avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
     W.Stack t [] (r:rs) ->  W.Stack t [r] rs
     otherwise           -> c

myAdditionalKeysP = [
  -- Applications
  ("M-<Return>", spawn myTerminal)
  ,("M-S-<Return>", spawn myFileManager)
  -- Screenshot
  ,("M-S-s", spawn myScreenshotRegion)
  ,("<Print>", spawn myScreenshotCopy)
  ,("S-<Print>", spawn myScreenshotSave)
  -- kill Window
  ,("M-S-q", kill)
  ,("M-q", kill)
  -- dmenu
  ,("M-S-d", spawn myLauncher)
  ,("M-d", spawn myLauncher)
  -- quit or restart Xmonad
  ,("M-S-e", io (exitWith ExitSuccess))
  ,("M-S-x", spawn myShutdown)
  ,("M-S-r", spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
  -- move focused to Master
  ,("M-S-m", windows W.swapMaster)
  -- audio volume
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")
  , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
  ]
  ++
  -- Workspaces
  [("M-S-" ++ i, windows $ (\i ->  W.greedyView i . W.shift i) i) | i <- map show [1 .. 9 :: Int]]

myRemoveKeysP = []

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
