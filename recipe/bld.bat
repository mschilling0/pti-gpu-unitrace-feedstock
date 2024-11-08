SETLOCAL EnableDelayedExpansion
@echo on

pushd "%SRC_DIR%" || exit /b !ERRORLEVEL!

set _SRC_DIR=""
set BLD_DIR=""
set CMAKE_ARGS=""

if "%PKG_NAME%" == "pti-gpu-unitrace" (
  set _SRC_DIR=".\tools\unitrace"
  set BLD_DIR=".\tools\unitrace\build"
  set CMAKE_ARGS=""
) else (
  set _SRC_DIR=".\sdk"
  set BLD_DIR=".\sdk\build"
  set CMAKE_ARGS="-DPTI_BUILD_TESTING=OFF -DPTI_BUILD_SAMPLES=OFF"
)

:: Configure.
cmake %CMAKE_ARGS% ^
    -G Ninja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_VERBOSE_MAKEFILE=ON ^
    -DCMAKE_INSTALL_PREFIX:STRING=%LIBRARY_PREFIX% ^
    -S %_SRC_DIR% ^
    -B %BLD_DIR% || exit /b !ERRORLEVEL!

:: Build.
cmake --build "%BLD_DIR%" || exit /b !ERRORLEVEL!

if "$PKG_NAME" == "pti-gpu-unitrace" (
    cmake --install %BLD_DIR% --prefix=%LIBRARY_PREFIX% || exit /b !ERRORLEVEL!
)

popd