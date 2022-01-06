# Prometheus Integration for MinIO

> Use the built-in expose prometheus metrics.

## 1. Catalog

- [minio-alert-rules.yml](minio-alert-rules.yml)

## 2. Deploy to Docker

- [https://docs.min.io/minio/baremetal/monitoring/metrics-alerts/minio-metrics-and-alerts.html#metrics](https://docs.min.io/minio/baremetal/monitoring/metrics-alerts/minio-metrics-and-alerts.html#metrics)

- [https://docs.min.io/minio/baremetal/monitoring/metrics-alerts/collect-minio-metrics-using-prometheus.html?ref=con#minio-metrics-collect-using-prometheus](https://docs.min.io/minio/baremetal/monitoring/metrics-alerts/collect-minio-metrics-using-prometheus.html?ref=con#minio-metrics-collect-using-prometheus)

- 2.1 Run simple minio container

```bash
# MINIO_PROMETHEUS_AUTH_TYPE=public|jwt
mkdir -p /mnt/disk1/minio
docker run -d \
--name minio1 \
--restart always \
-p 9000:9000 \
-p 9900:9900 \
-v /mnt/disk1/minio:/data \
minio/minio:RELEASE.2021-11-24T23-19-33Z \
server /data --console-address ":9900"
```

- 2.2 Generating prometheus scrape configuration and have jwt bearer token

```bash
# Usages of the current newer version
mc admin prometheus generate cn_south1_a1_minio_0 http://172.17.0.3:9000/
mc admin prometheus generate cn_south1_a1_minio_0
```

- Output

```yaml
scrape_configs:
- job_name: minio-job
  bearer_token: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjQ3OTUwMzcwNTgsImlzcyI6InByb21ldGhldXMiLCJzdWIiOiJleUpoYkdjaU9pSklVelV4TWlJc0luUjVjQyJ9.Ce-qsB2xygtjR2lvfR5zSdt0JXXWG4b5B16MEyol40GdmgKP2u9t0CQxzix0dbpRrYg_1dimdWLcKcGuuzaJiQ
  metrics_path: /minio/v2/metrics/cluster
  scheme: http
  static_configs:
  - targets: ['172.17.0.3:9000']
```

- 2.3 Testing

```bash
curl -H 'Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjQ3OTUwMzcwNTgsImlzcyI6InByb21ldGhldXMiLCJzdWIiOiJleUpoYkdjaU9pSklVelV4TWlJc0luUjVjQyJ9.Ce-qsB2xygtjR2lvfR5zSdt0JXXWG4b5B16MEyol40GdmgKP2u9t0CQxzix0dbpRrYg_1dimdWLcKcGuuzaJiQ' http://172.17.0.3:9000/minio/v2/metrics/cluster
```

## 2. Deploy to Kubernetes

TODO
