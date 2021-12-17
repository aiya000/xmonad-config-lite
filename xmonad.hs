import Data.Semigroup ((<>))
import XMonad
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.StackSet (greedyView, shift, swapDown, swapUp)
import XMonad.Util.EZConfig (additionalKeys)

main :: IO ()
main = xmonad $ gnomeConfig `additionalKeys` myKeys

myKeys :: [((KeyMask, KeySym), X ())]
myKeys =
  keys <>
  switchingWorkspaces <>
  puttingWindowsToWorkspace
  where
    keys =
      [ ((altMask .|. controlMask, xK_h), windows swapUp)
      , ((altMask .|. controlMask, xK_l), windows swapDown)
      ]

    switchingWorkspaces = do
      (numKey, workspace) <- zip [xK_1 .. xK_9] myWorkspaces
      let keymap = (altMask .|. controlMask, numKey)
      let switching = windows $ greedyView workspace
      pure (keymap, switching)

    puttingWindowsToWorkspace = do
      (numKey, workspace) <- zip [xK_1 .. xK_9] myWorkspaces
      let keymap = (superMask, numKey)
      let putting = windows $ shift workspace
      pure (keymap, putting)

    myWorkspaces = map show [1 .. 4]

altMask :: KeyMask
altMask = mod1Mask

superMask :: KeyMask
superMask = mod4Mask
