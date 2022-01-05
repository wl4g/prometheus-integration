# Prometheus Integration for pushgateway

## 1. Catalog

- [pushgateway](https://github.com/prometheus/pushgateway) configuration
  - [/etc/sysconfig/pushgateway.conf](sysconfig/pushgateway.conf)
  - [/etc/systemd/system/pushgateway.service](systemd/pushgateway.service)

## 2. Deploy on Docker

```bash
docker run -d --name pushgateway1 --restart always -p 9091:9091 prom/pushgateway:v1.4.2
```

## 2. Deploy on Kubernetes

TODO
