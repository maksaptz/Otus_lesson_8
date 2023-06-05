#!/bin/sh

yum install httpd -y

sed '22a\EnvironmentFile=/etc/sysconfig/httpd-%I' /usr/lib/systemd/system/httpd.service
touch /etc/sysconfig/{httpd-first,httpd-second}
echo 'OPTIONS=-f conf/first.conf' > /etc/sysconfig/httpd-first
echo 'OPTIONS=-f conf/second.conf' > /etc/sysconfig/httpd-second
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf
sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/second.conf
echo 'PidFile /var/run/httpd-second.pid' >> /etc/httpd/conf/second.conf
systemctl start httpd@first
systemctl start httpd@second
