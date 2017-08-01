#!/bin/bash

# Install EPEL Repository
#wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
#sudo rpm -ivh epel-release-7-9.noarch.rpm
#sudo yum -y update

# Install apache server
#sudo yum install -y htttpd
#sudo systemctl enable httpd
#sudo systemctl start httpd

# Install Munin
#sudo yum install -y munin munin-node

sudo cp munin.conf /etc/munin/
sudo cp munin-node.conf /etc/munin/
sudo munin-node-configure --shell --families=contrib,auto | sh -x
sudo systemctl enable munin-node
sudo systemctl start munin-node


# Set up authentication
#sudo htpasswd /etc/munin/munin-htpasswd admin
#Then in  /etc/httpd/conf.d/munin.conf change user from Munin to admin

# May also need to add the following line to /etc/hosts.allow
#ALL: .nubes.stfc.ac.uk

#sudo munin-node-configure --snmp vm265.nubes.stfc.ac.uk

