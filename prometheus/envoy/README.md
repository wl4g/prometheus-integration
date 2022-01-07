# Prometheus Integration for Envoy

> Use the built-in expose prometheus metrics.

## 1. Catalog

- [example-envoy.yaml](envoy/example-envoy.yaml)
- [envoy-alert-rules.yml](envoy-alert-rules.yml)

## 2. Deploy on Docker

- [https://www.envoyproxy.io/docs/envoy/latest/start/docker#build-and-run-a-docker-image](https://www.envoyproxy.io/docs/envoy/latest/start/docker#build-and-run-a-docker-image)

- Run simple container

```bash
docker run -d --name envoy -p 9901:9901 -p 10000:10000 envoyproxy/envoy:v1.20.1
```

- Testing

```bash
http://172.17.0.5:9901/stats/prometheus
```
