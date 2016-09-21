#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

fetch(){
	mkdir -p /usr/local/$2
	TMP=$(mktemp)
	wget $1 --quiet --output-document ${TMP}
	tar xf ${TMP} --directory /usr/local/$2 --strip-components=1
	rm ${TMP}
}


NON_ESSENTIAL_BUILD="wget ca-certificates make g++ zlibc lbzip2"
ESSENTIAL_BUILD="zlib1g-dev libevent-pthreads-2.0-5 libncurses5-dev"

# Required dependencies
SPADES="python-minimal python-setuptools"
LIGHTER="zlib1g-dev libevent-pthreads-2.0-5"
PILON="openjdk-7-jre-headless"


# Build dependencies
apt-get update --yes
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD} ${ESSENTIAL_BUILD}


# spades
fetch http://spades.bioinf.spbau.ru/release3.9.0/SPAdes-3.9.0-Linux.tar.gz spades
ln -s /usr/local/spades/bin/* /usr/local/bin
rm -rf /usr/local/spades/share/spades/test_dataset*


# lighter
fetch https://github.com/mourisl/Lighter/archive/v1.1.1.tar.gz lighter
cd /usr/local/lighter && make -j $(nproc)
mv /usr/local/lighter/lighter /usr/local/bin
rm -rf /usr/local/lighter


# flash
fetch http://downloads.sourceforge.net/project/flashpage/FLASH-1.2.11.tar.gz flash
cd /usr/local/flash && make -j $(nproc)
mv /usr/local/flash/flash /usr/local/bin
rm -rf /usr/local/flash


# samtools
fetch https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2 samtools
cd /usr/local/samtools && make -j $(nproc)
mv /usr/local/samtools/samtools /usr/local/bin
rm -rf /usr/local/samtools


# bwa mem
fetch http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.15.tar.bz2 bwa
cd /usr/local/bwa && make -j $(nproc)
mv /usr/local/bwa/bwa /usr/local/bin
rm -rf /usr/local/bwa


# pilon
mkdir -p /usr/local/pylon
wget https://github.com/broadinstitute/pilon/releases/download/v1.19/pilon-1.19.jar \
	--output-document /usr/local/pylon/pylon.jar \
	--quiet

# kmerstream
fetch https://github.com/pmelsted/KmerStream/archive/v1.1.tar.gz kmerstream
cd /usr/local/kmerstream && make -j $(nproc)
mv /usr/local/kmerstream/KmerStream /usr/local/bin
rm -rf /usr/local/kmerstream


# seqtk
fetch https://github.com/lh3/seqtk/archive/v1.2.tar.gz seqtk
cd /usr/local/seqtk && make -j $(nproc)
mv /usr/local/seqtk/seqtk /usr/local/bin
rm -fr /usr/local/seqtk


# Clean up dependencies
apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD}
apt-get clean

# Install required files
apt-get install --yes --no-install-recommends ${ESSENTIAL_BUILD} ${SPADES} ${LIGHTER} ${PILON}
rm -rf /var/lib/apt/lists/*
