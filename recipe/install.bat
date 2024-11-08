SETLOCAL EnableDelayedExpansion

pushd "%SRC_DIR%" || exit /b !ERRORLEVEL!

cmake --install .\sdk\build --component Pti_Runtime --prefix=%LIBRARY_PREFIX%
cmake --install .\sdk\build --component Pti_Development --prefix=%LIBRARY_PREFIX%

popd
