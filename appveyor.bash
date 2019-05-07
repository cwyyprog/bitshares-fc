#!/usr/bin/bash
set -e
export MSYSTEM=MINGW64
wget http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-boost-1.60.0-4-any.pkg.tar.xz
pacman --noconfirm -U mingw-w64-x86_64-boost-1.60.0-4-any.pkg.tar.xz
pacman --noconfirm -S mingw-w64-x86_64-ccache
#pacman --noconfirm -S  mingw-w64-x86_64-boost; #mingw-w64-x86_64-openssl
mkdir /msys64
mount C:/msys64 /msys64
cd $APPVEYOR_BUILD_FOLDER/bitshares-fc
ccache -s
cmake -G "MSYS Makefiles" . -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DOPENSSL_CONF_SOURCE="C:/msys64/mingw64/ssl/openssl.cnf" -DOPENSSL_ROOT_DIR=/mingw64 -DBOOST_ROOT=/mingw64
cmake --build . --config Release -j 3
ccache -s
echo "Build finished!"
tests/hmac_test 2>&1 | cat
tests/ecc_test README.md 2>&1 | cat
tests/log_test 2>&1 | cat
