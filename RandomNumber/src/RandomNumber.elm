module RandomNumber exposing (main)

import Browser
import Html exposing (Html, button, div, span, text)
import Html.Events exposing (onClick)
import Random



-- Main


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- Model


type alias Model =
    Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )



-- Update


type Msg
    = GenerateRandomNumber
    | NewRandomNumber Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateRandomNumber ->
            ( model, Random.generate NewRandomNumber (Random.int 0 1000) )

        NewRandomNumber num ->
            ( num, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ span [] [ text (String.fromInt model) ]
        , button [ onClick GenerateRandomNumber ] [ text "Generate Random Number" ]
        ]
