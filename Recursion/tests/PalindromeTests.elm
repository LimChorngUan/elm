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
                        |> Expect.true "empty string is palindrome"
            , test "single character" <|
                \_ ->
                    palindrome "a"
                        |> Expect.true "single character is palindrome"
            , test "rotor" <|
                \_ ->
                    palindrome "rotor"
                        |> Expect.true "rotor is palindrome"
            , test "xyzyzyx" <|
                \_ ->
                    palindrome "xyzyzyx"
                        |> Expect.true "xyzyzyx is palindrome"
            , test "RotOr" <|
                \_ ->
                    palindrome "RotOr"
                        |> Expect.true "RotOr is palindrome"
            ]
        , describe "is not palindrome"
            [ test "motor" <|
                \_ ->
                    palindrome "motor"
                        |> Expect.false "motor is not palindrome"
            , test "GmbH" <|
                \_ ->
                    palindrome "GmbH"
                        |> Expect.false "GmbH is not palindrome"
            ]
        ]
