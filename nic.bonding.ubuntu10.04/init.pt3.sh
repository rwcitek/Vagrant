#!/bin/bash

mkdir -p shell

# create init script
cat <<'eof' > shell/init.sh
#!/bin/bash
eof

# create Vagrantfile
cat <<'eof' > Vagrantfile
Vagrant.configure(2) do |config|
  config.vm.box = "lucid64_8nic"
  config.vm.synced_folder "shell/", "/vagrant" 
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 1, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 2, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 3, auto_config: false
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--nic4", "nat", "--natpf4", "ssh,tcp,127.0.0.1,2222,,22"]
  end
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 5, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 6, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 7, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 8, auto_config: false
end
eof

# start/restart VM with Vagrant
vagrant halt
vagrant up
echo done

