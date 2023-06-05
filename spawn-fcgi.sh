#!/bin/sh

yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid -y ### устанавливаем необходимые пакеты

sed -i 's/#SOCKET/SOCKET/' /etc/sysconfig/spawn-fcgi ### правим конфиг
sed -i 's/#OPTIONS/OPTIONS/' /etc/sysconfig/spawn-fcgi ### правим конфиг

cat << EOF > /etc/systemd/system/spawn-fcgi.service ###  создаем юнит

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

systemctl daemon-reload ### перечитываем юниты
systemctl start spawn-fcgi ###стартуем наш новый юнит
