#!/usr/bin/bash
export MSYSTEM=MINGW64
pacman --noconfirm -S  mingw-w64-x86_64-boost; #mingw-w64-x86_64-openssl
mkdir /msys64
mount C:/msys64 /msys64;
cd $APPVEYOR_BUILD_FOLDER/bitshares-fc;
cmake -G "MSYS Makefiles" . -DOPENSSL_CONF_SOURCE="C:/msys64/mingw64/ssl/openssl.cnf" -DOPENSSL_ROOT_DIR=/mingw64 -DBOOST_ROOT=/mingw64;
#cmake --build . -j 2 --target all_tests;
cmake --build . -j 2 --target log_test;
cmake --build . -j 2 --target bloom_test;
cmake --build . -j 2 --target hmac_test;
cmake --build . -j 2 --target blind;
cmake --build . -j 2 --target task_cancel_test;
#cmake --build . -j 2 --target api;
cmake --build . -j 2 --target real128_test;
cmake --build . -j 2 --target ecc_test;
cmake --build . -j 2 --target bip_lock;
echo "Build finished!"
