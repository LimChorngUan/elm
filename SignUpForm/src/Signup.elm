module Signup exposing (main)

import Browser
import Html exposing (Html, button, div, form, h1, input, label, text)
import Html.Attributes exposing (for, id, name, type_, value)
import Html.Events exposing (onClick, onInput)



-- Main


main : Program () User Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



-- Model


type alias User =
    { name : String
    , email : String
    , password : String
    , loggedIn : Bool
    }


initialModel : User
initialModel =
    { name = ""
    , email = ""
    , password = ""
    , loggedIn = False
    }



-- Update


type Msg
    = SaveName String
    | SaveEmail String
    | SavePassword String
    | Signup


update : Msg -> User -> User
update message user =
    case message of
        SaveName name ->
            { user | name = name }

        SaveEmail email ->
            { user | email = email }

        SavePassword password ->
            { user | password = password }

        Signup ->
            { user | loggedIn = True }



-- View


view : User -> Html Msg
view user =
    div []
        [ h1 [] [ text "Sign up" ]
        , form []
            [ div []
                [ label [ for "name" ] [ text "Name" ]
                , input
                    [ type_ "text"
                    , name "name"
                    , id "name"
                    , value user.name
                    , onInput SaveName
                    ]
                    []
                ]
            , div []
                [ label [ for "email" ] [ text "Email" ]
                , input
                    [ type_ "text"
                    , name "email"
                    , id "email"
                    , onInput SaveEmail
                    ]
                    []
                ]
            , div []
                [ label [ for "password" ] [ text "Password" ]
                , input
                    [ type_ "password"
                    , name "password"
                    , id "password"
                    , onInput SavePassword
                    ]
                    []
                ]
            , div []
                [ button [ type_ "submit", onClick Signup ] [ text "Create my account" ]
                ]
            ]
        ]



{--
<div>
  <h1>Sign up</h1>

  <form type="submit">
    <div>
      <label for="name">Name</label>
      <input type="text" name="name" id="name">
    </div>
  </form>
</div>

--}
