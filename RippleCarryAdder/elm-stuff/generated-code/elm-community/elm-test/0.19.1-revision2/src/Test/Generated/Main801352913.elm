module Test.Generated.Main801352913 exposing (main)

import Example
import RippleCarryAdderTests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Example" [Example.suite],     Test.describe "RippleCarryAdderTests" [RippleCarryAdderTests.inverterTests] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 42654702261739, processes = 12, paths = ["/Users/lcu/Amelia/elm/RippleCarryAdder/tests/Example.elm","/Users/lcu/Amelia/elm/RippleCarryAdder/tests/RippleCarryAdderTests.elm"]}