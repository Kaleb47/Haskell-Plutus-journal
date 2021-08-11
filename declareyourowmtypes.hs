{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
--Type declarations which is a new name for an existing

{-
type String = [Char]

new type declarations can make other types easier to read which will help you write better documentation

origin :: Pos
origin = (0,0)

left :: Pos -> Pos
left (x, y) = (x-1, y) just by looking at it

type declarations have parameters

type Pair a = (a,a)

mult :: Pair Int -> Int
mult (m,n) = m*n

copy :: a ->  Pair a
copy x = (x,x)
-}

--Type declarations can be nested 
type Pos = (Int,Int)
type Trans = Pos -> Pos

--Type declarations can't be recurssive


--a completely new type can be defined by specifying its values using a declaration

data Bool = False | True
--bool is a new type with new values

--values of new types can be used the same way as values of built in types
--for example

data Answer = Yes | No | Unknown

answers :: [Answer]
answers = [Yes,No,Unknown]

flip :: Answer -> Answer
flip Yes        = No
flip No         = Yes
flip Unknown    = Unknown

--these names have no intrinsic meaning to the system
--the answers are a list of answers
--you can take answers as an input and output and you can pattern match
--you have a lot of flexibility with your own datatypes

--Constrructors in te data type can also have parrameters

data Shape = Circle Float
            | Rect Float Float

--we can define:
--we're declaring a new type called shape
--a cricle constructor with a float as parameter that is its radius
--a rectangle constructor takes two floats as parameters
square :: Float -> Shape
square n = Rect n n 

--we're computing the area of the shapes
area :: Shape -> Float
area (Circle r) = pi * r^2
area (Rect x y) = x*y
--both constructors are functions

--data Maybe a = Nothing | Just a

--we can define:
--the maybe datatype is already defined in the datatype
safediv :: Int -> Int -> Maybe Int
safediv _ 0 = Nothing
safediv m n = Just (m `div` n)

safehead :: [a] -> Maybe a
safehead [] = Nothing
safehead xs = Just (head xs)


--new types can be defined in terms of themselves

data Nat = Zero | Succ Nat

--Nat is a new type, with contructors
--Zero :: Nat and Succ :: Nat -> Nat

--Using recursion , it is easy to define functions that convert
--between values of type Nat and Int

--This function converts a natural number into an integer
--If you convert a successive number, you must call nat2int recursively and add 1
nat2int :: Num p => Nat -> p
nat2int Zero    = 0
nat2int (Succ n) = 1 + nat2int n

--turns an integer into a natural number
--if you convert any positive number, all your doing is recursively convert its predescessor
int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

--two naturals be added by converting them into integers
--next you add them
--then convert them back

add :: Nat -> Nat -> Nat
add m n =int2nat (nat2int m + nat2int n)

--but if you use recursion, the function doesn't need conversions

add Zero        n = n 
add (Succ m) n   = Succ (add m n)

--note that this function will always terminate because the add value decreases the value of its parameter

--you can use recursion to define arithmetic expressions

data Expr = Val Int
            | Add Expr Expr
            | Mul Expr Expr
--remember the add and mul constructors take 2 expressions as parameters

--Now we can use recursion to define functions to process expressions

size :: Expr -> Int 
size (Val n) = 1
size (Add x y) = size x + size y 
size (Mul x y) = size x + size y 

--it takes an expression as input and it counts the values
-- we define it using pattern matching
-- add and mul cases are the same

eval :: Expr -> Int
eval (Val n) = n
eval (Add x y) = eval x + eval y 
eval (Mul x y) = eval x * eval y 

--the evaluation function takes an expression as input
--evaluates the pression and returns an integer
--defined recursively using pattern matching

--Remember, the following constructor functions have types
{-
Val :: Int -> Expr
Add :: Expr -> Expr -> Expr
Mul :: Expr -> Expr -> Expr

Many functions on expressions can be defined by replacing
the constructors by other functions using a suitable fold function

eval = folde id (+) (*)
-}

-- 1. Using recursion and the function add, define a function that multiplies two natural numbers

mult :: Nat -> Nat -> Nat
mult Zero m = Zero
mult (Succ n) m = add (mult n m) m 


-- 2. Define a suitable function folde for expressions and give a few examples of its use.

-- 3. Define a type tree a of binary trees built from Leaf values of type a using a Node constructor that takes two binary trees as parameters

data Tree a = Leaf a
            | Node (Tree a)(Tree a)
            --trree data type
            --leaf constructor
            --node constructor that takes two sub trees as parameters

--remember that the data keyword allows you to define your own datatype
--this is an example of a Bool data type
--data Bool = False | True
-- | sign means or
{-
this is what an Int data type looks like

data Int = -2147483648 | -2147483647 | ... | -1 | 0 | 1 | 2 | ... | 2147483647
it defines what numbers are considered integers

this datatype can represent either a circle or rectangele

data Shape = Circle Float Float Float | Rectangle Float Float Float Float
The rectangel parameter has 4 floating integers

surface :: Shape -> Float  
surface (Circle _ _ r) = pi * r ^ 2  
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1) 

--remember, the surface function takes a shape and returrns a float integer
--we use pattern matching on a constructor
-- this allows us to figure out what shape is being passed
--parameter in a datatype can also be used in parrtially applied functions

--now let's descirbe a point in two dimensional space

data Point = Point Float Float deriving (Show)  
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

now let's mdofiy te surface function to accomodate the new data type

surface :: Shape -> Float  
surface (Circle _ r) = pi * r ^ 2  
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

modules support custom type too likeso

module Shapes   
( Point(..)  
, Shape(..)  
, surface  
, nudge  
, baseCircle  
, baseRect  
) where 

-- Note that if you dont export any value constructors, then the importer cannot pattern match using a value constructor

-- RECORD SYNTAX --

data Person = Person String String Int Float String String deriving (Show) 

but this is a much more readable way writing this datatype

data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     , height :: Float  
                     , phoneNumber :: String  
                     , flavor :: String  
                     } deriving (Show)  

