# Prometheus Integration for EMQx

## 1. Catalog

- [mysqld_exporter](mysqld_exporter) configuration
  - [dashboard-emq-v4.2.14.json](dashboard-emq-v4.2.14.json) based on [https://github.com/emqx/emqx-prometheus/tree/v4.2.14/grafana_template/EMQ.json](https://github.com/emqx/emqx-prometheus/tree/v4.2.14/grafana_template/EMQ.json)
  - [dashboard-erlangVM-v4.2.14.json](dashboard-erlangVM-v4.2.14.json) based on [https://github.com/emqx/emqx-prometheus/tree/v4.2.14/grafana_template/EMQ_Dashboard.json](https://github.com/emqx/emqx-prometheus/tree/v4.2.14/grafana_template/EMQ_Dashboard.json)
- Monitoring alerting configuration
  - [emqx-alert-rules.yml](emqx-alert-rules.yml)

## 2. Deploy on Docker

- Detail refer to: [https://blogs.wl4g.com/archives/705](https://blogs.wl4g.com/archives/705)

- [https://docs.emqx.com/zh/emqx/v4.3/tutorial/prometheus.html#prometheus-监控告警](https://docs.emqx.com/zh/emqx/v4.3/tutorial/prometheus.html#prometheus-%E7%9B%91%E6%8E%A7%E5%91%8A%E8%AD%A6)

- Making configuration

```bash
sudo mkdir -p /mnt/disk1/emqx/{etc/plugins,data}
sudo chmod -R 777 /mnt/disk1/emqx

# Default load modules
cat <<-'EOF' >/mnt/disk1/emqx/data/loaded_modules
{emqx_mod_acl_internal, true}.
{emqx_mod_topic_metrics, true}.
{emqx_mod_presence, true}.
{emqx_mod_delayed, false}.
{emqx_mod_rewrite, false}.
{emqx_mod_subscription, false}.
EOF

# Default enabled plugins
cat <<-'EOF' >/mnt/disk1/emqx/data/loaded_plugins
{emqx_management, true}.
{emqx_dashboard, true}.
{emqx_recon, true}.
{emqx_retainer, true}.
{emqx_telemetry, true}.
{emqx_rule_engine, true}.
{emqx_prometheus,true}.
{emqx_modules, false}.
{emqx_bridge_mqtt, false}.
EOF

# 如上 emqx_prometheus 插件开启后会加载此配置，将 metrics 自动推送到 pushgateway
cat <<-'EOF' >/mnt/disk1/emqx/etc/plugins/emqx_statsd.conf
statsd.push.gateway.server=http://127.0.0.1:9091
statsd.interval=15000
EOF

sudo chmod -R 777 /mnt/disk1/emqx
```

- Run container

```bash
docker run -itd \
--network=host \
--restart=always \
--name=emqx1 \
-e EMQX_NAME=emqx \
-e EMQX_HOST=n1.emqx.io \
-e EMQX_CLUSTER__DISCOVERY=static \
-e EMQX_CLUSTER__STATIC__SEEDS=emqx@n1.emqx.io,emqx@n2.emqx.io \
-e TZ=Europe/Amsterdam \
-v /mnt/disk1/emqx/data/:/opt/emqx/data/ \
-v /mnt/disk1/emqx/etc/plugins/emqx_statsd.conf:/opt/emqx/etc/plugins/emqx_statsd.conf \
emqx/emqx:4.3.10
```

- Testing ([`pushgateway`](../pushgateway/README.md))

```bash
curl http://localhost:9091/metrics
```

## 3. Deploy on Kubernetes

TODO
