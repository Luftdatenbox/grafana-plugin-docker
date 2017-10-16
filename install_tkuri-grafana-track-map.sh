 #!/bin/sh 
# TODO das funktioniert soweit, nun wird es zeit das ganze noch zu verkleinern
if [ -d "/var/lib/grafana/plugins/grafana-track-map-master" ]; then 
        echo "installing grafana-track-map" apt-get -y --no-install-recommends install
	#apt-get update && apt-get -y --no-install-recommends install npm
	#echo "updating npm" 
	#npm install -g npm@lts
# From https://gist.github.com/garystafford/07fbfe8fde48c3f5810c
apt-get update -yq && apt-get upgrade -yq && \
apt-get install -yq curl git nano
# install version 6.x
curl -sL  https://deb.nodesource.com/setup_6.x  | bash - && \
apt-get install -yq nodejs build-essential
npm install -g npm

	apt-get clean
        cd /var/lib/grafana/plugins/grafana-track-map-master/ 

	echo "install npm" 
	npm install
	echo "install grunt" 
        npm install grunt --save-dev
	npm install -g grunt --save-dev
	echo "building grafana-track-map"
	grunt
	apt-get autoremove -y
	rm -rf /var/lib/apt/lists/*
        echo "installed grafana-track-map" 
fi
