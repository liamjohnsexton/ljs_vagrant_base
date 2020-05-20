#!/usr/bin/env bash

export PATH=$PATH:/opt/puppetlabs/bin

if puppet --version 2>/dev/null; then
 echo “Puppet installed, nothing to do”
 exit 0
fi

sudo systemctl stop NetworkManager && sudo systemctl disable NetworkManager

sudo cp /var/tmp/files/hosts.home /etc/hosts
sudo cp /var/tmp/files/resolv.home /etc/resolv.conf

sudo yum install -y ntp 
sleep 5
sudo systemctl start ntpd

    if [ $(hostname) == "puppet" ] ; then 

        /var/tmp/files/puppet-enterprise-2019.2.1-el-7-x86_64/puppet-enterprise-installer -c /var/tmp/files/puppet-enterprise-2019.2.1-el-7-x86_64/puppet-enterprise-installer/conf.d/pe.conf

        sudo /opt/puppetlabs/bin/puppet agent -t
        sudo /opt/puppetlabs/bin/puppet agent -t
        sudo /opt/puppetlabs/bin/puppet agent -t
#        sudo cp /var/tmp/files/id_rsa /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa && sudo chown pe-puppet: /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
        #puppet-access login --lifetime 0
        # puppet infrastructure console_password --password=puppet
        # puppet-code deploy --dry-run
        # curl -k -X POST -H 'Content-Type: application/json' -d '{"login": "deploy", "password": "deploy"}' https://localhost:4433/rbac-api/v1/auth/token
        # puppet-code deploy --dry-run

      elif [ $(hostname) == "master-*" ] ; then

            curl -k https://puppet.home:8140/packages/current/install.bash | sudo bash -s main:dns_alt_names=master-01.home,master-02.home,dc1-master,dc2-master
     
            # https://www.puppet.com/docs/pe/2019.2/installing_compile_masters.html

    else

        curl -k https://puppet.home:8140/packages/current/install.bash | sudo bash
        
        # https://puppet.com/docs/pe/2019.2/installing_pe_client_tools.html

    fi

sudo useradd -c "my user" -G wheel myuser

#sudo cat /home/myuser/.ssh/authorized_keys >> /home/vagrant/.ssh/authorized_keys
