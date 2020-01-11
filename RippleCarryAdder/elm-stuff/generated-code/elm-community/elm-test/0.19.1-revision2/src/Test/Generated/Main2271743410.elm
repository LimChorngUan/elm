module Test.Generated.Main2271743410 exposing (main)

import Example
import RippleCarryAdderTests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Example" [Example.suite],     Test.describe "RippleCarryAdderTests" [RippleCarryAdderTests.inverterTests,
    RippleCarryAdderTests.halfAdderTests] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 182721428429748, processes = 12, paths = ["/Users/lcu/Amelia/elm/RippleCarryAdder/tests/Example.elm","/Users/lcu/Amelia/elm/RippleCarryAdder/tests/RippleCarryAdderTests.elm"]}