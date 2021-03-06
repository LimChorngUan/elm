module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)

baseUrl : String
baseUrl = "https://programming-elm.com/"

initialModel : { url : String, caption : String, liked : Bool }
initialModel =
  { url = baseUrl ++ "1.jpg"
  , caption = "Surfing"
  , liked = False
  }

type Msg
  = Like
  | Unlike

view : { url: String, caption : String, liked: Bool } -> Html Msg
view model =
  div []
    [ div [ class "header" ]
      [ h1 [] [ text "PicShare" ] ]
    , div [ class "content-flow" ] [ viewDetailedPhoto model ]
    ]

viewDetailedPhoto : { url : String, caption: String, liked: Bool } -> Html Msg
viewDetailedPhoto model =
  let
    buttonClass =
      if model.liked then
        "fa-heart"
      else
        "fa-heart-o"

    msg =
      if model.liked then
        Unlike
      else
        Like
  in
  div [ class "detailed-photo" ]
    [ img [ src model.url ] []
    , div [ class "photo-info" ]
      [ div [ class "like-button"]
        [ i [ class "fa fa-2x"
            , class buttonClass
            , onClick msg ] [] ]
      , h2 [ class "caption"] [ text model.caption] ]
    ]

update : Msg -> { url: String, caption: String, liked: Bool } -> { url: String, caption: String, liked: Bool }
update msg model =
  case msg of
    Like ->
      { model | liked = True }
    Unlike ->
      { model | liked = False}

main : Program () { url : String, caption : String, liked : Bool } Msg
main =
  Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }

{--
<div>
  <div class="header">
    <h1>PicShare</h1>
  </div>
  <div class="content-flow">
    <div class="detailed-photo">
      <img src="https://programming-elm.com/1.jpg">
      <div class="photo-info">
        <h2 class="caption">Surfing</h2>
      </div>
    </div>
  </div>
</div>
--}