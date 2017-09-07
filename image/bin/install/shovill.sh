#!/bin/bash

URL="https://github.com/tseemann/shovill/archive/${SHOVILL_VERSION}.tar.gz"
fetch_archive.sh ${URL} shovill
ln -s /usr/local/shovill/bin/shovill /usr/local/bin
rm -rf /usr/local/shovill/test

mkdir /usr/local/shovill/db
cat /usr/local/trimmomatic/adapters/* > /usr/local/shovill/db/trimmomatic.fa
