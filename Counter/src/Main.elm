module Main exposing (main)

import Browser
import Html exposing (Html, div, button, p, text)
import Html.Events exposing (onClick)


-- MAIN
main : Program () Model Msg
main =
  Browser.sandbox
  { init = initialModel
  , view = view
  , update = update
  }


-- MODEL
type alias Model = { count: Int }

initialModel : Model
initialModel =
  { count = 0 }


-- UPDATE
type Msg
  = Increment
  | Decrement
  | Reset


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { count = model.count + 1 }
    Decrement ->
      { count = model.count - 1 }
    Reset ->
      { count = 0 }


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , p [] [ text (String.fromInt model.count) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Reset ] [ text "reset" ]
    ]


{--
<div>
  <button>+</button>
  <p>{count}</p>
  <button>-</button>
</div>
--}