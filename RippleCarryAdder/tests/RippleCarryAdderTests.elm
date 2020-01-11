module RippleCarryAdderTests exposing
    ( halfAdderTests
    , inverterTests
    , rippleCarryAdderTests
    )

import Expect
import RippleCarryAdder
    exposing
        ( halfAdder
        , inverter
        , rippleCarryAdder
        )
import Test exposing (Test, describe, test, todo)


inverterTests : Test
inverterTests =
    describe "inverter"
        [ test "input 0 => output 1" <|
            \_ ->
                inverter 0
                    |> Expect.equal 1
        , test "input 1 => output 0" <|
            \_ ->
                inverter 1
                    |> Expect.equal 0
        ]


halfAdderTests : Test
halfAdderTests =
    describe "halfAdder"
        [ test "input 0 0 => sum = 0 and carry = 0" <|
            \_ ->
                halfAdder 0 0
                    |> Expect.equal { carry = 0, sum = 0 }
        , test "input 0 1 => sum = 1 and carry = 0" <|
            \_ ->
                halfAdder 0 1
                    |> Expect.equal { carry = 0, sum = 1 }
        , test "input 1 0 => sum = 1 and carry = 0" <|
            \_ ->
                halfAdder 1 0
                    |> Expect.equal { carry = 0, sum = 1 }
        , test "input 1 1 => sum = 0 and carry = 1" <|
            \_ ->
                halfAdder 1 1
                    |> Expect.equal { carry = 1, sum = 0 }
        ]


rippleCarryAdderTests : Test
rippleCarryAdderTests =
    describe "rippleCarryAdder"
        [ todo "implement fuzz test for this"
        ]
