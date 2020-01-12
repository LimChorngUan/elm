module GetAdultAge exposing ( getAdultAges, persons )

type alias Person =
    { name : String
    , age : Maybe Int
    }


amelia : Person
amelia = Person "Amelia" <| Just 18


min : Person
min = Person "Min" <| Just 27


jim : Person
jim = Person "Jim" <| Nothing


svenja : Person
svenja = Person "Svenja" <| Just 15


monti : Person
monti = Person "Monti" <| Just 100


persons : List Person
persons = [amelia, min, jim, svenja, monti]


getAdultAges : List Person -> List Int
getAdultAges personsList =
  List.filterMap getAdultAge personsList


getAdultAge : Person -> Maybe Int
getAdultAge person =
  .age person
    |> Maybe.andThen validateAge


validateAge : Int -> Maybe Int
validateAge age =
  if age >= 18 then
    Just age

  else
    Nothing