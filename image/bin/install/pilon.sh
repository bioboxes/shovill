#!/bin/bash

mkdir -p /usr/local/pilon/lib
wget https://github.com/broadinstitute/pilon/releases/download/v${PILON_VERSION}/pilon-${PILON_VERSION}.jar \
	--output-document /usr/local/pilon/lib/pilon.jar \
	--quiet
