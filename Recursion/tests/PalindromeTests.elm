module PalindromeTests exposing (palindromeTests)

import Expect
import Palindrome exposing (palindrome)
import Test exposing (Test, describe, test)


palindromeTests : Test
palindromeTests =
    describe "palindrome"
        [ describe "is palindrome"
            [ test "empty string" <|
                \_ ->
                    palindrome ""
                        |> Expect.true
            , test "single character" <|
                \_ ->
                    palindrome "a"
                        |> Expect.true
            , test "rotor" <|
                \_ ->
                    palindrome "rotor"
                        |> Expect.true
            , test "xyzyzyx" <|
                \_ ->
                    palindrome "xyzyzyx"
                        |> Expect.true
            , test "RotOr" <|
                \_ ->
                    palindrome "RotOr"
                        |> Expect.true
            ]
        , describe "is not palindrome"
            [ test "motor" <|
                \_ ->
                    palindrome "motor"
                        |> Expect.false
            ]
        ]
