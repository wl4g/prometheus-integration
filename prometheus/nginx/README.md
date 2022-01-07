# Prometheus Integration for Nginx

## 1. Catalog

- [metrics.d](./metrics.d)
  - [prometheus_resty_counter.lua](metrics.d/prometheus_resty_counter.lua)
  - [prometheus.conf](metrics.d/prometheus.conf)
  - [prometheus.lua](metrics.d/prometheus.lua)
- [nginx-alert-rules.yml](nginx-alert-rules.yml)

## 2. Deploy on Host

- [https://github.com/knyar/nginx-lua-prometheus](https://github.com/knyar/nginx-lua-prometheus)

- nginx.conf Configuring

```hocon
http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    # server_tokens off;
    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ssl_prefer_server_ciphers on;
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
    gzip on;

    include /etc/nginx/metrics.d/*.conf;
}
```

TODO

## 3. Deploy on Kubernetes

Kubernetes The [istio](https://istio.io) + [envoy](https://github.com/envoyproxy/envoy) solution is recommended under the ecology !
