module Posts exposing (main)

import Browser
import Html exposing (Html, button, div, h1, table, td, text, th, tr, a)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (required, optional)


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
    { posts : List Post
    , errorMessage : Maybe String
    }


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
        ( { posts = []
          , errorMessage = Nothing
          }
        , Cmd.none
        )



-- UPDATE


type Msg
    = SendHttpRequestToGetPosts
    | ReceivedData (Result Http.Error (List Post))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequestToGetPosts ->
            ( model, getPosts )

        ReceivedData (Ok posts) ->
            ( { model
                | posts = posts
                , errorMessage = Nothing
              }
            , Cmd.none
            )

        ReceivedData (Err httpError) ->
            ( { model
                | errorMessage = Just (generateErrorMessage httpError)
              }
            , Cmd.none
            )


getPosts : Cmd Msg
getPosts =
    Http.get
        { url = url
        , expect = Http.expectJson ReceivedData (list postDecoder)
        }


postDecoder : Decoder Post
-- postDecoder =
--     map3 Post
--         (field "id" int)
--         (field "title" string)
--         (field "author" string)

-- postDecoder =
--     Decode.succeed Post
--         |> required "id" int
--         |> required "title" string
--         |> optional "author" string "anonymous"

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
        [ button [ onClick SendHttpRequestToGetPosts ] [ text "Get posts from server" ]
        , viewErrorOrPosts model
        ]


viewErrorOrPosts : Model -> Html Msg
viewErrorOrPosts model =
    case model.errorMessage of
        Just errorMessage ->
            viewError errorMessage

        Nothing ->
            viewPosts model.posts


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
