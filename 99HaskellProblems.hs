{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.List (reverse)

import System.IO

--Problem #1
myLast :: [a] -> a --type signature
myLast [] = error "No end for empty lists!" --error meesage
myLast [x] = x
myLast (_:xs) = myLast xs

--Problem #2 the last but on elememt
myButLast :: [a] -> a
myButLast = last . init --this shows you have the last except one

--Problem #3 find the K'th element from a list, the 1st element is 1
elementAt :: [a] -> Int -> a
elementAt (x:_) 1  = x
elementAt (_:xs) i = elementAt xs (i - 1)
elementAt _ _      = error "Index out of bounds"

--Problem #3 another implementation through recursion
elementAt' :: [a] -> Int -> a
elementAt' (x:xs) 1 = x
elementAt' (_:xs) n = elementAt' xs (n-1)

--Problem #4 find the length of elements in the list
myLength :: Num a => [t] -> a
myLength xs = sum [1 | _ <- xs] 
{-_ means that we don't care what we'll draw from the list anyway so instead of writing a variable name that we'll never use, we just write _. 
This function replaces every element of a list with 1 and then sums that up. 
This means that the resulting sum will be the length of our list.-}

--Problem #4 second implementation
myLength' :: [a] -> Int
myLength' [] = 0
myLength' (_:xs) = 1 + myLength' xs

--Problem #5 Reverse a list
{-myReverse :: [a] -> [a]
myReverse [] = [] 
myReverse (x:xs) = myReverse xs ++ [x] -- ++ operator appends lists -}

--but this is way easier...
reverse :: [a] -> [a]
reverse =  foldl (flip (:)) []


