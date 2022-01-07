# Prometheus Integration for Keepalived

> Use external keepalived exporter to expose prometheus metrics.

## 1. Catalog

- [keepalived-exporter](https://github.com/cafebazaar/keepalived-exporter) configuration
  - [keepalived-exporter.conf](sysconfig/keepalived-exporter.conf)
  - [keepalived-exporter.service](systemd/keepalived-exporter.service)
- [keepalived-alert-rules.yml](keepalived-alert-rules.yml)

## 3. Deploy on Host

- Testing

```bash
curl http://localhost:9165/metrics
```

## 3. Deploy on Kubernetes

TODO
