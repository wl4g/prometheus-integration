# Prometheus Integration for Alertmanager

## 1. Catalog

- [alertmanager.yml](alertmanager.yml)
- [template](./template)
  - [email.tpl](template/email.tpl)

## 2. Deploy on Host

- ADD prometheus alerts dingtalk plugin. (Optional)

```bash
curl -L -O 'https://github.com/timonwong/prometheus-webhook-dingtalk/releases/download/v2.0.0/prometheus-webhook-dingtalk-2.0.0.linux-amd64.tar.gz'

cat > /etc/systemd/system/prometheus-webhook-dingtalk.service << EOF
[Unit]
Description=webhook-dingding
Documentation=https://prometheus.io/
After=network.target

[Service]
Type=simple
User=prometheus
ExecStart=/mn/disk1/alertmanager/plugins/prometheus-webhook-dingtalk \
--ding.profile="ads=https://oapi.dingtalk.com/robot/send?access_token=284de68124e97420a2ee8ae1b8f12fabe3213213213" \
--ding.profile="ops=https://oapi.dingtalk.com/robot/send?access_token=8bce3bd11f7040d57d44caa5b6ef9417eab24e1123123123213" 
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable prometheus-webhook-dingtalk
systemctl start prometheus-webhook-dingtalk
systemctl status prometheus-webhook-dingtalk

# Checking dingtalk plugin
netstat -anplt|grep 8060
tcp6       0      0 :::8060                 :::*                    LISTEN      1635/prometheus-web
```
