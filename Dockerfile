FROM centos
LABEL maintainer="The Special Config Prometheus Authors <634326860@qq.com>"

ARG ARCH="amd64"
ARG OS="linux"
COPY prometheus                             /bin/prometheus
COPY promtool                               /bin/promtool
COPY documentation/examples/prometheus.yml  /etc/prometheus/prometheus.yml
COPY console_libraries/                     /usr/share/prometheus/console_libraries/
COPY consoles/                              /usr/share/prometheus/consoles/

RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/
RUN mkdir -p /prometheus && \
    chown -R nobody:nogroup etc/prometheus /prometheus
COPY prometheus_reload_check.sh             /prometheus
COPY prometheus_start.sh                    /prometheus
RUN chmod +x /prometheus/prometheus_reload_check.sh
RUN chmod +x /prometheus/prometheus_start.sh

USER       nobody
EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus

ENTRYPOINT ./prometheus_start.sh


# ENTRYPOINT [ "/bin/prometheus" ]
# CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
#              "--storage.tsdb.path=/prometheus", \
#              "--web.enable-lifecycle", \    # enable reload prometheus.yaml of prometheus
#              "--web.console.libraries=/usr/share/prometheus/console_libraries", \
#              "--web.console.templates=/usr/share/prometheus/consoles" ]
