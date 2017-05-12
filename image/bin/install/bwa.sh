#!/bin/bash

fetch_archive.sh http://downloads.sourceforge.net/project/bio-bwa/bwa-${BWA_VERSION}.tar.bz2 bwa
cd /usr/local/bwa && make -j $(nproc)
mkdir bin
mv bwa bin
ln -s /usr/local/bwa/bin/bwa /usr/local/bin
