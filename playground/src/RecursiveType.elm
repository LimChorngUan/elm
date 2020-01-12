module RecursiveType exposing (myList, myTree, sumMyList)


type MyList a
    = Empty
    | Node a (MyList a)



-- [16, 5, 31, 9]


myList : MyList Int
myList =
    Node 16 (Node 5 (Node 31 (Node 9 Empty)))


sumMyList : MyList Int -> Int
sumMyList list =
    case list of
        Empty ->
            0

        Node elValue remainingNodes ->
            elValue + sumMyList remainingNodes


type MyTree a
    = TreeEmpty
    | TreeNode a (MyTree a) (MyTree a)


myTree : MyTree Int
myTree =
    TreeNode 1
        (TreeNode 2
            (TreeNode 4
                TreeEmpty
                (TreeNode 5
                    TreeEmpty
                    TreeEmpty
                )
            )
            (TreeNode 5
                TreeEmpty
                TreeEmpty
            )
        )
        (TreeNode 3
            (TreeNode 6
                TreeEmpty
                TreeEmpty
            )
            (TreeNode 7
                (TreeNode 9
                    TreeEmpty
                    TreeEmpty
                )
                TreeEmpty
            )
        )
