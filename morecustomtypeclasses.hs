{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
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

-- remember that the type keyword is not used to make anything new but is used to make type synonyms

type String = [Char]  

--this improves the readability of functions
{-
type PhoneNumber = String  
type Name = String  
type PhoneBook = [(Name,PhoneNumber)]  

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool  
inPhoneBook name pnumber pbook = (name,pnumber) `elem` pbook  

Doesn't that make the type signature so much easier to read!




Fonzie says: Aaay! When I talk about concrete types I mean like fully applied types like Map Int String 
or if we're dealin' with one of them polymorphic functions, [a] or (Ord a) => Maybe a and stuff. 
And like, sometimes me and the boys say that Maybe is a type, but we don't mean that, cause every idiot knows Maybe is a type constructor. 
When I apply an extra type to Maybe, like Maybe String, then I have a concrete type. You know, values can only have types that are concrete types! 
So in conclusion, live fast, love hard and don't let anybody else use your comb!


IntMap type constructor takes one parameter and that is the type of what the integers will point to.


Oh yeah. If you're going to try and implement this, 
you'll probably going to do a qualified import of Data.Map. 
When you do a qualified import, type constructors also have to be preceeded with a module name. 
So you'd write type IntMap = Map.Map Int.
-}

--The Data type Either a b takes two parameters

data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)  

--We can pattern match on both the Left and Right

--Let's see this in action

{-
import qualified Data.Map as Map  
  
data LockerState = Taken | Free deriving (Show, Eq)  
  
type Code = String  
  
type LockerMap = Map.Map Int (LockerState, Code) 

lockerLookup :: Int -> LockerMap -> Either String Code  
lockerLookup lockerNumber map =   
    case Map.lookup lockerNumber map of   
        Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"  
        Just (state, code) -> if state /= Taken   
                                then Right code  
                                else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"  


-}


-- RECURSIVE DATA STRUCTURES --

--We can make types whose constructors have field that are the same type

--Same goes for a list like 3:(4:(5:6:[])), 
--which could be written either like that or like 3:4:5:6:[] 
--(because : is right-associative) or [3,4,5,6].

--We can use algebraic datatypes to implement our own list

-- data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)  

-- data List a = Empty | Cons { listHead :: a, listTail :: List a} deriving (Show, Read, Eq, Ord)  

--the Cons constructor above is simply : which takes a value and another list and returns another list

-- We called our Cons constructor in an infix manner so you can see how it's just like :. 
--Empty is like [] and 4 `Cons` (5 `Cons` Empty) is like 4:(5:[])

--We can define functions to be automatically infix by making them comprised of only special characters. 
--We can also do the same with constructors, since they're just functions that return a data type

infixr 5 :-:  
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)  

--fixity declarations are used for making your own operator
--operators are used inm infix notation by default
--infixr right associative
--the number represents how it binds to the operands, you are picking your order of operrations

{-

infixr 5  .++  
(.++) :: List a -> List a -> List a   
Empty .++ ys = ys  
(x :-: xs) .++ ys = x :-: (xs .++ ys)  

ghci> let a = 3 :-: 4 :-: 5 :-: Empty  
ghci> let b = 6 :-: 7 :-: Empty  
ghci> a .++ b  
(:-:) 3 ((:-:) 4 ((:-:) 5 ((:-:) 6 ((:-:) 7 Empty))))  
-}

infixr 5  .++  
(.++) :: List a -> List a -> List a   
Empty .++ ys = ys  
(x :-: xs) .++ ys = x :-: (xs .++ ys)  

--we can pattern match :-: because pattern matching is about matching constructors

--What the heck is binary search tree?
--https://en.wikipedia.org/wiki/Binary_search_tree
--according to the wikipedia page, it is data stored in such a way where each node has more data than the last

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq) 

--now lets make a function that takes a tree and returns an element
--in haskell, we can't modify our tree

--the first function below is a singleton function for making a single node
singleton :: a -> Tree a  
singleton x = Node x EmptyTree EmptyTree 

-- the following function inserts an element into a tree
treeInsert :: (Ord a) => a -> Tree a -> Tree a  
treeInsert x EmptyTree = singleton x  
treeInsert x (Node a left right)   
    | x == a = Node x left right  
    | x < a  = Node a (treeInsert x left) right  
    | x > a  = Node a left (treeInsert x right) 

-- TYPECLASSES 102 --

--we've learned how to automatically take our own type instances of the standard type classes by asking Haskell to derive the instances for us

--remember, typeclasses are like interfaces with specific behaviors

--This is how the Eq type class is defined in the standard Prelude
{-
class Eq a where  
    (==) :: a -> a -> Bool  
    (/=) :: a -> a -> Bool  
    x == y = not (x /= y)  
    x /= y = not (x == y)  

We're defining a new typeclass that is called Eq

Some people might understand this better if 
    we wrote class Eq equatable where and then specified 
    the type declarations like (==) :: equatable -> equatable -> Bool

If we have say class Eq a where and then define a type declaration within that class like 
(==) :: a -> -a -> Bool, then when we examine the type of that function later on, 
it will have the type of (Eq a) => a -> a -> Bool.

data TrafficLight = Red | Yellow | Green  

Now let's derive an instance from Eq

instance Eq TrafficLight where  
    Red == Red = True  
    Green == Green = True  
    Yellow == Yellow = True  
    _ == _ = False 

 this is possible through the instance keyword

 class Eq a where  
    (==) :: a -> a -> Bool  
    (/=) :: a -> a -> Bool  

    we implemented == by simply doing pattern matching as you can see above

    instance Show TrafficLight where  
    show Red = "Red light"  
    show Yellow = "Yellow light"  
    show Green = "Green light"  
--------REVIEW THIS LATER----------

--- A YES-NO TYPECLASS ---

class YesNo a where  
    yesno :: a -> Bool

 normally a bool function is preferable but this is a java like implementation

 now we can implement instances   

 instance YesNo Int where  
    yesno 0 = False  
    yesno _ = True  

    epmty strings represent no and non-empty strings represent yes

    instance YesNo [a] where  
    yesno [] = False  
    yesno _ = True

    instance YesNo (Tree a) where  
    yesno EmptyTree = False  
    yesno _ = True  

yesnoIf :: (YesNo y) => y -> a -> a -> a  
yesnoIf yesnoVal yesResult noResult = if yesno yesnoVal then yesResult else noResult  

-}

-- FUNCTORS --

--is like a map accept it applies functions to elements that are lists

class Functor f where  
    fmap :: (a -> b) -> f a -> f b

 -- this is how to implement it

 --It takes a function from one type to another and a list of one type and returns a list of another type
{-
 instance Functor [] where  
    fmap = map     
    
    instance Functor Tree where  
    fmap f EmptyTree = EmptyTree  
    fmap f (Node x leftsub rightsub) = Node (f x) (fmap f leftsub) (fmap f rightsub)  

    -}

    --The Functor typeclass wants a type constructor that takes only one type parameter but Either takes two.
{-
    instance Functor (Either a) where  
    fmap f (Right x) = Right (f x)  
    fmap f (Left x) = Left x  
    -}

    
