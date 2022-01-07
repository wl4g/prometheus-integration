# Prometheus Integration for Keepalived

> Use external keepalived exporter to expose prometheus metrics.

## 1. Catalog

- [keepalived-exporter](https://github.com/cafebazaar/keepalived-exporter) configuration
  - [keepalived-exporter.conf](sysconfig/keepalived-exporter.conf)
  - [keepalived-exporter.service](systemd/keepalived-exporter.service)
- [keepalived-alert-rules.yml](keepalived-alert-rules.yml)

## 2. Deploy on Host

```bash
sudo curl -o /etc/sysconfig/keepalived-exporter.conf 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/keepalived/sysconfig/keepalived-exporter.conf'

sudo curl -o /etc/systemd/system/keepalived-exporter.service 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/keepalived/systemd/keepalived-exporter.service'
```

- Testing

```bash
curl http://localhost:9165/metrics
```

## 3. Deploy on Docker

```bash
docker pull ghcr.io/cafebazaar/keepalived-exporter
docker run -v keepalived-data:/tmp/ ... $KEEPALIVED_IMAGE
docker run -v /var/run/docker.sock:/var/run/docker.sock -v keepalived-data:/tmp/keepalived-data:ro -p 9165:9165 ghcr.io/cafebazaar/keepalived-exporter --container-name keepalived --container-tmp-dir "/tmp/keepalived-data"
```

## 4. Deploy on Kubernetes

TODO
