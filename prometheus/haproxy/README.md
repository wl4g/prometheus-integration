# Prometheus Integration for Haproxy

> Use external haproxy_exporter and build-in expose to prometheus metrics.

## 1. Catalog

- [haproxy_exporter](haproxy_exporter) configuration
  - [/etc/sysconfig/haproxy_exporter.conf](sysconfig/haproxy_exporter.conf)
  - [/etc/systemd/system/haproxy_exporter.service](systemd/haproxy_exporter.service)

- Monitoring alerting configuration
  - [dashboard-haproxy-2428-rev7.json](dashboard-haproxy-2428-rev7.json) from [https://grafana.com/grafana/dashboards/2428](https://grafana.com/grafana/dashboards/2428)
  - [dashboard-haproxy2-full-12693-rev4.json](dashboard-haproxy2-full-12693-rev4.json) from [https://grafana.com/grafana/dashboards/12693](https://grafana.com/grafana/dashboards/12693)
  - [haproxy-alert-rules.yml](haproxy-alert-rules.yml)

## 2. Deploy on Host

- Detail refer to: [https://blogs.wl4g.com/archives/743](https://blogs.wl4g.com/archives/743)

- Configuring haproxy

```bash
sudo mkdir -p /etc/haproxy/
sudo curl -o /etc/haproxy/haproxy.cfg 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/haproxy/haproxy/haproxy.cfg'

sudo mkdir -p /etc/sysconfig/
sudo curl -o /etc/sysconfig/haproxy.conf 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/haproxy/sysconfig/haproxy.conf'

sudo curl -o /etc/systemd/system/haproxy.service 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/haproxy/systemd/haproxy.service'
```

- Configuring haproxy_exporter

```bash
sudo curl -o /etc/sysconfig/haproxy_exporter.conf 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/haproxy/sysconfig/haproxy_exporter.conf'

sudo curl -o /etc/systemd/system/haproxy_exporter.service 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/haproxy/systemd/haproxy_exporter.service'
```

- Testing

```bash
# 首先测试 haproxy 内置的 /stats
curl "http://localhost:8404/stats?;csv"

# 再测试 haproxy_exporter 接口
curl "http://localhost:9101/metrics"
```

## 3. Deploy on Kubernetes

> It is recommended to use ipvs or metalLB or cloudProvider [ELB](https://aws.amazon.com/cn/elasticloadbalancing/) / [SLB](http://slb.console.aliyun.com/) / [Tencent CLB](https://cloud.tencent.com/product/clb) / [Google CLB](https://cloud.google.com/load-balancing) in a cloud native.
