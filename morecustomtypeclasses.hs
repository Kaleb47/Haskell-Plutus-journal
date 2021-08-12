--Algebraic Data Types

data Bool = False | True  

-- the part to the left of the equal sign denotes the type, Bool
-- remember | represents or

--data Int = -2147483648 | -2147483647 | ... | -1 | 0 | 1 | 2 | ... | 2147483647  

--this data type reprresents the minimum and maximum values of Int

--data Shape = Circle Float Float Float | Rectangle Float Float Float Float   

--the above data type represents circles and rectangles. We will eventually use them in are functions
--the circle having three fields and the rectanglw having four
--and yes constructors are functions


{-
surface :: Shape -> Float  
surface (Circle _ _ r) = pi * r ^ 2  
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)  -}
--this function takes a shape and returns a surface
--remember, circle and rectangle are not types
--they are simply parameters of Shape
--you can't just type in circle 10 3 1 into the ghci
--the ghci does not know how display our type as a string yet
--so we use this...

--data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

--Deriving (Show) makes it easier for you to type the parameter into the ghci

--since value constructors, like the one above, are functions, we can apply maps to them


data Point = Point Float Float deriving (Show)  
data Shape = Circle Point Float | Rectangle Point Point deriving (Show) 
--now we've made an intermediate datatype that defines a point in two dimensional space
--this makes it a lot easier for documentation

surface :: Shape -> Float  
surface (Circle _ r) = pi * r ^ 2  
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)  

--lets make a function that can move shapes on the x and y axis

nudge :: Shape -> Float -> Float -> Shape  
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r  
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))

{-
in the ghci, we can add nudge amounts like so

ghci> nudge (Circle (Point 34 34) 10) 5 10  
Circle (Point 39.0 44.0) 10.0  

-}

baseCircle :: Float -> Shape  
baseCircle r = Circle (Point 0 0) r  
  
baseRect :: Float -> Float -> Shape  
baseRect width height = Rectangle (Point 0 0) (Point width height)  

{-
module Shapes   
( Point(..)  
, Shape(..)  
, surface  
, nudge  
, baseCircle  
, baseRect  
) where  

    we can export the types we defined in a module
    That means you can make your own libraries in Haskell, cool!
-}

-- RECORRD SYNTAX --

{-
data Person = Person String String Int Float String String deriving (Show)  

firstName :: Person -> String  
firstName (Person firstname _ _ _ _ _) = firstname  
  
lastName :: Person -> String  
lastName (Person _ lastname _ _ _ _) = lastname  
  
age :: Person -> Int  
age (Person _ _ age _ _ _) = age  
  
height :: Person -> Float  
height (Person _ _ _ height _ _) = height  
  
phoneNumber :: Person -> String  
phoneNumber (Person _ _ _ _ number _) = number  
  
flavor :: Person -> String  
flavor (Person _ _ _ _ _ flavor) = flavor
-}
{-
data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     , height :: Float  
                     , phoneNumber :: String  
                     , flavor :: String  
                     } deriving (Show)   -}
--write the instance then :: and specify the type
-- this helps us create the look up fields in the data type

-- TYPE PARAMETERS --

--type constructors can take types as parameters to produce new types. 

--Maybe Int, Maybe Car, Maybe String

--Maybe by itself is not a type

--we use type parameters when we know our data type would work regardless 

{-
For example, let's say we have a car data type...

data Car = Car { company :: String  
               , model :: String  
               , year :: Int  
               } deriving (Show) 

why do that when you can distinguish each parameter like so

data Car a b c = Car { company :: a  
                     , model :: b  
                     , year :: c   
                     } deriving (Show)  

tellCar :: (Show a) => Car String String a -> String  
tellCar (Car {company = c, model = m, year = y}) = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y  

This makes the function easier to read for your colleagues!

-}

--Having maps parameterized enables us to have mappings from any type to any other type, as long as the type of the key is part of the Ord typeclass

-- NEVER ADD TYPECLASS CONSTRAINTS IN DATA DECLARATIONS
--you'll end up writing class constraints that you don't need

data Vector a = Vector a a a deriving (Show)  
  
vplus :: (Num t) => Vector t -> Vector t -> Vector t  
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)  
  
vectMult :: (Num t) => Vector t -> t -> Vector t  
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)  
  
scalarMult :: (Num t) => Vector t -> Vector t -> t  
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n  

--We'll be using a parameterized type because even though it will usually contain numeric types, it will still support several of them.
-- as you can see vplus is adding two vectors together
--vectMult is for multiplying a vector with scalar

-- When declaring a data type, the part before the = is the type constructor
-- the constructors after it (possibly separated by |'s) are value constructors.

-- DERIVED INSTANCES --

--remember that a typeclass is an interface of some behavior

--Haskell can derive the behavior of each typeclass in our datatype using the derived keyword
{-
data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     } deriving (Eq)  

we can try to equate two "person" data types by deriving the Equality type class 

Haskell will now try to see if the value constructors match

    Now, if the type has fields that we want to see, we need to derive from Show or Read like so,

        data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     } deriving (Eq, Show, Read)  


-}
--Remember show is for converting values of our type to a string
--Read converts strings into values

--Deriving instances from the Ord type class when the datatype has values that can be ordered

--Enum and Bounded typeclasses help us use algebrraic data to enumerate the data type likeso,

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday   
           deriving (Eq, Ord, Show, Read, Bounded, Enum)  

--Enums are good for predecessors and successors
--Eq and Ord would help us compare and equate days
--Bounded helps you rank lowest to highest
--Enum. We can get predecessors and successors of days and we can make list ranges from them!

-- TYPE SYNONYMS --

-- [Char] and String are interchangeable


