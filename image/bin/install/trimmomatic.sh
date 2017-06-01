#!/bin/bash

URL="https://github.com/timflutre/trimmomatic/archive/${TRIMMOMATIC_VERSION}.tar.gz"
fetch_archive.sh ${URL} trimmomatic
cd /usr/local/trimmomatic

make -j $(nproc)
make install
make clean
