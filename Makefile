REPOSITORY?=s3ler

all:

x86_64:
	echo '#!/usr/bin/env bash \n _grafana_architecture="amd64"' | tee buildConfig.sh

rpi:
	echo '#!/usr/bin/env bash \n _grafana_architecture="arm32v7"' | tee buildConfig.sh

build_grafana_plugin:
	./build.sh "" ${REPOSITORY}

