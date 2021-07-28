import System.IO
import Data.List

doubleMe x = x + x 

doubleUs x y = doubleMe x + doubleMe y  

doubleSmallNumber x = if x > 100  
                        then x  
                        else x*2 

doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

rickSanchez = "Wabalaba dub dub!"

morty = "Oh man, oh jeez!"

rickSanchez' = "I'm Pickle Riiiiiiiiiicccccccck"

 {-take a number between 50 and 100 divide by 7 (mod) and make sure that the dividend is 3-}

  {-x*y, 2x*2y, 3x*3y-}

 {-rather than writng a specific varable, we really should write _ because we are not calling a specific list-}

removeNonUppercase :: [Char] -> [Char]  
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]  


factorial :: Integer -> Integer  
factorial n = product [1..n]  

circumference :: Float -> Float  
circumference r = 2 * pi * r  

circumference' :: Double -> Double  
circumference' r = 2 * pi * r  