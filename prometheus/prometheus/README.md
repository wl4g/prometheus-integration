# Prometheus Integration for Self

## 1. Configuring

- Example

```bash
cat <<EOF>/etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s
scrape_configs:
  - job_name: prometheus
    static_configs:
    - targets: ['localhost:9090']
      labels:
        instance: localhost:9090
EOF
```
