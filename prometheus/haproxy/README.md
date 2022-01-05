# Prometheus Integration for Haproxy

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

- Configuring haproxy.cfg

```bash
sudo mkdir -p /etc/haproxy/
sudo cat <<-'EOF'>/etc/haproxy/haproxy.cfg
#---------------------------------------------------------------------
# Example configuration for a possible web application.  See the
# full configuration options online.
#
#   http://haproxy.1wt.eu/download/1.4/doc/configuration.txt
#---------------------------------------------------------------------

global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the '-r' option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #    local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2 notice

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     50000
    user        root
    group       root
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

defaults
    mode                    http # tcp|http|health
    log                     global
    option                  tcplog # tcplog|httplog
    option                  dontlognull
    option http-server-close
    #option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 50000

# Must setup mode=http to be effective, defaults{mode=http} is also possible.
# see: https://www.haproxy.com/blog/haproxy-exposes-a-prometheus-metrics-endpoint/
frontend stats
   bind *:8404
   #option http-use-htx
   #http-request use-service prometheus-exporter if { path /metrics }
   stats enable
   stats uri /stats
   stats refresh 10s

frontend emqx_cluster_proxy
    bind *:1884
    mode                tcp
    default_backend     emqx_cluster

backend emqx_cluster
    mode        tcp
    balance     roundrobin
    server      emqx1 10.65.30.232:1883 check
    server      emqx2 10.65.30.233:1883 check
EOF
```

- Configuring haproxy.service

```bash
sudo cat <<-'EOF'>/etc/sysconfig/haproxy
# Add extra options to the haproxy daemon here. This can be useful for
# specifying multiple configuration files with multiple -f options.
# See haproxy(1) for a complete list of options.
OPTIONS=""
EOF

sudo cat <<-'EOF'>/etc/systemd/system/haproxy.service 
[Unit]
Description=HAProxy Load Balancer
After=network-online.target
Wants=network-online.target

[Service]
EnvironmentFile=-/etc/sysconfig/haproxy
Environment="CONFIG=/etc/haproxy/haproxy.cfg" "PIDFILE=/run/haproxy.pid" "EXTRAOPTS=-S /run/haproxy-master.sock"
ExecStartPre=/bin/haproxy -f $CONFIG -c -q $EXTRAOPTS
ExecStart=/bin/haproxy -DWs -f $CONFIG -p $PIDFILE $EXTRAOPTS
ExecReload=/bin/haproxy -f $CONFIG -c -q $EXTRAOPTS
ExecReload=/bin/kill -USR2 $MAINPID
KillMode=mixed
Restart=always
User=root
Group=root
SuccessExitStatus=143
Type=forking

# The following lines leverage SystemD's sandboxing options to provide
# defense in depth protection at the expense of restricting some flexibility
# in your setup (e.g. placement of your configuration files) or possibly
# reduced performance. See systemd.service(5) and systemd.exec(5) for further
# information.

# NoNewPrivileges=true
# ProtectHome=true
# If you want to use 'ProtectSystem=strict' you should whitelist the PIDFILE,
# any state files and any other files written using 'ReadWritePaths' or
# 'RuntimeDirectory'.
# ProtectSystem=true
# ProtectKernelTunables=true
# ProtectKernelModules=true
# ProtectControlGroups=true
# If your SystemD version supports them, you can add: @reboot, @swap, @sync
# SystemCallFilter=~@cpu-emulation @keyring @module @obsolete @raw-io

[Install]
WantedBy=multi-user.target
EOF
```

- Configuring haproxy_exporter

```bash
sudo mkdir -p /etc/sysconfig/
sudo cat <<-'EOF'>/etc/sysconfig/haproxy_exporter
OPTIONS='--no-haproxy.ssl-verify --haproxy.scrape-uri="http://localhost:8404/stats?stats;csv"'
EOF
```

- Testing

```bash
# 首先测试 haproxy 内置的 /stats
curl "http://localhost:8404/stats?;csv"

# 再测试 haproxy_exporter 接口
curl "http://localhost:9101/metrics"
```

## 3. Deploy on Kubernetes

TODO
