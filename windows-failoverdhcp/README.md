Purpose
=======
This vagrant environment installs two windows 2012r2 server with DHCP in HA A/A Failover and two member servers who uses the new dhcp network.

This can be used as a base to stand up labs for testing. Modify the nodes.yml to add additional servers.

Requirements
============

The following packages must be installed on your Host you intend on running all of this from.

VirtualBox (https://www.virtualbox.org/)

Vagrant (https://www.vagrantup.com/)

For the box type chose your own windows flavor box. (i used devopsguys/Windows2012R2Eval and updated it to be my own.)

Usage
=====

http://everythingshouldbevirtual.com/learning-vagrant-and-ansible-provisioning

Update nodes.yml to reflect your desired nodes to spin up.

Scripts
============
install_ha_dhcp.ps1 - Installs and configures HA-DHCP

Spin up your environment
========================

vagrant up

License
=======

BSD

Author Information
==================

David Stamen
- @davidstamen
- http://davidstamen.com
- dstamen [at] gmail.com
