#!/bin/bash

set -o nounset
set -o errexit
set -o xtrace

READ_1=$(mktemp --suffix=.fq.gz)
READ_2=$(mktemp --suffix=.fq.gz)

INPUT=$(biobox_args.sh 'select(has("fastq")) | .fastq | map(.value) | .[0]')

# Split FASTQ into different files
zcat ${INPUT} \
	| paste - - - - - - - - \
	| tee >(cut -f 1-4 | tr "\t" "\n" | pigz --processes $(nproc) > ${READ_1}) \
	| cut -f 5-8 | tr "\t" "\n" | pigz --best --processes $(nproc) > ${READ_2}

TMP=$(mktemp -d)/shovill

RAM_AVAILABLE=$(grep MemTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=4; {}/1024^2 * 0.9" | bc)


shovill \
	--outdir ${TMP} \
	--ram ${RAM_AVAILABLE} \
	--R1 ${READ_1} \
	--R2 ${READ_2}

seqtk seq -l60 ${TMP}/contigs.fa > ${OUTPUT}/contigs.fa
rm -rf ${READ_1} ${READ_2} ${TMP}

cat << EOF > ${OUTPUT}/biobox.yaml
version: 0.9.0
arguments:
  - fasta:
    - id: contigs_1
      value: contigs.fa
      type: contigs
EOF
