# Prometheus Integration for Self

## 1. Configuring

- Example self monitoring

```bash
cat <<EOF>/etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

storage:
  #local:
  #retention: 168h0m0s
  # max-chunks-to-persist: 3024288
  # memory-chunks: 50502740
  # num-fingerprint-mutexes: 300960
  #tsdb:
    #path: /mnt/disk1/prometheus/

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - 'localhost:9093'

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  - "first_rules.yml"
  #- "second_rules.yml"
scrape_configs:
  - job_name: prometheus
    static_configs:
    - targets: ['localhost:9090']
      labels:
        instance: localhost:9090
EOF
```

## 2. Deploy for Docker

- Example refer to: [https://blogs.wl4g.com/archives/1885](https://blogs.wl4g.com/archives/1885)

```bash
mkdir -p /mnt/disk1/prometheus; chmod -R 777 /mnt/disk1/prometheus
docker run -tid --name=prometheus1 -p 9090:9090 \
-v /etc/prometheus/:/etc/prometheus/ \
-v /mnt/disk1/prometheus/:/prometheus/ \
--network host \
--restart=always prom/prometheus:v2.30.3 \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/prometheus \
--web.console.libraries=/usr/share/prometheus/console_libraries \
--web.console.templates=/usr/share/prometheus/consoles \
--storage.tsdb.retention=180d \
--web.listen-address="0.0.0.0:9090" \
--web.enable-admin-api
```
