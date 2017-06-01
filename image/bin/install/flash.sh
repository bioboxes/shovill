#!/bin/bash

fetch_archive.sh http://downloads.sourceforge.net/project/flashpage/FLASH-${FLASH_VERSION}.tar.gz flash
cd /usr/local/flash
make -j $(nproc)
mkdir bin
mv flash bin
ln -s /usr/local/flash/bin/flash /usr/local/bin
