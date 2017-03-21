#!/bin/bash

git clone --depth 1 https://github.com/muzuiget/mirror-lua.git lua-src
echo $MARE_TARGET
cd lua-src
if [ $MARE_TARGET = 'macosx-x64' ]; then
    make macosx
    cd ..
    gcc -O2 -bundle -undefined dynamic_lookup -I./lua-src/src -o remotedebug.so remotedebug.c
else
    make linux
    cd ..
    gcc -O2 -shared -fPIC -D_GNU_SOURCE -I./lua-src/src -o remotedebug.so remotedebug.c
fi

ls
cp lua-src/src/lua .
./lua -e 'print(require("remotedebug"))'
