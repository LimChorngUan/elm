module Signup exposing (main)

import Html exposing (Html, div, h1, form, label, input, text, button)
import Html.Attributes exposing (for, type_, id, name)


main : Html msg
main =
  view initialModel

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


view : User -> Html msg
view user =
  div []
    [ h1 [] [text "Sign up"]
    , form []
      [ formFieldView "text" "name" "Name"
      , formFieldView "email" "email" "Email"
      , formFieldView "password" "password" "Password"
      , div []
        [ button [type_ "submit"] [text "Create my account"]
        ]
      ]
    ]


formFieldView : String -> String -> String -> Html msg
formFieldView typeName nameText labelText =
  div []
    [ label [for nameText] [text labelText]
    , input [type_ typeName, name nameText, id nameText ] []
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