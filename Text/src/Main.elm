module Main exposing (main)

import Browser
import Html exposing (Html, div, input, p, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)

-- MAIN
main : Program () Model Msg
main =
  Browser.sandbox
  { init = initialModel
  , view = view
  , update = update
  }


-- MODEL
type alias Model = String

initialModel : Model
initialModel =
  ""


-- UPDATE
type Msg
  = ChangeContent String

update : Msg -> Model -> Model
update msg model =
  case msg of
    ChangeContent newContent ->
      model ++ newContent


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input
      [ placeholder "Text to reverse"
      , value model
      , onInput ChangeContent
      ] []
    , p [] [ text (String.reverse model) ]
    ]

{--
<div>
  <input>
  <p>
</div>
--}