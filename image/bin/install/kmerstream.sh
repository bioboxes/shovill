#!/bin/bash

fetch_archive.sh https://github.com/pmelsted/KmerStream/archive/v${KMERSTEAM_VERSION}.tar.gz kmerstream
cd /usr/local/kmerstream
make -j $(nproc)
mkdir bin
mv {KmerStream,KmerStreamEstimate.py} bin
ln -s /usr/local/kmerstream/bin/{KmerStream,KmerStreamEstimate.py} /usr/local/bin/
