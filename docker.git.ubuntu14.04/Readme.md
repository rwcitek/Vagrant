# Ubuntu 14.04 with ansible, git, git-flow, Docker, and Docker-compose

## building a VM to build a box

The base Vagrantfile file creates an Ubuntu 14.04 virtual machine and then installs
ansible, git, git-flow, Docker, and Docker-compose.  ansible is installed
first, which is then used to install and configure the other components.
This makes the Vagrantfile idempotent and can be run multiple
times with either of these commands:

```
  vagrant up --provision # if VM is not running
  vagrant provision  # if VM is running
```

## Creating a new VirtualBox box

Connect to VM, reset vagrant authorized_key file, and poweroff VM

```
vagrant ssh
cat /vagrant/vagrant.default.id_rsa.pub > ~/.ssh/authorized_keys
sudo poweroff
```

Build the box

```
box=lucid64_ansible-git-docker
id=$(cat ./.vagrant/machines/default/virtualbox/id) &&
vmname=$(find ~/VirtualBox\ VMs/ -type f -name '*.vbox' -print0 | xargs -0 fgrep -l ${id} | rev | tr . / | cut -d/ -f2 | rev) &&
touch package.box &&
rm -rf package.box &&
vagrant package --base ${vmname} &&
vagrant box add --force ${box} package.box  &&
rm -rf package.box &&
vagrant destroy -f default

vagrant.box.list | grep ${box}
```



## odds-n-ends

ssh-keygen -y -f ~/.vagrant.d/insecure_private_key > shell/vagrant.default.id_rsa.pub




