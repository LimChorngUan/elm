module Main exposing (main)

import Browser
import Html exposing (Html, div, input, p, text, button)
import Html.Attributes exposing (..)
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
type alias Model = { content : String }

initialModel : Model
initialModel =
  { content = "" }


-- UPDATE
type Msg
  = ChangeContent String

update : Msg -> Model -> Model
update msg model =
  case msg of
    ChangeContent newContent ->
      { model | content = newContent }


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input
      [ placeholder "Text to reverse"
      , value model.content
      , onInput ChangeContent
      ] []
    , p [] [ text (String.reverse model.content) ]
    ]

{--
<div>
  <input>
  <p>
</div>
--}