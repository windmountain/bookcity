module Main exposing (main)

import Browser
import Html exposing (Html, div, text)

type alias Number = Int


type alias Model = {}

type Msg
    = NoOp


init : Model
init = {
    }


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    div [] [ text "Hello, World!" ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
