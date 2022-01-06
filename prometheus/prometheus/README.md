# Prometheus Integration for Self

## 1. Catalog

- [prometheus.yml](prometheus.yml)
- [prometheus-alert-rules.yml](prometheus-alert-rules.yml)

## 2. Configuring

- Example self monitoring

```bash
sudo curl -o /etc/prometheus/prometheus.yml 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/prometheus/prometheus.yml'
```

## 3. Deploy on Docker

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

## 4. Deploy on Kubernetes

TODO
