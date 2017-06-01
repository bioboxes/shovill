#!/bin/bash

fetch_archive.sh "https://github.com/marekkokot/KMC/archive/v${KMC_VERSION}.tar.gz" kmc
cd /usr/local/kmc
make -j $(nproc)
ln -s /usr/local/kmc/bin/kmc* /usr/local/bin
