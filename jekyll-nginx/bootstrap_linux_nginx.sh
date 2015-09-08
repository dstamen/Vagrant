#!/bin/bash
sudo apt-get install nginx -y
sudo service nginx start
update-rc.d nginx defaults
