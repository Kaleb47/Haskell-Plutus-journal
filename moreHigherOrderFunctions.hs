{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
map :: (a -> b) -> [a] -> [b]
map f xs = [f x | x <- xs]
--maps can be defined using list comprehensions

--alternatively, you can define a map function through recursion
map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x:xs) = f x : map' f xs


--filter
filter :: (a -> Bool) -> [a] -> [a] --the guard filters at things that satisfy the property
filter p xs = [x | x <- xs, p x]
--filters can be defined using list comprehensions

--and of course filters can be defined through recurison
filter' :: (a -> Bool) -> [a] -> [a]
filter' p (x:xs)
    | p x       = x : filter' p xs --if the property is true, we're keeping it
    | otherwise = filter' p xs --otherwise they filterr it

--fold example function
sum :: Num p => [p] -> p
sum [] = 0
sum xs = foldr (+) 0 xs --sum (x:xs) =  x + sum xs

product :: Num p => [p] -> p
product [] =1
product xs = foldr (*) 1 xs -- product (x:xs) = x * product xs

and :: [a] -> Bool
and [] = True
and xs = foldr (&&) True a --and (x:xs) = x && and xs

--foldr can also be used in recursion
foldr' :: (a -> b -> b) -> b -> [a] -> b --
foldr' f v [] = v --if you apply foldrr with a function f and you have a value, v, that is what you will return in the base case
foldr' f v (x:xs) = f x (foldr' f v xs) --if you'r folding and you have function f and value v, you recursively fold the remainder of the list

    --remember, summation is just foldr (+)

    {-
    sum [1,2,3]
    =
        foldr (+) 0 [1,2,3]
    =
        foldr (+)  0 (1:(2:(3:[])))
    =
        1+(2+(3+0))    
    =
        6

        here we replace (:) by (+) and [] by 0


        product [1,2,3]
       =
           foldr (*) 1 [1,2,3]
       =
           foldr (*) 1 (1:(2:(3:[])))    
       =
           1*(2*(3*1))      
       =
           6

           Replace (:)  by (*) and [] by 1    
    
    Length can also be defined as a fold

        length [1,2,3]
    =
        length (1:(2:(3:[])))    
    =
        1+(1+(1+0))
    =
        3

        Replace each (:) by lambda_n->1+n and [] by 0
        the function would take two parameters, the first one is _ and the second one is n and replace the empty list with 0

        so length can be called like so

        length = foldr (\_ n -> 1+n) 0

        reverse can be defined by fold too like so

        reverse = foldr (\x xs -> xs ++ [x]) []       

        remember what append is used for

        (++ ys) = foldr (:) ys replace each [] with ys 
    
    -}

--the library function (.) returns the COMPOSITION of two functions as a single function

(.) :: (b -> c) -> (a -> b) -> (a -> c)
f . g = \x -> f (g x)

--you are simply applying one function after another

odd :: Int -> Bool
odd = not Prelude.. even
-- the ood function is simp0ly a composition of the not function after the even function


all :: (a -> Bool) -> [a] -> Bool 
all p xs = Prelude.and [p x| x <- xs] --this function decides if any element in a list satisfies a given predicate

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile p [] = []
takeWhile p (x:xs)
    | p x           = x : Prelude.takeWhile p xs
    | otherwise = []

    --take while takes elements that satisfiy a predicate until it finds an element that doesn't until it stops

    --dropwhile does the opposite
{-
    dropWhile :: (a -> Bool) -> [a] -> [a]
    dropWhile p [] = []
    dropWhile p (x:xs) 
                | p x       = dropWhile p xs
                | otherwise = x:xs
                -}

                {-
                what are higher-order functions that returns as results better known as?

                take :: Int -> ([a] -> [a])

                Express [f x | x <- xs, p x] using map and filter.

                map f (filter p xs)
                we're ranging over each value in the list that will only satisfy the property p
                -}
