# Prometheus Integration for Mysqld

> Use external mysqld_exporter to expose prometheus metrics.

## 1. Catalog

- [mysqld_exporter](mysqld_exporter) configuration
  - [/etc/sysconfig/mysqld_exporter.conf](sysconfig/mysqld_exporter.conf)
  - [/etc/sysconfig/mysqld_exporter.cnf](sysconfig/mysqld_exporter.cnf)
  - [/etc/systemd/system/mysqld_exporter.service](systemd/mysqld_exporter.service)
- Monitoring alerting configuration
  - [dashboard-mysql-overview-7362-rev5.json](dashboard-mysql-overview-7362-rev5.json)
  - [mysqld-alert-rules.yml](mysqld-alert-rules.yml)

## 2. Deploy on Host

- Detail refer to: [https://blogs.wl4g.com/archives/743](https://blogs.wl4g.com/archives/743)

- Testing

```bash
curl http://localhost:9104/metrics
```

## 3. Deploy on Kubernetes

TODO
