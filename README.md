# Grafana Plugin Docker image

This project builds a Docker image with the latest master build of Grafana including Plugins.

It is based on the image from https://github.com/grafana/grafana-docker
But you can define a set of plugins to be build in the image and so you do not need to install them via command line.
They are already build in the image

## Building your own Grafana Plugin Docker image

This is pretty easy.
Just edit the plugin_panel.conf file
Each line is for a Panel Plugin
Hashes are commend lines and not used
uncommend the plugins you want to have
then run .\build.sh
A image with your username/grafana_plugin:master will be created
Afterwards you only need to start the container like the basic grafana docker container

```
docker run -d --name=grafana -p 3000:3000 bele/grafana_plugin:master
```

Of course you can still install now more plugin like in the original container - there are no restrictions.
The only difference is, that the grafana_plugin container has the plugin already installed in the image and you do not need install them at container startup.

## Internally
At the moment I only implemented Panel Plugins, because i needed them.
I extracted the Plugin-Names and Version from https://grafana.com/plugins?type=panel.
If a plugin is missing - include in the plugin_panel.conf file.
Each line is a key vale - seperated by a space.
Example: ```grafana-worldmap-panel 0.0.20```

There is one plugin which is needed by me and not in the official Plugins list: tkuri-grafana-track-map 1.0.0
I wrote a install_tkuri-grafana-track-map.sh script which checks if the tkuri-grafana-track-map's folder exists and installs it.
But this blow up the docker images size - i need to install npm and grunt to build grafana-track-map.
I haven't cleaned up after the build properly - if you know how write a pull request :).

## Supported Architectures
We support amd64 and arm32v7 at the moment
as Base image for amd64 we use the official grafana/grafana docker image.
as Base image for arm32v7 we use the unofficial fg2it/grafana-armhf:v4.1.2 image.
