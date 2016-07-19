module Vibration exposing (..)

{-| Vibrate the user's device with HTML5 vibration, if possible.

# Vibration
@docs vibrate, vibrateInPattern, cancel
-}
import Native.Vibration

import Time exposing (Time)
import Task exposing (Task)

{-| Vibrate the device for a certain amount of time.
-}
vibrate : Time -> Task x ()
vibrate time = vibrateInPattern [time]

{-| Vibrate the device in a pattern of times.
The pattern alternates between vibrating and not vibrating,
starting with the former.
-}
vibrateInPattern : List Time -> Task x ()
vibrateInPattern = Native.Vibration.vibrateInPattern

{-| Stop any vibration that's currently happening.
-}
cancel : Task x ()
cancel = vibrateInPattern [] 
