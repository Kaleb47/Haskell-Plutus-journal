{-# OPTIONS_GHC -Wno-incomplete-patterns #-}


{-what happens when you mutliply 3 5 9. Well, programitcall, it would look like this:
((multThree 3) 5) 9
3 is applied to multThree first because they are separated by a space
It looks like Polish notation, takes one function, 3, as a parameter and returns another function to 
start the process all over again. so now its 15 * 9
-}

multThree :: (Num a) => a -> a -> a -> a  
multThree x y z = x * y * z  

{-if we call the function below with a 99 it returns a GT.
    Comparre 100 returns functions that takes number and compares it with 100
    -}
compareWithHundred :: (Num a, Ord a) => a -> Ordering  
compareWithHundred x = compare 100 x  

{-this function below contains an infix that takes one parameter.
-}
divideByTen :: (Floating a) => a -> a  
divideByTen = (/10)  

{-in the type signature, the parantheses indicates that the first parameeter is a function
the second parameter is something of the type and the return value is that same type

-}
applyTwice :: (a -> a) -> a -> a  
applyTwice f x = f (f x) 

{-this takes a function and two lists as parameters, joins the two lists by applying the function between corresponding
elements-}
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  {-first parameter is a function that takes two things and produces a third thing-}
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys  


{-this takes a function and returns the same function but flips the arguments-}
flip' :: (a -> b -> c) -> (b -> a -> c)  
flip' f = g  
    where g x y = f y x  

{-applies a finction to the list returining it to the list-}
map' :: (a -> b) -> [a] -> [b]  
map' _ [] = []  
map' f (x:xs) = f x : map' f xs  

{-filters, in this case, take predictes
if p x evaluates to True the elements gets included in the list-}
filter' :: (a -> Bool) -> [a] -> [a]  
filter' _ [] = []  
filter' p (x:xs)   
 | p x       = x : filter' p xs  
 | otherwise = filter' p xs  

quicksort :: (Ord a) => [a] -> [a]    
quicksort [] = []    
quicksort (x:xs) =     
    let smallerSorted = quicksort (filter (<=x) xs)  
        biggerSorted = quicksort (filter (>x) xs)   
    in  smallerSorted ++ [x] ++ biggerSorted  

    {-the following function is a Collatz function, this type of function
    takes a natural number, if its even, divides it by 2. If its odd, 
        then you multiply it by 3 and add 1-}

chain :: (Integral a) => a -> [a]  
chain 1 = [1]  
{-Because the chains end at 1, that's the edge case. standard recursive function-}
chain n  
    | even n =  n:chain (n `div` 2)  
    | odd n  =  n:chain (n*3 + 1)  

{-first we map the chain function to [1..100] 
Next we filter them by a predicate that checks if a lists length is longer than 15
    When filtering is done, we'll see the remaining chains
    
    This function has a type of numLongChains :: Int because 
    length returns an Int instead of a Num a for historical reasons. 
    If we wanted to return a more general Num a, 
    we could have used fromIntegral on the resulting length.
    
     -}
numLongChains :: Int  
numLongChains = length (filter isLong (map chain [1..100]))  
    where isLong xs = length xs > 15  

{-rather than using a where binding like we did above, we can use a lambda to pass it in the function-}
numLongChains' :: Int  
numLongChains' = length (filter (\xs -> length xs > 15) (map chain [1..100]))  {-the expression returns a function that tells us whether the length of the list passed is greater than 5-}


{-our first fold-}
sum'' :: (Num a) => [a] -> a  
sum'' xs = foldl (\acc x -> acc + x) 0 xs  
{- \acc x -> acc + x is the binary function, 0 is the starting value and xs is the list that gets folded up-}

{-elem with a fold on the left
starting value and accumulator are boolean
-}

elem'' :: (Eq a) => a -> [a] -> Bool  
elem'' y ys = foldl (\acc x -> if x == y then True else acc) False ys  


--sum . replicate 5 . max 6.7 $ 8.9 sum can be written as that

{-
replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8])))
replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]
if an expression ends in three paranthesis, use 3 operators make it cleaner


    sum' :: (Num a) => [a] -> a 
    sum' = foldl (+) 0
thanks to curing we can omit the xs on both sides, this is point freestyle

function written ordinarily vs function written in point free style
fn x = ceiling (negate (tan (cos (max 50 x)))) 

fn = ceiling . negate . tan . cos . max 50
remove x and remove parantheses through function composition

applyTwice :: (a -> a) -> a -> a  
applyTwice f x = f (f x)
 the above function returns an elements twice
keep in mind that parranthesis are needed for type declaration

Partially applied functions: we can take a function with a single argument,
"partially apply it to the point where it takes only one more argument, and then pass that function as if it always only takes one argument"


    zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys 

	ghci> zipWith' (+) [4,2,5,6] [2,6,2,3]  
[6,8,7,9]  
ghci> zipWith' max [6,3,2,1] [7,3,1,5]  
[7,3,2,5]  
ghci> zipWith' (++) ["foo ", "bar ", "baz "] ["fighters", "hoppers", "aldrin"]  
["foo fighters","bar hoppers","baz aldrin"]  
ghci> zipWith' (*) (replicate 5 2) [1..]  
[2,4,6,8,10]  
ghci> zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]  
[[3,4,6],[9,20,30],[10,12,12]] 

as you can see, zipWith applies one list to another, each element to the other

the best way to know the behavior of the functions is just use the ghci to make function calls

flip' :: (a -> b -> c) -> b -> a -> c  
flip' f y x = f x y 
this function returns the same parameters but it is flipped

ghci> flip' zip [1,2,3,4,5] "hello"  
[('h',1),('e',2),('l',3),('l',4),('o',5)]  
ghci> zipWith (flip' div) [2,2..] [10,8,6,4,2]  
[5,4,3,2,1] 


filter :: (a -> Bool) -> [a] -> [a]  
filter _ [] = []
filter p (x:xs)   
        | p x       = x : filter p xs  
        | otherwise = filter p xs 


Remember that in Haskell, string is just syntactic sugar for [Char]. 
takeWhile will start from the beginning of the string and will return a list of all characters until the predicate is not satisfied. 

Lambdas are specifically used for higher order functions

map (+3) [1,6,3,2] 
map (\x -> x + 3) [1,6,3,2]
both of these functions arre equivalent
-}




maximum'' :: (Ord a) => [a] -> a  
maximum'' = foldr1 (\x acc -> if x > acc then x else acc)  
  
{-value from our empty list We take a starting value of an empty list 
and then approach our list from the left and just prepend to our accumulator. 
In the end, we build up a reversed list. \acc x -> x : acc kind of looks like the : 
function, only the parameters are flipped.-}
reverse'' :: [a] -> [a]  
reverse'' = foldl (\acc x -> x : acc) []  
  
product'' :: (Num a) => [a] -> a  
product'' = foldr1 (*)  
  
filter'' :: (a -> Bool) -> [a] -> [a]  
filter'' p = foldr (\x acc -> if p x then x : acc else acc) []  
  
head'' :: [a] -> a  {-you're better off using pattern matching but it can still be done with folds-}
head'' = foldr1 (\x _ -> x)  
  
last'' :: [a] -> a  
last'' = foldl1 (\_ x -> x) 
