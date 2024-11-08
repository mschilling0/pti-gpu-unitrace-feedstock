#!/bin/bash

set -euxo pipefail

# cmake --install ./sdk/build --component Pti_Runtime --prefix=${PREFIX}
# cmake --install ./sdk/build --component Pti_Development --prefix=${PREFIX}

cmake --install ./sdk/build --prefix=${PREFIX}
