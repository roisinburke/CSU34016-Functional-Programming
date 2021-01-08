{- butrfeld Andrew Butterfield -}
module Ex04 where

name, idno, username :: String
name      =  "Róisín Burke"  -- replace with your name
idno      =  "18328036"    -- replace with your student id
username  =  "burker9"   -- replace with your TCD username

declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype, honestly!
data BinTree k d
  = Branch (BinTree k d) (BinTree k d) k d
  | Leaf k d
  | Empty
  deriving (Eq, Show)




-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> BinTree k d -> BinTree k d
ins k d Empty = (Leaf k d)
ins key dat (Leaf k d)
    | key < k = Branch (Leaf key dat) (Empty) k d
    | key == k = (Leaf key dat)
    | key > k = Branch (Empty) (Leaf key dat) k d
ins key dat (Branch l r k d)
    | key < k = Branch (ins key dat l) r k d
    | key == k = Branch l r k dat                 -- if the key is the same to one you already have, then replace the current data with the given data
    | key > k = Branch l (ins key dat r) k d

-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => BinTree k d -> k -> m d
lkp Empty _ = fail ("Empty")

lkp (Branch l r k d) key
      | key < k = lkp l key
      | key == k = return d
      | key > k = lkp r key
      | otherwise = fail ("non-existent")

lkp (Leaf k d) key
      | key == k = return d
      | otherwise = fail ("Non-existent")

-- Part 3 : Tail-Recursive Statistics

{-
   It is possible to compute BOTH average and standard deviation
   in one pass along a list of data items by summing both the data
   and the square of the data.
-}
twobirdsonestone :: Double -> Double -> Int -> (Double, Double)
twobirdsonestone listsum sumofsquares len
 = (average,sqrt variance)
 where
   nd = fromInteger $ toInteger len
   average = listsum / nd
   variance = sumofsquares / nd - average * average

{-
  The following function takes a list of numbers  (Double)
  and returns a triple containing
   the length of the list (Int)
   the sum of the numbers (Double)
   the sum of the squares of the numbers (Double)

   You will need to update the definitions of init1, init2 and init3 here.
-}
getLengthAndSums :: [Double] -> (Int,Double,Double)
getLengthAndSums ds = getLASs init1 init2 init3 ds
init1 = 0
init2 = 0
init3 = 0

{-
  Implement the following tail-recursive  helper function
-}
getLASs :: Int -> Double -> Double -> [Double] -> (Int,Double,Double)
getLASs len sum sqrsum []  = (len,sum,sqrsum)
getLASs len sum sqrsum (x:xs) = (1 + (extractFirst (getLASs len sum sqrsum xs)),
                                  x + (extractSecond (getLASs len sum sqrsum xs)),
                                   (x*x) + (extractThird ((getLASs len sum sqrsum xs))))

-- Final Hint: how would you use a while loop to do this?
--   (assuming that the [Double] was an array of double)

extractFirst :: (a, b, c) -> a
extractFirst (a,_,_) = a

extractSecond :: (a, b, c) -> b
extractSecond (_,b,_) = b

extractThird:: (a, b, c) -> c
extractThird (_,_,c) = c

{-
    ArrayList<Double> list = {a,b,c,d,e,f,g,h} //ArrayList so that everytime the object at index 0 is removed, the rest of the objects "moved up a space"
                                              //Basically so that remove() is the same as doing xs to (x:xs)
    int len = 0;
    Double sum = 0;
    Double sqrsum = 0;
    3DArray results = {len, sum, sqrsum};
    while(!list.isEmpty())
    {
      len += 1;
      sum += list[0];
      sqrsum += list[0]*list[0];
      list.remove(0);
    }
-}
