module OldSchool exposing (main)

import Browser
import Html exposing (Html, button, div, h1, li, text, ul)
import Html.Events exposing (onClick)
import Http
import Json.Decode



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
    { names : List String
    , errorMessage : Maybe String
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
    | DataReceived (Result Http.Error (List String))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, getNames )

        DataReceived (Ok nameList) ->
            ( { model | names = nameList }, Cmd.none )

        DataReceived (Err httpError) ->
            ( { model | errorMessage = Just (generateErrorMessage httpError) }, Cmd.none )



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
        , text ("Error: " ++ errorMessage)
        ]


viewNames : List String -> Html Msg
viewNames names =
    div []
        [ h1 [] [ text "Old school character names" ]
        , ul [] (List.map viewName names)
        ]


viewName : String -> Html Msg
viewName name =
    li [] [ text name ]



-- CONST


url : String
url =
    "http://localhost:5019/nicknames"



-- FUNCS


getNames : Cmd Msg
getNames =
    Http.get
        { url = url
        , expect = Http.expectJson DataReceived nicknamesDecoder
        }


nicknamesDecoder : Json.Decode.Decoder (List String)
nicknamesDecoder =
    Json.Decode.list Json.Decode.string


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
