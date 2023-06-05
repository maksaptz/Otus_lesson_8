#!/bin/sh

yum install httpd -y ### устанавливаем апач

sed '22a\EnvironmentFile=/etc/sysconfig/httpd-%I' /usr/lib/systemd/system/httpd.service ### правим юнит systemd, чтобы сделать доступным шаблоны
touch /etc/sysconfig/{httpd-first,httpd-second} ### создаем файлы которые будут отсылать систему к конфигам
echo 'OPTIONS=-f conf/first.conf' > /etc/sysconfig/httpd-first ### указываем путь к 1 конфигу
echo 'OPTIONS=-f conf/second.conf' > /etc/sysconfig/httpd-second ### указываем путь ко 2 конфигу
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf ### создаем 1 конфиг
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf ### создаем 2 конфин
sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/second.conf ### правим порт во твором конфигу
echo 'PidFile /var/run/httpd-second.pid' >> /etc/httpd/conf/second.conf ### правим № процесса
systemctl start httpd@first ### запускаем апач
systemctl start httpd@second
