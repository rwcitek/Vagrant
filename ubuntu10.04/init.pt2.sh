#!/bin/bash

vmname=$(grep -m1 -o 'VM:.*' vagrant.up.log.txt  | cut -d: -f2) &&
touch package.box &&
rm -rf package.box &&
vagrant package --base ${vmname} &&
vagrant box add --force lucid64_8nic package.box  &&
vagrant destroy -f default

