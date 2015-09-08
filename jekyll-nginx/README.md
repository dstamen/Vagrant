Purpose
=======
This vagrant environment installs an ubuntu 14.04 server with NGINX.

This can be used as a base to stand up labs for testing. Modify the nodes.yml to add additional servers.

Requirements
============

The following packages must be installed on your Host you intend on running all of this from.

VirtualBox (https://www.virtualbox.org/)

Vagrant (https://www.vagrantup.com/)

Usage
=====

http://everythingshouldbevirtual.com/learning-vagrant-and-ansible-provisioning

Update nodes.yml to reflect your desired nodes to spin up.

Scripts
============
bootstrap_linux_nginx.sh - installs NGINX

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
