{-# LANGUAGE BangPatterns #-}

module Main where

import           Control.Exception           (evaluate)
import           Data.Foldable
import           Data.HashMap.Strict         (HashMap)
import qualified Data.HashMap.Strict         as HM
import           GHC.HeapView

test1 :: HashMap Int Int
test1 = foldl' (\m v -> HM.insert v v m) HM.empty [0..5]

test2 :: HashMap Int Int
test2 = foldl' (\m v -> HM.union (HM.singleton v v) m) HM.empty [0..5]

main :: IO ()
main = do
  putStrLn "HeapTree for test1"
  t1 <- evaluate test1
  buildHeapTree 10 (asBox t1) >>= print . ppHeapTree

  putStrLn "HeapTree for test2"
  t2 <- evaluate test2
  buildHeapTree 10 (asBox t2) >>= print . ppHeapTree

{-
I've been trying to ensure the strictness of an in-memory model of a Haskell program using ghc-heap-view package and the utils it provides when I noticed that my `HashMap`s don't seem to be in NF upon a series on inserts. I tried printing Heap tree and indeed it shows some thunks. I then tried another way of inserting elements (using `union` and `singleton`) and this time it comes out strict.

Could somebody please explain why is this so and advise if there's anything I can do to make `insert` behave the same way as the other method?

-}