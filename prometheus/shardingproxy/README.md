# Prometheus Integration for ShardingProxy

> Use the built-in expose prometheus metric.

- Github: [https://github.com/wl4g/xcloud-shardingproxy](https://github.com/wl4g/xcloud-shardingproxy)

## 1. Catalog

- [shardingproxy-alert-rules.yml](shardingproxy-alert-rules.yml)

## 2. Deploy on Docker

- [https://github.com/wl4g/xcloud-shardingproxy#13-for-dockerusually-for-testing](https://github.com/wl4g/xcloud-shardingproxy#13-for-dockerusually-for-testing)

```bash
sudo mkdir -p /mnt/disk1/shardingproxy/{conf,ext-lib}
sudo mkdir -p /mnt/disk1/log/shardingproxy/

docker network create --subnet=172.8.8.0/24 mysqlnet

docker run -d \
--name sp1 \
--net mysqlnet \
--restart no \
-p 3308:3308 \
-v /mnt/disk1/shardingproxy/conf:/opt/apps/ecm/shardingproxy-package.shardingsproxy-master-bin/conf/ \
-v /mnt/disk1/shardingproxy/ext-lib/:/opt/apps/ecm/shardingproxy-package/shardingproxy-master-bin/ext-lib/ \
-v /mnt/disk1/log/shardingproxy/:/opt/apps/ecm/shardingproxy-package/shardingproxy-master-bin/log/ \
-e JAVA_OPTS='-Djava.awt.headless=true' \
-e PORT=3308 \
wl4g/shardingproxy:5.1.0
```

## 2. Deploy on Kubernetes

- [https://github.com/wl4g/xcloud-shardingproxy#14-for-kubernetesproduction-recommend](https://github.com/wl4g/xcloud-shardingproxy#14-for-kubernetesproduction-recommend)
