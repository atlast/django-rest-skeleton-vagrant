VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/vivid64"

    config.vm.network "forwarded_port", guest: 8000, host: 8000, auto_correct: true

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet"
        puppet.manifest_file  = "manifests"
    end

    config.vm.provision "shell", inline: "systemctl restart nginx", run: "always"
    config.vm.provision "shell", inline: "systemctl restart django-app", run: "always"
end