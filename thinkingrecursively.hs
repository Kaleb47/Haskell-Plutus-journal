-- what are recursive functions?
--a function defined in terms of itself

--why are recursive functions useful?
--many functions inHaskell have recursive definitions, also you can't do loops.
--if you write your functions rrecursively, you can use induction which excellent for mathematical reasoning

--why are recursive functions difficult?
--its very different from other imperative languages. no loops

--Define a function that calculates the sum of a list of humbers
-- Stage 1: Name the function. Keep it short keep it simple. Sum
-- Stage 2: write down the type of the function. Sum :: [Int] -> Int
--Stage 3: Enumerate the cases for the function
{-
Sum :: [Int] -> Int
Sum [] =
Sum (x:xs) =    
-}
--at this point you have written the skeleton of the function
--these default pattern matchings may not be correct for this particular function but you can always revise them later on
--Stage 4: Define the simple cases for the function.
{-
Sum :: [Int] -> Int
Sum [] = 0
Sum (x:xs) =   

    by definition, to find the sum of the empty list, the rright base case is 0
    the simple cases are often but not always base cases 
-}
--Stage 5: List the "ingredients"
{-
Sum :: [Int] -> Int
Sum [] = 0
Sum (x:xs) =  recursive case 
when trying to complete recursive case, we got the type signaturre
reflect on what you have available to you to complete the recursive case
-}
--Stage 6: Define the other cases
{-
Sum :: [Int] -> Int
Sum [] = 0
Sum (x:xs) = x + sum xs

this is known as primitive recursion
-}

--Stage 7: think about the result
{-
Sum :: Num a => [a] -> a
Sum [] = 0
Sum (x:xs) = x + sum xs

Here the type signature here is much more simple, you take a list of elements, return one element providing that the elements
belong to the numeric type class

another way to simplifiy this recursive function

Sum :: Num a => [a] -> a
Sum = foldr (+) 0

foldr capture the pattern of primitive recursion giving you a one liner

-}



-- Define a function that drops a given number of elements at the start of the list
-- this is library function
{- 
This is a curried function because we are taking multiple parameters
this is also a polymorphic function because we're taking one function to return another

drop :: Int -> [a] -> [a]
drop 0 [] = []
drop 0 (x:xs) = x:xs
drop n [] = []
drop n (x:xs) = drop (n-1) xs

or

drop :: Int -> [a] -> [a]
drop 0 xs = xs
drop _ [] = []
drop n (_:xs) = drop (n-1) xs

-}

--Define a function that removes the last element from a non-empty list

{-
init :: [a] -> [a]
init (x:xs) | null xs = []
            | otherwise = x : init xs
the function only has to be defined for non-empty lists.
in the first case, you are checking if the list is empty
otheriwise the last element is removed from the list

the same thing can be done through pattern matching

init :: [a] -> [a]
init [_] = []
init (x:xs) = x : init xs

refer to the standard library

-}
