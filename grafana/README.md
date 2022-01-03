# Prometheus Integration for Grafana

## 1. Deploy for Docker

- Example refer to: [https://blogs.wl4g.com/archives/1885](https://blogs.wl4g.com/archives/1885)

```bash
# see: https://hub.docker.com/r/grafana/grafana/tags
docker pull docker.io/grafana/grafana:8.2.2

mkdir -p /mnt/disk1/grafana; chmod -R 777 /mnt/disk1/grafana
docker run -tid --name=grafana1 -p 3000:3000 --network host --restart=always -v /mnt/disk1/grafana:/var/lib/grafana docker.io/grafana/grafana:8.2.2
```

## 1. Deploy for Kubernetes

TODO
