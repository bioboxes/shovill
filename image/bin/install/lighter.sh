#!/bin/bash

fetch_archive.sh https://github.com/mourisl/Lighter/archive/v${LIGHTER_VERSION}.tar.gz lighter
cd /usr/local/lighter
make -j $(nproc)
mkdir bin
mv lighter bin
ln -s /usr/local/lighter/bin/lighter /usr/local/bin
