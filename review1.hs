-- e :: t evaluating expression e produces t
--every expression has a type, type inference is based

--all type errors are found at compile time
--safe high assurance code, plus its faster

-- :t caculates the type of an expression with evaluating it

{-
Bool - For logical values like true false statements

Char - single characters like strings

Sting - Strings of characters

Int - integer numbers

Float - floating point numbers

Lists: a sequence of values in square brackets separated by commas

[False,True,False] :: [Bool]
['a','b','c','d'] :: [Char]

We can have lists of lists

Tuple types: a sequence of values of possibly different types

(False,True) :: (Bool,Bool)
(False,'a',True) :: (Bool,Char,Bool)

use paranthesis for tuples

you can nest lists in tuples.

-}

-- FUNCTION TYPES --

-- A function is a mapping from values of one type to values of another type

{-
not :: Bool -> Bool
even :: Int -> Bool
-}
add :: (Int,Int) -> Int 
add (x,y) = x+y

-- Curried Functions: these are functions with multiple arguments because they return functions as results

add' :: Int -> (Int -> Int)
add' x y = x+y

--the returned function adds x+Y as a result
--the parameters are taken one at a time, so they don't need brackets

--both functions take their arguments differently
--add' takes its arguments one at a time

--here is another curried function

mult :: Int -> (Int -> (Int -> Int))
mult x y z = x*y*z
--mult takes an integer x and returns a function mult x
--this takes an integer y and returns a function x y
--then it finally takes an integer z and returns x*y*z

--currying is helpful because you can make useful functions by partially applying them

--add' 1 :: Int -> Int increments by 1

-- -> arrows are right associative

-- function application bracketts to the left mult x y z ((mult x)y)z

-- Polymorphic functions has type that contains one or more type variables

--length :: [a] -> int
-- length is polymorphic becuase it can be applied to any typoe

{-
MANY OF THE FUNCTIONS IN HASKELL ARE POLYMORPHIC

fst :: (a,b) -> a   Represents first

head :: [a] -> a    returns the head of a list

take :: Int -> [a] -> [a]   takes two parameters, an integer and a list, returning a list

zip :: [a] -> [b] -> [(a,b)]    gives a list of pairs

id :: a -> a        give the function something and it compies it
-}

-- OVERLOADED FUNCTIONS --

--polymorphic finction s is called overloaded when it contains one or more class constraints

-- (+) :: Num => a -> a -> a 
--this is the type for the additon function
--the plus operator has type
--Num a must be a numberic type
-- the real a takes two types and gives one

-- 3 MAIN TYPE CLASSES --

-- Num - Numeric Types
-- Eq -Equality types
-- Ord - ordered types

{-
(+) :: Num => a -> a -> a 

(==) :: Eq a => a -> a -> Bool

(<) :: Ord a => a -> a -> Bool
-}
