module MyList exposing (MyList(..), sum, isEmpty, x, y)

type MyList a
    = Empty
    | Node a (MyList a)


sum : MyList Int -> Int
sum xs =
    case xs of
        Empty ->
            0

        Node elValue remainingNodes ->
            elValue + sum remainingNodes


isEmpty : MyList a -> Bool
isEmpty xs =
    case xs of
       Empty ->
          True
       _ ->
          False


x : MyList a
x = Empty


y : MyList Int
y = Node 1 (Node 2 Empty)