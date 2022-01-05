# Prometheus Integration for Node

## 1. Catalog

- [node_exporter](node_exporter) configuration
  - [/etc/sysconfig/node_exporter.conf](sysconfig/node_exporter.conf)
  - [/etc/systemd/system/node_exporter.service](systemd/node_exporter.service)
- Monitoring alerting configuration
  - [dashboard-node_exporter-15172-rev6.json](dashboard-node_exporter-15172-rev6.json)
  - [node-alert-rules.yml](node-alert-rules.yml)

## 2. Deploy on Host

- Detail refer to: [https://blogs.wl4g.com/archives/1885](https://blogs.wl4g.com/archives/1885)

- Testing

```bash
curl http://localhost:9100/metrics
```

## 3. Deploy on Kubernetes

TODO
