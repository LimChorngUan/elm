module Profile exposing (createName)

-- opaque type


type Name
    = Name String String


createName : String -> String -> Name
createName firstName lastName =
    Name firstName lastName
