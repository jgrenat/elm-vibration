effect module Vibration where { command = MyCmd } exposing
    ( vibrate
    , vibrateInPattern
    , cancel
    )

{-| Vibrate the device.

# Vibration
@docs vibrate, vibrateInPattern, cancel
-}
import Native.Vibration

import Time exposing (Time)
import Task exposing (Task)
import Platform exposing (Router)

-- Public Commands

{-| Vibrate the device for a certain amount of time.
-}
vibrate : Time -> Cmd msg
vibrate time = vibrateInPattern [time]

{-| Vibrate the device in a pattern of times.
The pattern alternates between vibrating and not vibrating,
starting with the former.
-}
vibrateInPattern : List Time -> Cmd msg
vibrateInPattern = command << Vibrate

{-| Stop any vibration that's currently happening.
-}
cancel : Cmd msg
cancel = vibrateInPattern [] 

-- Effect Manager

type MyCmd msg
    = Vibrate (List Time)

cmdMap : (a -> b) -> MyCmd a -> MyCmd b
cmdMap _ cmd = case cmd of
    Vibrate times -> Vibrate times

init : Task Never ()
init = Task.succeed ()

onEffects : Router msg Never -> List (MyCmd msg) -> () -> Task Never ()
onEffects router cmds state =
    let
        cmdToTask : MyCmd msg -> Task Never ()
        cmdToTask cmd = case cmd of
            Vibrate times -> Task.succeed <| Native.Vibration.vibrateInPattern times
    in case cmds of
        [] -> Task.succeed ()
        _  -> Task.map (\ _ -> ()) <| Task.sequence <| List.map cmdToTask <| cmds

onSelfMsg : Router msg Never -> Never -> () -> Task Never ()
onSelfMsg _ _ _ = Task.succeed ()
