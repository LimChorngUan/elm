module Test.Generated.Main1339323827 exposing (main)

import FactorialTest

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "FactorialTest" [FactorialTest.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 372988443168934, processes = 12, paths = ["/Users/lcu/Amelia/elm/Recursion/tests/FactorialTest.elm"]}