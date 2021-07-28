

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