#!/usr/bin/env bash

export PATH=$PATH:/opt/puppetlabs/bin

if id myuser 2>/dev/null; then
 echo “Puppet installed, nothing to do”
 exit 0
fi

sudo systemctl stop NetworkManager && sudo systemctl disable NetworkManager

sudo cp /var/tmp/files/hosts.home /etc/hosts
sudo cp /var/tmp/files/resolv.home /etc/resolv.conf

sudo yum install -y ntp 
sleep 5
sudo systemctl start ntpd

sudo useradd -c "myuser" -G wheel myuser
