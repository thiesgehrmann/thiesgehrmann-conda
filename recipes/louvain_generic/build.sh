#!/bin/bash
set -e

pwd
ls

make

# tests will only work inside the build dir, but
# https://github.com/conda/conda-build/issues/1453
# so you need `conda build --prefix-length 1`
# for it to work properly
# make test

cp louvain $PREFIX/bin/louvain
cp convert $PREFIX/bin/louvain-convert
cp hierarchy $PREFIX/bin/louvain-hierarchy
