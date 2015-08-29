Purpose
=======
This vagrant environment installs a windows 2012r2 server with AD/DNS/DHCP and a member server who uses the new dhcp network.

This can be used as a base to stand up labs for testing.

Requirements
============

The following packages must be installed on your Host you intend on running all of this from.

VirtualBox (https://www.virtualbox.org/)
Vagrant (https://www.vagrantup.com/)

Usage
=====

http://everythingshouldbevirtual.com/learning-vagrant-and-ansible-provisioning

````
Update nodes.yml to reflect your desired nodes to spin up.

Spin up your environment
````
vagrant up
````

License
-------

BSD

Author Information
------------------

David Stamen
- @davidstamen
- http://davidstamen.com
- dstamen [at] gmail.com

Base scripts that were customized, were provided by
---------------------------------------------------
Larry Smith Jr.
- @mrlesmithjr
- http://everythingshouldbevirtual.com
- mrlesmithjr [at] gmail.com
