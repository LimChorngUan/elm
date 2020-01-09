module FactorialTest exposing (suite)

import Expect
import Factorial exposing (factorial)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "factorial function"
        [ test "factorial of 0 is 1" <|
            \_ -> Expect.equal 1 (factorial 0)
        , test "factorial of 1 is 1" <|
            \_ -> Expect.equal 1 (factorial 1)
        , test "factorial of 3 is 6" <|
            \_ -> Expect.equal 1 (factorial 1)
        , test "factorial of 5 is 120" <|
            \_ -> Expect.equal 120 (factorial 5)
        , test "factorial of 10 is 3628800" <|
            \_ -> Expect.equal 3628800 (factorial 10)
        ]
