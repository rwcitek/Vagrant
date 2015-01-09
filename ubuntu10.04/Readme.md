# Multiple-NIC VirtualBox VM


These are a collection of scripts that create a Vagrant environment
to produce a VM of Ubuntu Lucid (10.04) with 8 NIC adapters, which
allows for bonding (configured in pt4).

One runs the scripts in order:

    bash -x init.pt1.sh
    bash -x init.pt2.sh
    bash -x init.pt3.sh
    bash -x init.pt4.sh
    

