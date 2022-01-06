# Prometheus Integration for CoreDNS

> Use the built-in expose prometheus metrics.

## 1. Catalog

- [coredns](coredns) configuration
  - [/etc/systemd/system/coredns.service](systemd/coredns.service)
  - [/etc/coredns/Corefile](coredns/Corefile.hocon)
- Monitoring alerting configuration
  - [coredns-alert-rules.yml](coredns-alert-rules.yml)

## 2. Deploy on Host

```bash
sudo mkdir -p /etc/coredns
sudo curl -o /etc/coredns/Corefile 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/coredns/coredns/Corefile.hocon'

sudo curl -o /etc/systemd/system/coredns.service 'https://raw.githubusercontent.com/wl4g/prometheus-integration/master/prometheus/coredns/systemd/coredns.service'
```

- Testing

```bash
curl http://localhost:9253/metrics
```

## 3. Deploy on Kubernetes

- prometheus-operator-coredns-service.yaml

```bash
cat <<-'EOF'>prometheus-operator-coredns-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: prometheus-operator-coredns
    chart: prometheus-operator-7.4.0
    heritage: Tiller
    jobLabel: coredns
    release: pharos-prometheus-operator
  name: pharos-prometheus-operator-coredns
  namespace: kube-system
spec:
  clusterIP: None
  ports:
  - name: http-metrics
    port: 9153
    protocol: TCP
    targetPort: 9153
  selector:
    k8s-app: kube-dns
  sessionAffinity: None
  type: ClusterIP
EOF
```

- prometheus-operator-coredns-servicemonitor.yaml

```bash
cat <<-'EOF'>prometheus-coredns-servicemonitor.yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    app: prometheus-operator-coredns
    chart: prometheus-operator-7.4.0
    heritage: Tiller
    release: pharos-prometheus-operator
  name: pharos-prometheus-operator-coredns
  namespace: cattle-prometheus
spec:
  endpoints:
  - bearerTokenFile: /var/run/secrets/kubernetes.io/serviceaccount/token
    port: http-metrics
  jobLabel: jobLabel
  namespaceSelector:
    matchNames:
    - kube-system
  selector:
    matchLabels:
      app: prometheus-operator-coredns
      release: pharos-prometheus-operator
EOF
```

- prometheus-operator-coredns-rule.yaml

```bash
cat <<-'EOF'>prometheus-operator-coredns-rule.yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  annotations:
    prometheus-operator-validated: "true"
  labels:
    app: prometheus-operator
    release: pharos-prometheus-operator
  name: coredns-panic
  namespace: cattle-prometheus
spec:
  groups:
  - name: coredns-panic
    rules:
    - alert: coredns-panic
      annotations:
        description: Coredns panic count is {{ $value }},please check!
      expr: sum by(instance, job, namespace) (coredns_panic_count_total) >= 10
      for: 15m
      labels:
        alertname: coredns-panic
        severity: warning
---
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  annotations:
    prometheus-operator-validated: "true"
  labels:
    app: prometheus-operator
    release: pharos-prometheus-operator
  name: coredns-responses
  namespace: cattle-prometheus
spec:
  groups:
  - name: coredns-responses
    rules:
    - alert: coredns-responses
      annotations:
        description: Coredns has longer response time, please check !
      expr: histogram_quantile(0.99, sum by(le, job) (rate(coredns_dns_request_duration_seconds_bucket[5m])))  *
        10 >= 3
      for: 15m
      labels:
        alertname: coredns-responses
        severity: warning
EOF
```

TODO
