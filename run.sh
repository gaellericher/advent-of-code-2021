#!/bin/bash

python day_1_python/main.py

rustc day_2_rust/main.rs -o day_2_rust/main
cd day_2_rust
./main
rm main
cd ..