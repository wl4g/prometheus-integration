# Prometheus Integration for Hadoop

## 1. Configuring

### 1.1 Hadoop Configuring

- ADD jmx agent to NameNode

```bash
KEY1="CLASS='org.apache.hadoop.hdfs.server.namenode.NameNode'"
KEY2='HADOOP_OPTS="$HADOOP_OPTS -javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=18020:/etc/emr/agent-conf/hadoop-jmx-rules.yml"'
sed -i "s#$KEY1#$KEY1\n  $KEY2#g" $HADOOP_HOME/bin/hdfs
```

- ADD jmx agent to DataNode

```bash
KEY1="CLASS='org.apache.hadoop.hdfs.server.datanode.DataNode'"
KEY2='HADOOP_OPTS="$HADOOP_OPTS -javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=18021:/etc/emr/agent-conf/hadoop-jmx-rules.yml"'
sed -i "s#$KEY1#$KEY1\n  $KEY2#g" $HADOOP_HOME/bin/hdfs
```

- ADD jmx agent to ResourceManager

```bash
KEY1="CLASS='org.apache.hadoop.yarn.server.resourcemanager.ResourceManager'"
KEY2='YARN_OPTS="$YARN_OPTS -javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=18032:/etc/emr/agent-conf/hadoop-jmx-rules.yml"'
sed -i "s#$KEY1#$KEY1\n  $KEY2#g" $HADOOP_HOME/bin/yarn
```

- ADD jmx agent to NodeManager

```bash
KEY1="CLASS='org.apache.hadoop.yarn.server.nodemanager.NodeManager'"
KEY2='YARN_OPTS="$YARN_OPTS -javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=18033:/etc/emr/agent-conf/hadoop-jmx-rules.yml"'
sed -i "s#$KEY1#$KEY1\n  $KEY2#g" $HADOOP_HOME/bin/yarn
```

### 1.2 HBase Configuring

- ADD jmx agent to HMaster

```bash
KEY1="CLASS='org.apache.hadoop.hbase.master.HMaster'"
KEY2='HBASE_OPTS="$HBASE_OPTS -javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=10160:/etc/emr/agent-conf/hadoop-jmx-rules.yml"'
sed -i "s#$KEY1#$KEY1\n  $KEY2#g" $HBASE_HOME/bin/hbase
```

- ADD jmx agent to HRegionServer

```bash
KEY1="CLASS='org.apache.hadoop.hbase.regionserver.HRegionServer'"
KEY2='HBASE_OPTS="$HBASE_OPTS -javaagent:/etc/emr/agent-conf/jmx_prometheus_javaagent-0.16.1.jar=10161:/etc/emr/agent-conf/hadoop-jmx-rules.yml"'
sed -i "s#$KEY1#$KEY1\n  $KEY2#g" $HBASE_HOME/bin/hbase
```
