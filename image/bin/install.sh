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


NON_ESSENTIAL_BUILD="
	ca-certificates
	g++
	lbzip2
	make
	openjdk-7-jdk
	patch
	unzip
	wget
	zlibc"

ESSENTIAL_BUILD="
	bc
	gawk
	libevent-pthreads-2.0-5
	libncurses5-dev
	pigz
	zlib1g-dev"

# Required dependencies for each tool
SPADES="python-minimal python-setuptools"
LIGHTER="zlib1g-dev libevent-pthreads-2.0-5"
PYLON_AND_TRIMMOMATIC="openjdk-7-jre-headless"
SHOVILL="perl datamash libfile-slurp-perl"


# Build dependencies
apt-get update --yes
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD} ${ESSENTIAL_BUILD}

export PATH=$PATH:/usr/local/bin/install

# Install individual tools
bwa.sh
flash.sh
kmc.sh
lighter.sh
pylon.sh
samtools.sh
seqtk.sh
spades.sh
trimmomatic.sh

# Shovill requires trimmomatic be installed first
shovill.sh

# Clean up dependencies
apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD}
apt-get clean

# Install required files
apt-get install --yes --no-install-recommends ${ESSENTIAL_BUILD} ${SPADES} ${LIGHTER} ${PYLON_AND_TRIMMOMATIC} ${SHOVILL}

rm -rf /var/lib/apt/lists/*

# Remove all no-longer-required build artefacts
EXTENSIONS=("pyc" "c" "cc" "cpp" "h" "o" "pdf")
for EXT in "${EXTENSIONS[@]}"
do
	find /usr/local -name "*.$EXT" -delete
done
