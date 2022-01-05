# Prometheus Integration for JVM

## 1. Catalog

- [dashboard-kafka-metrics-11962-rev4.json](dashboard-kafka-metrics-11962-rev4.json)
- [kafka08-jmx-rules.yml](kafka08-jmx-rules.yml)
- [kafka20-jmx-rules.yml](kafka20-jmx-rules.yml)
- [kafka-connect-jmx-rules.yml](kafka-connect-jmx-rules.yml)
- [kafka-alert-rules.yml](kafka-alert-rules.yml)

## 2. Configuring

- Detail refer to: [https://blogs.wl4g.com/archives/2381](https://blogs.wl4g.com/archives/2381)

```bash
KEY1='exec $base_dir/kafka-run-class.sh $EXTRA_ARGS kafka.Kafka "$@"'
KEY2='export KAFKA_OPTS="-javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=10105:/etc/emr/agent-conf/kafka20-jmx-rules.yml"'
sed -i "s#$KEY1#$KEY2\n$KEY1#g" $KAFKA_HOME/bin/kafka-server-start.sh
```
