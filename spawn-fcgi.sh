#!/bin/sh

yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid -y

sed -i 's/#SOCKET/SOCKET/' /etc/sysconfig/spawn-fcgi 
sed -i 's/#OPTIONS/OPTIONS/' /etc/sysconfig/spawn-fcgi

cat << EOF > /etc/systemd/system/spawn-fcgi.service

Description=Spawn-fcgi startup service by Otus
After=network.target

[Service]
Type=simple
PIDFile=/var/run/spawn-fcgi.pid
EnvironmentFile=/etc/sysconfig/spawn-fcgi
ExecStart=/usr/bin/spawn-fcgi -n \$OPTIONS
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start spawn-fcgi