-- "By specifying the names of the fields, haskell will automatically create functions to get each specific field."

--it displays show differently and you can also create a value of your new type differently

-- TYPE PARAMETERS --
--constructors take values as parameters and produce new values

vplus :: (Num t) => Vector t -> Vector t -> Vector t  
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)  
  
vectMult :: (Num t) => Vector t -> t -> Vector t  
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)  
  
scalarMult :: (Num t) => Vector t -> Vector t -> t  
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n 

--remember that we are using typeclass constraints at the function level
--you can call any of the above functions with anthing from the Num type class

--typeclasses are similar to interfaces in java

data Person = Person { firstName :: String  
               , lastName :: String  
                          , age :: Int  
                		     } 
If we want to say that one data type is equal to another, we simply derive it from the Eq typeclass likeso...

data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
               } deriving (Eq) 
-- we can test for the equality of these datatypes using == or /=
-- deriving (Eq, Show, Read) 
-- the type has more than one value constructor

data Bool = False | True deriving (Ord)

--in order to make algebraic data classes that are enumerable you use Enum

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday 

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday deriving (Eq, Ord, Show, Read, Bounded, Enum) 

--test the above data function yourself in the ghci, you'll be quite surprised


-- TYPE SYNONYMS --

--String and [Char] are type synonyms

type String = [Char] 

--first crreate an assoiation list
-- call the fromList function to create a function likeso

phoneBook :: [(String,String)]  
phoneBook =      
    [("betty","555-2938")     
    ,("bonnie","452-2928")     
    ,("patsy","493-2928")     
    ,("lucille","205-2928")     
    ,("wendy","939-8282")     
    ,("penny","853-2492")     
    ] 
we can convey more information about the phonebook through type synonyms

type PhoneBook = [(String,String)] 

we can even create type synonym for the string as well

type PhoneNumber = String  
type Name = String  
type PhoneBook = [(Name,PhoneNumber)]

--we we use type synonyms to convey more information
--its for documentation purposes

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool  
inPhoneBook name pnumber pbook = (name,pnumber) `elem` pbook 

Without type synonyms, our type signature would look like this:
	inPhoneBook :: String -> String -> [(String,String)] -> Bool

-- type synonyms are helpful for when you're trying to describe what some existing type does in your funnction

-- the Either data type takes two types as parrameters like so,
data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)

lockerLookup :: Int -> LockerMap -> Either String Code  
lockerLookup lockerNumber map =   
    case Map.lookup lockerNumber map of   
        Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"  
        Just (state, code) -> if state /= Taken   
                                then Right code  
                                else Left $ "Locker " ++ show lockerNumber ++ " is already taken!" 

--The above function takes a normal Map.lookup, if it returns nothing the lookup does not exist

    lockers :: LockerMap  
lockers = Map.fromList   
    [(100,(Taken,"ZD39I"))  
    ,(101,(Free,"JAH3I"))  
    ,(103,(Free,"IQSA9"))  
    ,(105,(Free,"QOTSA"))  
    ,(109,(Taken,"893JJ"))  
    ,(110,(Taken,"99292"))  
    ] 
--At leasst here, there is one possible reason the function can fail


-} 


