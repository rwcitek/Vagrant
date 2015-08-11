# Ubuntu 14.04 with ansible, git, git-flow, Docker, and Docker-compose

The base Vagrantfile file creates an Ubuntu 14.04 virtual machine that
already has ansible, git, git-flow, Docker, and Docker-compose installed.
It then uses ansible to customize the environment.  This makes the Vagrantfile 
idempotent and can be run multiple times with either of these commands:

```
  vagrant up --provision # if VM is not running
  vagrant provision  # if VM is running
```

## Copy public/private key pairs used with git

The Vagrantfile will copy the keys from the ./shell/ folder into the ~/.ssh/ folder on the VM
and make the necessary permissions and ownership changes.  However, you need to copy
the key that you uploaded to GitHub into the ./shell/ folder.  For example, here are the
commands to copy the default public-private key pair into the ./shell/ folder:

```
  cp ~/.ssh/id_rsa ./shell/id_rsa
  cp ~/.ssh/id_rsa.pub ./shell/id_rsa.pub 
```

## Using tsocks for access to the outside world

As vagrant, test

```
sudo tsocks apt-get update
```

As vagrant user, create mock, public SOCKS connection

```
ssh-keygen -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys 
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o GSSAPIAuthentication=no -f -N -D '*:5000' localhost
```

As vagrant user, configure tsocks

```
sudo cp -a /etc/tsocks.conf /etc/tsocks.conf.orig &&
sudo cp -a /etc/tsocks.conf.mock /etc/tsocks.conf
```

As vagrant user, test

```
sudo tsocks apt-get update
```

