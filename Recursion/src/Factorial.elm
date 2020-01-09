module Factorial exposing (factorial)


factorial : Int -> Int
factorial n =
    if n == 0 then
        1
    else if n == 1 then
        1
    else
        n * factorial (n - 1)
