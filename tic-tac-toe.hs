

main :: IO()
main = undefined

startTicTacToe :: [Board] -> Char -> IO ()
startTicTacToe  = undefined
-- here I created a data type that describes a board spot to be spot number or player character with
-- a typeclass of Eq(to compare two values of this data type)
-- this will allow me to make different states of the gameboard [Spot 1, Spot 2, Spot 3, Spot 4, Spot 5, Spot 6, Spot 7, Spot 8, Spot 9]
-- to [Spot 1, Spot 2, Spot 3, Spot 4, Spot 5, Spot 6, Spot 7, Spot 8, Player 'X'] and they are not the same
data Board = Spot Int | Player Char deriving Eq

--  this part was hard to make an instance to show just 1 character aka Player 'X' == "X" and Spot 1 == "1".
-- at first I was getting an error on why show (Player l) = l and it was saying couldn't match type 'Char' with '[Char]'
-- what I had was show Player l = l
-- I used google to find the syntax to derive an instance and found it on stack overflow https://stackoverflow.com/questions/4418017/new-instance-declaration-for-show/4418093
instance Show Board
    where
    show (Spot n) = show n
    show (Player l) = [l]

-- next step was for me to make my list of board spots to have it players input ('X' and 'O') to be put in place of each element in the list.
-- since I can't change the original list I can make new board with every list updated but took me a while to figure out how I was going to
-- do that in Haskell. from here I searched how to replace individual list elements in haskell and on stack overflow it gave me an idea how I should
-- approach this. https://stackoverflow.com/questions/5852722/replace-individual-list-elements-in-haskell
-- this helper function takes the list and splits it at the nth spot and creates a left and right side
-- then it creates the right side where it is split at and the left drops the tail and returns the rest
-- returning two list with the nth removed from the list.
-- finally had to make a function that would take a list, index, and player character (X or O). AND join them all together with the player Character.
-- There was a lot of trial and error. This part took a while to make sure sytax was right and trying to get the result I wanted.

removeEle :: Int -> [a] -> ([a], [a])
removeEle index list = (left, right)
    where
        (s, right) = splitAt index list
        left = init s

insertChar :: [a] -> Int -> a -> [a]
insertChar list idx c = left ++ [c] ++ right
    where (left, right) = removeEle idx list

-- next thing that popped in my head was to make sure we can see a game board and how to display it. I wanted to just print out each row and created a function
-- that takes in 3 parameters and displays them. At first I was getting in the terminal ""1X3\n-----------\n456\n-----------\n78[O]"" when I entered showBoard [Spot 1, Player 'X', Spot 3, Spot 4, Spot 5, Spot 6, Spot 7, Spot 8, Player 'O'].
-- -- I didn't know why I was getting a square bracket on my last element.
-- showBoard (a:b:c:d:e:f:g:h:i) = (show a) ++ (show b) ++ (show c) ++ "n" ++ (show d) ++ (show e) ++ (show f) ++ "n" ++ (show g) ++ (show h) ++ (show i)
-- Showing the whole board at once did not work as I was trying to put a 3 by 3 shape in the terminal so I had to create each row and have a top middle and bottom section.
-- this section was a trial an error part with was a headache but I felt my brain grow and I accidently stubbled across why I was getting a square bracket end where I had
-- to add another element as a parameter and saw it on stack overflow.
showBoardRow (a:b:c:ds) = (show a) ++ (show b) ++ (show c)


-- this is as far as I got in the practice. My next step was to try and map my rows to display the 3 by 3 board. I was looking at
-- intercalate to proceed to do this and trial an error to see if I could get what I wanted.
-- https://hackage.haskell.org/package/base-4.16.0.0/docs/Data-List.html#v:intercalate
