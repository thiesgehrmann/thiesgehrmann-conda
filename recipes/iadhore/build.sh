#!/bin/bash
set -e

pwd
ls


mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX}
make
make install
