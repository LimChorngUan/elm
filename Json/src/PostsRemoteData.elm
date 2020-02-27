module PostsRemoteData exposing (main)

import Browser
import Html exposing (Html, a, button, div, h1, table, td, text, th, tr)
import Html.Attributes exposing (hidden, href)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (optional, required)
import RemoteData exposing (WebData)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- CONST


url : String
url =
    "http://localhost:5019/posts"



-- MODEL


type alias Model =
    WebData (List Post)


type alias Post =
    { id : Int
    , title : String
    , author : Author
    }


type alias Author =
    { name : String
    , url : String
    }


init : () -> ( Model, Cmd Msg )
init =
    \_ ->
        ( RemoteData.Loading
        , getPosts
        )



-- UPDATE


type Msg
    = SendHttpRequestToGetPosts
    | ReceivedData (WebData (List Post))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        SendHttpRequestToGetPosts ->
            ( RemoteData.Loading
            , getPosts
            )

        ReceivedData response ->
            ( response
            , Cmd.none
            )


getPosts : Cmd Msg
getPosts =
    Http.get
        { url = url
        , expect =
            list postDecoder
                |> Http.expectJson (RemoteData.fromResult >> ReceivedData)
        }


postDecoder : Decoder Post
postDecoder =
    Decode.succeed Post
        |> required "id" int
        |> required "title" string
        |> required "author" authorDecoder


authorDecoder : Decoder Author
authorDecoder =
    Decode.succeed Author
        |> optional "name" string "anonymous"
        |> optional "url" string "#"


generateErrorMessage : Http.Error -> String
generateErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Ops timeout"

        Http.NetworkError ->
            "Ops network error"

        Http.BadStatus code ->
            "Ops bad status with this error code: " ++ String.fromInt code

        Http.BadBody message ->
            message



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewPostsStatus model
        , viewRefreshButton model
        ]


viewRefreshButton : Model -> Html Msg
viewRefreshButton model =
    case model of
        RemoteData.NotAsked ->
            button [ hidden True ] []

        RemoteData.Loading ->
            button [ hidden True ] []

        RemoteData.Failure _ ->
            button [ onClick SendHttpRequestToGetPosts ] [ text "Reload" ]

        RemoteData.Success _ ->
            button [ onClick SendHttpRequestToGetPosts ] [ text "Refresh Posts" ]


viewPostsStatus : Model -> Html Msg
viewPostsStatus model =
    case model of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            h1 [] [ text "Loading" ]

        RemoteData.Failure error ->
            generateErrorMessage error
                |> viewError

        RemoteData.Success posts ->
            viewPosts posts


viewError : String -> Html Msg
viewError errorMessage =
    div []
        [ h1 [] [ text "Opps couldn't fetch posts from server" ]
        , text errorMessage
        ]


viewPosts : List Post -> Html Msg
viewPosts posts =
    div []
        [ h1 [] [ text "All posts" ]
        , table []
            (viewTableHeader :: List.map viewPost posts)
        ]


viewTableHeader : Html Msg
viewTableHeader =
    tr []
        [ th [] [ text "ID" ]
        , th [] [ text "Title" ]
        , th [] [ text "Author" ]
        ]


viewPost : Post -> Html Msg
viewPost post =
    tr []
        [ td [] [ text (String.fromInt post.id) ]
        , td [] [ text post.title ]
        , td []
            [ a [ href post.author.url ] [ text post.author.name ]
            ]
        ]
