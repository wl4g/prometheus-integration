# Prometheus Integration for ShardingProxy

> Use the built-in expose prometheus metric.

- Github: [https://github.com/wl4g/xcloud-shardingproxy](https://github.com/wl4g/xcloud-shardingproxy)

## 1. Catalog

- [shardingproxy-alert-rules.yml](shardingproxy-alert-rules.yml)

## 2. Deploy on Docker

- [https://github.com/wl4g/xcloud-shardingproxy#13-for-dockerusually-for-testing](https://github.com/wl4g/xcloud-shardingproxy#13-for-dockerusually-for-testing)

```bash
sudo mkdir -p /mnt/disk1/shardingsphere-proxy/{conf,ext-lib}
sudo mkdir -p /mnt/disk1/log/shardingsphere-proxy/

docker network create --subnet=172.8.8.0/24 mysqlnet

docker run -d \
--name ssp1 \
--net mysqlnet \
--restart no \
-p 3308:3308 \
-v /mnt/disk1/shardingsphere-proxy/conf:/opt/shardingsphere-proxy/conf/ \
-v /mnt/disk1/shardingsphere-proxy/ext-lib/:/opt/shardingsphere-proxy/ext-lib/ \
-v /mnt/disk1/log/shardingsphere-proxy/:/opt/shardingsphere-proxy/logs/ \
-e JVM_OPTS='-Djava.awt.headless=true' \
-e PORT=3308 \
apache/shardingsphere-proxy:5.1.0
```

## 2. Deploy on Kubernetes

- [https://github.com/wl4g/xcloud-shardingproxy#14-for-kubernetesproduction-recommend](https://github.com/wl4g/xcloud-shardingproxy#14-for-kubernetesproduction-recommend)
