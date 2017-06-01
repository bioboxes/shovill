#!/bin/bash

fetch_archive.sh https://github.com/lh3/seqtk/archive/v${SEQTK_VERSION}.tar.gz seqtk
cd /usr/local/seqtk
make -j $(nproc)
mkdir bin
mv seqtk bin
ln -s /usr/local/seqtk/bin/seqtk /usr/local/bin
