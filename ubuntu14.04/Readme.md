# Ubuntu 14.04 with ansible

## building a VM

The base Vagrantfile file creates an Ubuntu 14.04 virtual machine and then installs
ansible

```
  vagrant up --provision # if VM is not running
  vagrant provision  # if VM is running
```

