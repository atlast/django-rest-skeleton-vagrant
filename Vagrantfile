# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    # Box: Ubuntu 14.x 64bit
    config.vm.box = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  
    # API port
    config.vm.network "forwarded_port", guest: 8000, host: 8000
  
    # Postgresql port
    config.vm.network "forwarded_port", guest: 5432, host: 5432
  
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision/ansible.yml"
    end
  
    # config.vm.provision "shell", path: "config/boot.sh", privileged: false, run: "always"
  end
  