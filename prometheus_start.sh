# prometheus reload check 
# if /etc/prometheus/prometheus.yaml modify, this sh will curl the reload request of prometheus.
nohup /bin/bash prometheus_reload_check.sh	> reload_check.log 2>&1

# --web.enable-lifecycle
# enable reload prometheus.yaml of prometheus 
/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.enable-lifecycle --web.console.libraries=/usr/share/prometheus/console_libraries
 --web.console.templates=/usr/share/prometheus/consoles
