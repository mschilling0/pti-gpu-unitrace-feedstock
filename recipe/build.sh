#!/bin/bash

set -euxo pipefail

if [ "$PKG_NAME" == "pti-gpu-unitrace" ]; then
    SRC_DIR=./tools/unitrace
    BLD_DIR=./tools/unitrace/build
    CMAKE_ARGS="-DBUILD_WITH_MPI=OFF"
else
    SRC_DIR=./sdk
    BLD_DIR=./sdk/build
    CMAKE_ARGS="-DPTI_BUILD_TESTING=OFF -DPTI_BUILD_SAMPLES=OFF"
fi

cmake $CMAKE_ARGS \
    -G Ninja \
    -DCMAKE_C_COMPILER=icx \
    -DCMAKE_CXX_COMPILER=icpx \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DCMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
    -S ${SRC_DIR} \
    -B ${BLD_DIR} 
cmake --build ${BLD_DIR}

if [ "$PKG_NAME" == "pti-gpu-unitrace" ]; then
    cmake --install ${BLD_DIR} --prefix=${PREFIX}
fi