module FuzzExample exposing (addOneTests, addTests, flipTests, listLengthTests, arrayGetTests)

import Array
import Expect
import Fuzz exposing (int, bool, list, array, intRange)
import Test exposing (Test, describe, fuzz, fuzz2)


addOne : Int -> Int
addOne x =
  x + 1


add : Int -> Int -> Int
add x y =
  x + y


flip : Bool -> Bool
flip value =
  not value


addOneTests : Test
addOneTests =
  describe "addOne"
      [ fuzz int "adds 1 to any integer" <|
          \randomNum ->
              addOne randomNum
                |> Expect.equal (randomNum + 1)
      ]


addTests : Test
addTests =
  describe "add"
      [ fuzz2 int int "adds two integer" <|
          \num1 num2 ->
              add num1 num2
                  |> Expect.equal (num1 + num2)
      ]


flipTests : Test
flipTests =
  describe "flip"
      [ fuzz bool "negate bool value" <|
          \value ->
            flip value
              |> Expect.equal(not value)
      ]


listLengthTests : Test
listLengthTests =
  describe "List.length"
      [ fuzz (list int) "never returns a negative value" <|
          \intList ->
              List.length intList
                |> Expect.atLeast 0
      ]


arrayGetTests : Test
arrayGetTests =
  describe "Array.get"
      [ fuzz (array (intRange -10 10)) "returns Nothing for out of range index" <|
          \array ->
            let
              length =
                Array.length array
            in
              array
                |> Array.get length
                |> Expect.equal Maybe.Nothing
      ]