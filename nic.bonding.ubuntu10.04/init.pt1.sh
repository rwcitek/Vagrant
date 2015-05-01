#!/bin/bash

mkdir -p shell

# create init script
cat <<'eof' > shell/init.sh
#!/bin/bash

# remove dhcp from /etc/rc.local
sed -i -e '/eth0/d' /etc/rc.local

# create eth{1..7}
for i in {1..7} ; do
echo "
auto eth${i}
iface eth${i} inet dhcp"
done >> /etc/network/interfaces

# restore insecure ssh key
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
' > ~vagrant/.ssh/authorized_keys

# poweroff
poweroff
eof

# create Vagrantfile
cat <<'eof' > Vagrantfile
Vagrant.configure(2) do |config|
  config.vm.box_url="http://files.vagrantup.com/lucid64.box"
  config.vm.box = "lucid64"
  config.vm.synced_folder "shell/", "/vagrant" 
  config.vm.provision :shell, :path => "shell/init.sh"
end
eof

# startup VM with Vagrant
vagrant up 2>&1 | tee vagrant.up.log.txt
echo done

