# hashmap-test

This is a little project demonstrating peculiar strictness behaviour of HashMap from `unordered-container` using slightly modified `ghc-heap-view` package (with added support for `SmallMutArrClosure`). When strict folding a series of `insert` HashMap comes out having thunks for internal nodes. However it's not how it comes out after doing `union` with `singleton`.

To run the example using stack:
```
cd hashmap-test && stack build hashmap-test && stack exec hashmap-test
```

The output I get is:
```
HeapTree for test1
"BitmapIndexed ([ (_thunk (I# 0) (I# 0) 0), (_thunk (I# 1) (I# 1) 1), (Leaf (I# 2) (I# 2) 2), (Leaf (I# 3) (I# 3) 3), (Leaf (I# 4) (I# 4) 4), (Leaf (I# 5) (I# 5) 5) ]) 63"
HeapTree for test2
"BitmapIndexed ([ (Leaf (I# 0) (I# 0) 0), (Leaf (I# 1) (I# 1) 1), (Leaf (I# 2) (I# 2) 2), (Leaf (I# 3) (I# 3) 3), (Leaf (I# 4) (I# 4) 4), (Leaf (I# 5) (I# 5) 5) ]) 63"
```
