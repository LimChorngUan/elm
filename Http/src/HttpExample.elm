module HttpExample exposing ( Model )


import Browser
import Html exposing ( Html, div, button, text, h1, ul, li )
import Html.Events exposing ( onClick )

import Http



-- MAIN
main : Program () Model Msg
main =
    Browser.element
      { init = init
      , view = view
      , update = update
      , subscriptions = \_ -> Sub.none
      }


-- MODEL
type alias Model =
    { names: List String
    , errorMessage: Maybe String
    }



-- INIT
init : () -> ( Model, Cmd Msg )
init _ =
    ( { names = []
      , errorMessage = Nothing
      }
    , Cmd.none
    )



-- UPDATE
type Msg
  = SendHttpRequest
  | DataReceived ( Result Http.Error String )



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, getNames )

        DataReceived ( Ok nameStr ) ->
            let
                listOfNames =
                    String.split "," nameStr
            in
            ( { model | names = listOfNames }, Cmd.none )

        DataReceived ( Err httpError ) ->
            ( { model | errorMessage = Just ( generateErrorMessage httpError ) }, Cmd.none )



-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendHttpRequest ] [ text "Get data from server" ]
        , viewNamesOrError model
        ]


viewNamesOrError : Model -> Html Msg
viewNamesOrError model =
    case model.errorMessage of
        Just message ->
            viewError message

        Nothing ->
            viewNames model.names


viewError : String -> Html Msg
viewError errorMessage =
    div []
        [ h1 [] [ text "Cannot fetch names" ]
        , text ( "Error: " ++ errorMessage )
        ]


viewNames names =
    div []
        [ h1 [] [ text "Old school character names"]
        , ul [] ( List.map viewName names )
        ]


viewName : String -> Html Msg
viewName name =
    li [] [ text name ]



-- CONST
url : String
url =
    "http://localhost:5016/old-school.txt"



-- FUNCS
getNames : Cmd Msg
getNames =
    Http.get
        { url = url
        , expect = Http.expectString DataReceived
        }


generateErrorMessage : Http.Error -> String
generateErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long to respond. Please try again later."

        Http.NetworkError ->
            "Unable to reach server."

        Http.BadStatus statusCode ->
            "Request failed with status code: " ++ String.fromInt statusCode

        Http.BadBody message ->
            message