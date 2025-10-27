#!/bin/bash

set -euxo pipefail

if [ "$PKG_NAME" == "pti-gpu-unitrace" ]; then
    SRC_DIR=./tools/unitrace
    BLD_DIR=./tools/unitrace/build
    # Fixed in later versions of Unitrace. However, for now include these
    # flags.
    CMAKE_EXE_LINKER_FLAGS="-lrt"
    CMAKE_CXX_FLAGS="-lrt"
    CMAKE_ARGS=(
        "-DCMAKE_EXE_LINKER_FLAGS=${CMAKE_EXE_LINKER_FLAGS}"
        "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}"
    )
else
    SRC_DIR=./sdk
    BLD_DIR=./sdk/build
    CMAKE_ARGS=(
        "-DBUILD_TESTING=OFF"
    )
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
