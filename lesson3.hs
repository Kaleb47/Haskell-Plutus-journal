import System.IO

 
 
myCompare :: (Ord a) => a -> a -> Ordering  
a `myCompare` b  
    | a > b     = GT  
    | a == b    = EQ  
    | otherwise = LT 

{-as you can see, the expression below is matched against the patterns-}

{-case expression of pattern -> result  
                   pattern -> result  
                   pattern -> result  
                   ...   -}

                   
describeList :: [a] -> String  
describeList xs = "The list is " ++ what xs  
    where what [] = "empty."  
          what [x] = "a singleton list."  
          what xs = "a longer list."  

{-this is replicate recursion. For example, you type in replicate' 5 5, the number 5 will be replicated 5 times-}

replicate' :: (Num i, Ord i) => i -> a -> [a]  
replicate' n x  
    | n <= 0    = []  
    | otherwise = x:replicate' (n-1) x 

{-take takes a specific set of variables from a list. The first pattern specifies that if you try to take a zero or negative number 
    the list will be empty. The third pattern breaks the list into a head and tail-}

take' :: (Num i, Ord i) => i -> [a] -> [a]  
take' n _  
    | n <= 0   = []  
take' _ []     = []  
take' n (x:xs) = x : take' (n-1) xs  

{-reverse reverse's a list-}

reverse' :: [a] -> [a]  {-type signature-}
reverse' [] = []  
reverse' (x:xs) = reverse' xs ++ [x]  {-list is binded and clarifies that we want variables to be reverse-}

{-repeat takes an element and returns an infinite list of that element-}
repeat' :: a -> [a]  
repeat' x = x:repeat' x  


{-zip combines two lists by truncating the longer list-}
zip' :: [a] -> [b] -> [(a,b)]  
zip' _ [] = []  
zip' [] _ = []  
zip' (x:xs) (y:ys) = (x,y):zip' xs ys 

{-elem-}
elem' :: (Eq a) => a -> [a] -> Bool  
elem' a [] = False  
elem' a (x:xs)  
    | a == x    = True  
    | otherwise = a `elem'` xs   


{-this is quick sort. the algorithm will take the 
head and put it in between lists that are bigger and smaller than it-}
quicksort :: (Ord a) => [a] -> [a]  
quicksort [] = []  
quicksort (x:xs) =   
    let smallerSorted = quicksort [a | a <- xs, a <= x]  
        biggerSorted = quicksort [a | a <- xs, a > x]  
    in  smallerSorted ++ [x] ++ biggerSorted  