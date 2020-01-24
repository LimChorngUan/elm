-- err this file shouldn't belong to this folder but whatever

module Palindrome exposing (palindrome)


palindrome : String -> Bool
palindrome str =
  let
    lowerCaseStr =
      String.toLower str

    lowerCaseReversedStr =
      String.toLower str
        |> String.reverse
  in
    lowerCaseStr == lowerCaseReversedStr