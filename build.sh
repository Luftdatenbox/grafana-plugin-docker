#!/bin/bash

# you need npm install -g grunt before you execute this script, if you install grafana-track-map

_grafana_tag=$1
_grafana_version=${_grafana_tag:1}
_grafana_repository=$2
source buildConfig.sh

mkdir -p $_grafana_architecture/plugins
cat plugin_panel.conf | while read key value; do
	if [[ -n "$value" ]] && [[ $key != \#* ]] && [[ -n "$value" ]];
	then
		if [ "$key" == "tkuri-grafana-track-map" ];
		then
			wget https://github.com/tkurki/grafana-track-map/archive/master.zip -O $_grafana_architecture/plugins/$key
			unzip -qq $_grafana_architecture/plugins/$key -d $_grafana_architecture/plugins
			rm $_grafana_architecture/plugins/$key
		else
			echo "download $key version $value"
			wget https://grafana.com/api/plugins/$key/versions/$value/download -O $_grafana_architecture/plugins/$key
			echo "unzip $key version $value"
			unzip -qq $_grafana_architecture/plugins/$key -d $_grafana_architecture/plugins
			rm $_grafana_architecture/plugins/$key
			echo ""
		fi
	fi
done

cp install_tkuri-grafana-track-map.sh $_grafana_architecture/install_tkuri-grafana-track-map.sh


if [ "$_grafana_version" != "" ]; then
	echo "Building version ${_grafana_version} ${_grafana_architecture}"
	cd $_grafana_architecture
	docker build \
		--tag "${USER}/grafana-plugin:${_grafana_version}" \
		--no-cache=true .
	docker tag $_grafana_repository/grafana-plugin:${_grafana_version} $_grafana_repository/grafana-plugin:latest

else
	echo "Building latest ${_grafana_architecture}"
	cd $_grafana_architecture
	docker build \
		--tag $_grafana_repository"/grafana-plugin:master" \
		--no-cache=true .
	docker tag $_grafana_repository/grafana-plugin:master $_grafana_repository/grafana-plugin:latest
fi

cd ..
rm -r $_grafana_architecture/plugins
rm $_grafana_architecture/install_tkuri-grafana-track-map.sh
