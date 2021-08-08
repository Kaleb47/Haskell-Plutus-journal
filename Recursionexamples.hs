--impoirt some modules to make the functions work!!!!



and :: [Bool] -> Bool
and [] = True --True is the identity for logical and
and bs = foldr (\ b -> False && _ = False) True bs --b is a single boolean value, the remaining list will give us back a bollean value as well

{-
--next example is concatentation
concat :: [[a]] -> [a]
concat [] = []
concat (xs:xss) = xs ++ concat' xss 

--replicate
replicate :: Int -> a -> [a]
replicate 0 x = []
replicate n x = x : replicate' (n-1) x --this allows to replicate something by emitting one copy

--index
(!!) :: [a] -> Int -> a --this is a curried polymorphic function
(x:_) !! 0 = x
(_:xs) !! n = xs !! (n-1)   --can only work on non-empty lists
--not all of the vairbales are used in the two equations


--insert
insert :: Int ->  [Int] -> [Int] --insert takes an integer and a list of integers and puts that number into the correct position in that sorted list
insert x [] = [x]
insert x (y:ys) =  if x =< y then
                   x:y:ys
                   else 
                   y : insert x ys     
--we need our function copy values from any given list until it finds a value bigger than the one we're inserting


--Insertion Sort
isort :: [Int] -> [Int]
isort [] = []
isort (x:xs) = insert x (isort xs)    

--merge sort
merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) = if x =< y then
                        x : merge xs (y:ys)       
                        else
                            y : merge (x:xs) ys


--merge sort, this dependent on the preceding function
msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort xs = merge (msort ys) (msort xs) --two sorted lists are now merged
                where (ys, zs) = halve xs
                -}
