VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/vivid64"

    config.vm.network "forwarded_port", guest: 8000, host: 8000, auto_correct: true

    config.vm.provision :puppet do |puppet|
        puppet.module_path = "modules"
        # puppet.options = "--verbose --debug"
    end
end