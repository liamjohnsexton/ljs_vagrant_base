# vagrant-base
a very simple vagrant template to built some puppet VMs

Make sure that you download puppet enterprise first and untar in the files directory 

Edit the pe.conf with your customisations

From the root of the module execute 

vagrant up puppet-01 for a puppet master

vagrant up master-01 for a complile master

vagrant up controller-01 for a client-tools VM (this still needs some automation)

This is the very start of a basic puppet deployment and will be developed in time
