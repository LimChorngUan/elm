module Example exposing (suite)

import Expect
import Test exposing (Test, test)


suite : Test
suite =
    test "2 + 2 = 4" <|
        \_ ->
            2
                + 2
                |> Expect.equal 4
