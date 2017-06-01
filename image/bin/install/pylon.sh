#!/bin/bash

mkdir -p /usr/local/pylon/lib
wget https://github.com/broadinstitute/pilon/releases/download/v${PYLON_VERSION}/pilon-${PYLON_VERSION}.jar \
	--output-document /usr/local/pylon/lib/pylon.jar \
	--quiet
