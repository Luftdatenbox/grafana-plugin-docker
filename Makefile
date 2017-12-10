REPOSITORY?=s3ler

all:

x86_64:
	echo '#!/usr/bin/env bash \n _grafana_architecture="amd64"' | tee buildConfig.sh

rpi:
	echo '#!/usr/bin/env bash \n _grafana_architecture="arm32v7"' | tee buildConfig.sh

build: x86_64
	./build.sh "" ${REPOSITORY}

build_rpi: rpi
	./build.sh "" ${REPOSITORY}
