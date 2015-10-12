Purpose
=======
This vagrant environment installs an Ubuntu Box with KVM.

This can be used as a base to stand up labs for testing. Modify the nodes.yml to add additional servers.

Requirements
============

The following packages must be installed on your Host you intend on running all of this from.

VirtualBox (https://www.virtualbox.org/)

Vagrant (https://www.vagrantup.com/)


Usage
=====

Update nodes.yml to reflect your desired nodes to spin up.

Scripts
============
install_kvm.sh - Installs and Configures Ubuntu for KVM

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
