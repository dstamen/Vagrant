Purpose
=======
This vagrant environment installs a windows 2012r2 server with AD/DNS/DHCP and a member server who uses the new dhcp network.

This can be used as a base to stand up labs for testing. Modify the nodes.yml to add additional servers.

Requirements
============

The following packages must be installed on your Host you intend on running all of this from.

VirtualBox (https://www.virtualbox.org/)

Vagrant (https://www.vagrantup.com/)


Need to download the Windows box from Atlas (vagrant box add devopsguys/Windows2012R2Eval)

Usage
=====

http://everythingshouldbevirtual.com/learning-vagrant-and-ansible-provisioning

Update nodes.yml to reflect your desired nodes to spin up.

Scripts
============
install_lab_dc.ps1 - Installs the domain controller, you can change the password and/or domain name here.
config_lab_dc.ps1 - sets additional permissions and creates OU structure
install_lab_dhcp.ps1 - installs DHCP, adds a scope and configures options
join_lab_domain.ps1 - used to join additional servers to the domain

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

Base scripts that were customized, were provided by
===================================================

Larry Smith Jr.
- @mrlesmithjr
- http://everythingshouldbevirtual.com
- mrlesmithjr [at] gmail.com
