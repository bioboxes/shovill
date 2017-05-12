#!/bin/bash

fetch_archive.sh https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 samtools
cd /usr/local/samtools
make -j $(nproc)
make install
make clean
