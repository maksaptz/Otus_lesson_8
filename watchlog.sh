#!/bin/sh

cat << EOF > /etc/sysconfig/watchlog
# Configuration file for my watchlog service
# Place it to /etc/sysconfig
# File and word in that file that we will be monit
WORD="ALERT"
LOG=/var/log/watchlog.log
EOF

cat << EOF > /var/log/watchlog.log
dsnjkadhsjadbsadsa
dsgfh ALERT
dasdsabgfdgh
dsadsadsa
dsadsadsadsa
dsadsadsadsadsa
dsadsdsadsdsasdadsadaasd
EOF

cat << EOF > /opt/watchlog.sh
#!/bin/bash

WORD=\$1
LOG=\$2
DATE=`date
`
if grep \$WORD \$LOG &> /dev/null
then
logger "\$DATE: Look!!!"
else
exit 0
fi
EOF

chmod +x /opt/watchlog.sh

cat << EOF > /etc/systemd/system/watchlog.service

[Unit]
Description=My watchlog service

[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/watchlog
ExecStart=/opt/watchlog.sh \$WORD \$LOG
EOF

cat << EOF > /etc/systemd/system/watchlog.timer

[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnUnitActiveSec=30
Unit=watchlog.service

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start watchlog.timer
systemctl start watchlog.service
