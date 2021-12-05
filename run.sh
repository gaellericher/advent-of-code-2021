#!/bin/bash

python day_1_python/main.py

cd day_2_rust
rustc main.rs
./main
rm main
cd ..

cd day_3_haskell
ghc main.hs
./main
rm main
cd ..