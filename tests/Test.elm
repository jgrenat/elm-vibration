module Test exposing (..)

import Task
import Time exposing (millisecond)

import Html exposing (Html)
import Html.App
import Html.Events

import Vibration

main : Program Never
main = Html.App.program
    { init = (0) ! [Cmd.none]
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }

type alias Model = Int

view : Model -> Html Event
view model =
    Html.div []
        [ Html.div [] [ Html.button [ Html.Events.onClick Vibrate ] [ Html.text "Vibrate" ]]
        , Html.div [] [ Html.button [ Html.Events.onClick VibrateInPattern ] [ Html.text "VibrateInPattern" ]]
        , Html.div [] [ Html.button [ Html.Events.onClick Cancel ] [ Html.text "Cancel" ]]
        ]

type Event
    = Vibrate
    | VibrateInPattern
    | Cancel
    | Success
    | Failure

update : Event -> Model -> (Model, Cmd Event)
update event model =
    case event of
        Vibrate ->
            model ! [Task.perform (always Failure) (always Success) (Vibration.vibrate (200 * millisecond))]
        VibrateInPattern ->
            model ! [Task.perform (always Failure) (always Success) (Vibration.vibrateInPattern [200 * millisecond, 300 * millisecond, 400 * millisecond])]
        Cancel ->
            model ! [Task.perform (always Failure) (always Success) (Vibration.cancel)]
        Success ->
            (Debug.log "success" model) ! [Cmd.none]
        Failure ->
            (Debug.log "failure" model) ! [Cmd.none]
