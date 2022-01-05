# Prometheus Integration for Etcd

## 1. Catalog

- [etcd-alert-rules.yml](etcd-alert-rules.yml)

## 2. Deploy on Kubernetes

- on host refer to: [https://blogs.wl4g.com/archives/972](https://blogs.wl4g.com/archives/972)

- Notice: example prometheus scrape configuration (`prometheus-configmap.yaml`)

```bash
- job_name: "etcd"
  scheme: https
  tls_config:
    insecure_skip_verify: true
  static_configs:
  - targets: ['172.16.1.100:2379','172.16.1.101:2379','172.16.1.102:2379']
```

- Testing

```bash
# For example, the etcd cluster deployed by kubedm.
cd /etc/kubernetes/pki/etcd
curl -v --cacert ./ca.crt --cert ./peer.crt --key ./peer.key https://127.0.0.1:2379/metrics
```
