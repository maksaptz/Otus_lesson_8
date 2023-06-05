# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
 config.vm.box = "centos/stream8"
  config.vm.box_version = "20210210.0"
  config.vm.hostname = "systemd"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
 end
  config.vm.provision "shell", path: "watchlog.sh"
  config.vm.provision "shell", path: "spawn-fcgi.sh"
  config.vm.provision "shell", path: "httpd.sh"

end
