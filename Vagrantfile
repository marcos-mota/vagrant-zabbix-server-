Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "public_network"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-zabbix-server​"
    vb.memory = 4028
    vb.cpus = 04
  end
  config.vm.provision "shell", path:"install.sh"
  end
