#!/bin/bash

set -euxo pipefail

if [ "$PKG_NAME" == "pti-gpu-unitrace" ]; then
    SRC_DIR=./tools/unitrace
    BLD_DIR=./tools/unitrace/build
    CMAKE_ARGS=""
else
    SRC_DIR=./sdk
    BLD_DIR=./sdk/build
    CMAKE_ARGS="-DPTI_BUILD_TESTING=OFF -DPTI_BUILD_SAMPLES=OFF"
fi

if [ "$PKG_NAME" == "pti-gpu-unitrace" ]; then
    mkdir -p ${BLD_DIR}
    (
        cd ${BLD_DIR}
        cmake $CMAKE_ARGS \
            -G Ninja \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_VERBOSE_MAKEFILE=ON \
            -DCMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
            ..
        cmake --build .
    )
else
    cmake $CMAKE_ARGS \
        -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
        -DCMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
        -S ${SRC_DIR} \
        -B ${BLD_DIR}
    cmake --build ${BLD_DIR}
fi

if [ "$PKG_NAME" == "pti-gpu-unitrace" ]; then
    cmake --install ${BLD_DIR} --prefix=${PREFIX}
fi
