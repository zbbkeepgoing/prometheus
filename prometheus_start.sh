# prometheus reload check 
# if /etc/prometheus/prometheus.yaml modify, this sh will curl the reload request of prometheus.
./prometheus_reload_check.sh	> /tmp/reload_check.log

# --web.enable-lifecycle
# enable reload prometheus.yaml of prometheus 
/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.enable-lifecycle --web.console.libraries=/usr/share/prometheus/console_libraries
 --web.console.templates=/usr/share/prometheus/consoles
