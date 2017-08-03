#!/bin/bash

# Install EPEL Repository
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
sudo rpm -ivh epel-release-7-9.noarch.rpm
sudo yum -y update

# Install apache server
sudo yum install -y htttpd
sudo systemctl enable httpd
sudo systemctl start httpd

# Install Munin
sudo yum install -y munin-node
sudo cp munin-node.conf /etc/munin/
sudo munin-node-configure --shell --families=contrib,auto | sh -x
sudo systemctl enable munin-node

# Note: also need to add the new Munin node to the config on the master /etc/munin/munin.conf

# Add Munin user to MySQL
MYSQL_PASSWORD="Password!1"
mysql -u root -p$MYSQL_PASSWORD -e "grant process,super on *.* to 'munin'@'localhost' identified by 'Password!1';"
mysql -u root -p$MYSQL_PASSWORD -e "grant select on mysql.* to 'munin'@'localhost';"

# Install MySQL plugin for Munin
wget https://github.com/kjellm/munin-mysql/archive/master.zip
unzip master.zip
rm -f master.zip

# Install dependencies
sudo yum group install -y "Development Tools"
sudo yum -y install cpan perl-Cache-Cache
yes "" | sudo cpan
sudo cpan DBI DBD::mysql Module::Pluggable

# Copy plugin config
cp Makefile munin-mysql-master
cp mysql.cnf munin-mysql-master
cd munin-mysql-master && sudo make install

# Copy munin-node plugin configs
sudo cp munin-node /etc/munin/plugin-conf.d/

sudo systemctl start munin-node

# To install plugins create symlink from /usr/share/munin/plugins to /etc/munin/plugins
# e.g. ln -s /usr/share/munin/plugins/mysql_ /etc/munin/plugins/mysql_
