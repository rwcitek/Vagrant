#!/bin/bash

mkdir -p shell

# create init script
cat <<'eof' > shell/bonding.sh
#!/bin/bash

# install bonding package
IFENSLAVE=`dpkg -l ifenslave | grep "^ii  ifenslave"`
if [ -z "${IFENSLAVE}" ]
then
    apt-get update
    apt-get install -y ifenslave
fi

# modify modules
cat <<'eofbond' > /etc/modprobe.d/bonding.conf 
alias bond0 bonding
options bond0 mode=0 miimon=100 downdelay=200 updelay=200 max_bonds=2
eofbond

# modify interfaces
cat <<'eofbond' > /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

# The primary network interface
auto bond0
iface bond0 inet static
  address 10.1.1.100
  netmask 255.255.255.0
  gateway 10.1.1.1
  slaves eth1 eth2
  bond-mode 1
  bond-miimon 100

auto eth4
iface eth4 inet manual

auto eth5
iface eth5 inet dhcp
eofbond

# reboot
reboot

eof

# create Vagrantfile
cat <<'eof' > Vagrantfile
Vagrant.configure(2) do |config|
  config.vm.box = "lucid64_8nic"
  config.vm.synced_folder "shell/", "/vagrant" 
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 2, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 3, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 4, auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "intnet", :adapter => 5, auto_config: false
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--nic6", "hostonly", "--hostonlyadapter6", "vboxnet0"]
  end
  config.vm.provision :shell, :path => "shell/bonding.sh"
end
eof

# start/restart VM with Vagrant
vagrant halt
vagrant up
echo done


