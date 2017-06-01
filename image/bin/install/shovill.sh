#!/bin/bash

URL="https://github.com/tseemann/shovill/archive/${SHOVILL_VERSION}.tar.gz"
fetch_archive.sh ${URL} shovill
ln -s /usr/local/shovill/bin/shovill /usr/local/bin
rm -rf /usr/local/shovill/test

mkdir /usr/local/shovill/db
cat /usr/local/trimmomatic/adapters/* > /usr/local/shovill/db/trimmomatic.fa

# Patch shovill to dynamically set memory available for kmc
# See https://github.com/tseemann/shovill/issues/14 for details
patch < /usr/local/share/shovill.patch /usr/local/shovill/bin/shovill
