#!/bin/bash
sudo apt-get install --no-install-recommends lubuntu-desktop -y
sudo apt-get install qemu-kvm qemu-system libvirt-bin bridge-utils virt-manager -y
sudo adduser vagrant libvirtd
sudo reboot
