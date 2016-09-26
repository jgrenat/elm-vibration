module Test exposing (..)

import Task
import Time exposing (millisecond)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App exposing (program)

import Vibration

main : Program Never
main = program
    { init = () ! []
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }

type alias Model = ()

view : Model -> Html Event
view model =
    div []
        [ div [] [ button [ onClick Vibrate ]          [ text "Vibrate" ]]
        , div [] [ button [ onClick VibrateInPattern ] [ text "VibrateInPattern" ]]
        , div [] [ button [ onClick Cancel ]           [ text "Cancel" ]]
        ]

type Event
    = Vibrate
    | VibrateInPattern
    | Cancel

update : Event -> Model -> (Model, Cmd Event)
update event model =
    case event of
        Vibrate          -> model ! [Vibration.vibrate <| 200 * millisecond]
        VibrateInPattern -> model ! [Vibration.vibrateInPattern <| List.map ((*) millisecond) [200, 300, 400]]
        Cancel           -> model ! [Vibration.cancel]
