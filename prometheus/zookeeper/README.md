# Prometheus Integration for Zookeeper

## 1. Catalog

- [zookeeper-alert-rules.yml](zookeeper-alert-rules.yml)

## 2. Configuring

- zkEnv.sh

```bash
echo 'export SERVER_JVMFLAGS="$SERVER_JVMFLAGS -Djava.net.preferIPv4Stack=true -javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=12181:/etc/emr/agent-conf/zookeeper-jmx-rules.yml"' >> $ZOO_HOME/bin/zkEnv.sh
```

- Testing

```bash
curl localhost:12181/metrics
```
