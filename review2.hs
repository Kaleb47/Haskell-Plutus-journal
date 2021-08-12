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

      
