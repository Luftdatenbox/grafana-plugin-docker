FROM fg2it/grafana-armhf:v4.1.2

RUN mkdir -p /var/lib/grafana/plugins
COPY ./plugins /var/lib/grafana/plugins
COPY ./install_tkuri-grafana-track-map.sh /install_tkuri-grafana-track-map.sh
RUN ./install_tkuri-grafana-track-map.sh

ENTRYPOINT ["/run.sh"]
