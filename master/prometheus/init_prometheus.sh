#!/usr/bin/env sh

echo "RUNNING INIT PROMETHEUS 2"

printf "scrape_configs:
    - job_name: 'spring'
      metrics_path: '/actuator/prometheus'
      scrape_interval: 1s
      static_configs:
        - targets: $WORKERS"

echo "scrape_configs:
    - job_name: 'spring'
      metrics_path: '/actuator/prometheus'
      scrape_interval: 1s
      static_configs:
        - targets: $WORKERS" > /etc/prometheus/prometheus.yml

/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.console.libraries=/usr/share/prometheus/console_libraries --web.console.templates=/usr/share/prometheus/consoles