-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce
import XMonad.Hooks.SetWMName

main = xmonad $ gnomeConfig
	{ borderWidth = 3
	, startupHook = setWMName "LG3D"
	, manageHook = manageHook gnomeConfig
	, terminal = "mate-terminal"
	}

