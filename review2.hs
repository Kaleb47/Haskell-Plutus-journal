-- DEFINING FUNCTIONS --

--conditional expressions simply mean if then else

 --abs :: Int -> Int 
 --abs n = if n >= 0 then n else -n

 --remember abs takes an integer n and returns n if it is non-negative and -n otherwise

--conditional expressions can be nested 

--signum :: Int -> Int 
--signum n = if n < 0 then -1 else
                --if n == 0 then 0 else 1

 -- vs
{-
 signum` n  | n < 0      = -1
            | n == 0    = 0
            | otherwise = 1         
-}
--Guarrded equations: 

abs :: (Ord p, Num p) => p -> p
abs n | n >= 0      = 0
      | otherwise   = -n 


-- PATTERN MATCHING --
--functions have clear arguments based on their type signatures
-- this known as pattern matching

not :: Bool -> Bool 
not False = True 
not True = False

--not maps False to True, and True to False

-- A function can be defined in a number of ways

--Think which is more efficient?

(&&) :: Bool -> Bool -> Bool 
True && True = True 
True && False = False 
False && True = False 
False && False = False 

-- or...

True && True = True 
_ && _ = False 

--obviously, you want the cleaner more efficient example
--it avoids evaluating the second argument if the first argument is false

--PATTERNS ARE MATCHED IN ORDER FROM TOP TO BOTTOM

{-
_ && _ = False
True && True = True

the following definition will always return false


Patterns CANNOT repeat variables 

b && b = b
_ && _ = False 

-}

--List Patterns

--internally, every non-empty list constructed by repeated use of an operator use (:)

-- [1,2,3,,5] == 1:()

--Functions can be defined using list patterns (x:xs)

head :: [a] -> a
head (x:_) = x

tail :: [a] -> [a]
tail (_:xs) = xs

--The above functions map any non-empty list to its first elements
--as well as the rest of the remaining elements

-- THE LAMBDA EXPRESSIONS

-- \x -> x + x

--the above function takes x and returns x+x
-- the lambda is good for nameless functions

--these are used to give a formal menaing to functions defined using currying

add :: Int -> (Int -> Int)
add = \x -> (\y -> x + y)

{-
Lambda expression can be used to avoid naming nctions that are only referenced once

odds n = map f [0.. n-1]
        where
            f x = x*2 +1

 can be simplified to 

 odds n = map (\x -> x*2 + 1) [0..-1]           

 -- OPERATOR EXPRESSIONS --

 -- you can write the operator before the element if you used curried functions
     -- (+) 2 2


-- (1+) - successor function
-- (1/) - reciprocation function
-- (*2) - doubling functions
-- (/2) - halving functions


-}
{-
-- Exercise #1
--we're calling a tail function that we did not write

safetail xs = if null xs then
                    []
                    else 
                        tail xs
                        
                        
safetail xs | null xs = []
            | otherwise = tail xs

safetail [] = []
safetail (x:xs) = xs

False || False = False
False || True = True
True || False = True
True || True = True

False || False = False
_ || _ = True

False || b = b
True || _ =    True

this is how logical or is used 

-}
