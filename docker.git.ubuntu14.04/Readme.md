# Ubuntu 14.04 with ansible, git, git-flow, and Docker

The Vagrantfile starts an Ubuntu 14.04 box and then installs
ansible, git, git-flow, and Docker.  Once ansible is installed,
it uses ansible to install and configure the other components.
This makes the Vagrantfile idempotent and can be run multiple
times with either of these commands:

```
  vagrant up --provision # if VM is not running
  vagrant provision  # if VM is running
```

## Copy public/private key pairs used with git

The Vagrantfile will copy the keys from the ./shell/ folder into the ~/.ssh/ folder on the VM
and make the necessary permissions and ownership changes.  However, you need to copy
your keys that are used on GitHub into the ./shell/ folder.  For example, here are the
commands to copy the default public/private keys into the ./shell/ folder:

```
  cp ~/.ssh/id_rsa ./shell/id_rsa
  cp ~/.ssh/id_rsa.pub ./shell/id_rsa.pub 
```

