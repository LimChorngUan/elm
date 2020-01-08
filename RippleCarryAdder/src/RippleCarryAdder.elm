module RippleCarryAdder exposing
    ( Binary
    , andGate
    , fullAdder
    , halfAdder
    , inverter
    , orGate
    , rippleCarryAdder
    , formatDigits
    )

import Array
import Bitwise


andGate : Int -> Int -> Int
andGate a b =
    Bitwise.and a b


orGate : Int -> Int -> Int
orGate a b =
    Bitwise.or a b


inverter : Int -> Int
inverter a =
    case a of
        0 ->
            1

        1 ->
            0

        _ ->
            -1


type alias AdderResult =
    { sum : Int
    , carry : Int
    }


halfAdder : Int -> Int -> AdderResult
halfAdder a b =
    let
        d =
            orGate a b

        e =
            andGate a b
                |> inverter

        sumDigit =
            andGate d e

        carryOut =
            andGate a b
    in
    { sum = sumDigit
    , carry = carryOut
    }


fullAdder : Int -> Int -> Int -> AdderResult
fullAdder a b carryIn =
    let
        firstResult =
            halfAdder b carryIn

        secondResult =
            halfAdder a firstResult.sum

        finalCarryOut =
            orGate firstResult.carry secondResult.carry
    in
    { sum = secondResult.sum
    , carry = finalCarryOut
    }


type alias Binary =
    { d0 : Int
    , d1 : Int
    , d2 : Int
    , d3 : Int
    }


formatDigits : Int -> List Int
formatDigits number =
  let
      digitsToList n =
        if n == 0 then
            []
          else
             remainderBy 10 n  :: digitsToList ( n // 10 )
  in
    digitsToList number
      |> List.reverse



extractDigits : Int -> Binary
extractDigits number =
    formatDigits number
        |> Array.fromList
        |> arrayToBinary


-- stringToInt : String -> Int
-- stringToInt string =
--     String.toInt string
--         |> Maybe.withDefault -1


arrayToBinary : Array.Array Int -> Binary
arrayToBinary array =
    let
        firstElement =
            Array.get 0 array
                |> Maybe.withDefault -1

        secondElement =
            Array.get 1 array
                |> Maybe.withDefault -1

        thirdElement =
            Array.get 2 array
                |> Maybe.withDefault -1

        fourthElement =
            Array.get 3 array
                |> Maybe.withDefault -1
    in
    { d0 = firstElement
    , d1 = secondElement
    , d2 = thirdElement
    , d3 = fourthElement
    }


numberFromDigits : List Int -> Int
numberFromDigits digitsList =
  List.foldl (\digit number -> number * 10 + digit) 0 digitsList

rippleCarryAdder : Int -> Int -> Int -> Int
rippleCarryAdder a b carryIn =
    let
        firstSignal =
            extractDigits a

        secondSignal =
            extractDigits b

        firstResult =
            fullAdder firstSignal.d3 secondSignal.d3 carryIn

        secondResult =
            fullAdder firstSignal.d2 secondSignal.d2 firstResult.carry

        thirdResult =
            fullAdder firstSignal.d1 secondSignal.d1 secondResult.carry

        finalResult =
            fullAdder firstSignal.d0 secondSignal.d0 thirdResult.carry

    in
        [ finalResult, thirdResult, secondResult, firstResult ]
          |> List.map .sum
          |> (::) finalResult.carry
          |> numberFromDigits
