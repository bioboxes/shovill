#!/bin/bash

fetch_archive.sh http://spades.bioinf.spbau.ru/release${SPADES_VERSION}/SPAdes-${SPADES_VERSION}-Linux.tar.gz spades
ln -s /usr/local/spades/bin/* /usr/local/bin
rm -rf /usr/local/spades/share/spades/test_dataset*
