import Data.List (nub, sort, transpose, inits, tails)  --you can selectively import functions
{-import Data.List hiding (nub)  you're importing all functions accept the nub-}
-- import qualified Data.Map as M  
-- Now, to reference Data.Map's filter function, we just use M.filter
import qualified Data.Map as M
import qualified Data.Set
import qualified Data.Char as Char --qualified imports need as, so call data.Char
  
numUniques :: (Eq a) => [a] -> Int  
numUniques = length . nub  

search :: (Eq a) => [a] -> [a] -> Bool  
search needle haystack =   
    let nlen = length needle  
    in  foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)  

    --Haskells version of Caesar's cipher
    
encode :: Int -> String -> String  
encode shift msg = 
    let ords = map ord msg  
        shifted = map (+ shift) ords  
    in  map chr shifted  

ord :: Char -> b
ord = error "not implemented"
chr :: Int -> Char
chr = error "not implemented"

findKey :: (Eq k) => k -> [(k,v)] -> Maybe v  
findKey key = foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing  

  

