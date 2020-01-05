#!/bin/bash

set -e

echo "downloading amarok source"
wget https://github.com/KDE/amarok/archive/master.zip

echo "unzipping source"
unzip -d amarok master.zip

cd amarok/amarok-master/

mkdir build
cd build

rm -rf /build/*

grep "define AMAROK_VERSION " ../shared/Version.h | awk '{print $3}' | tr -d '"' > /build/version

echo "cmake for makefiles"
cmake ..

echo "Beginning build"
make -j${build_cores}

echo "Beginning 'make install'"
make DESTDIR=/build/ install

echo "Build complete"
