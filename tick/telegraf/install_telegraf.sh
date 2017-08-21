#!/bin/bash

# Install Telegraf
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.3.5-1.x86_64.rpm
sudo yum localinstall telegraf-1.3.5-1.x86_64.rpm
rm telegraf-1.3.5-1.x86_64.rpm

# Copy config
sudo cp telegraf.conf /etc/telegraf/

# Create MySQL user
MYSQL_PASSWORD="Password!1"
mysql -u root -p$MYSQL_PASSWORD -e "grant select, process, replication client on *.* to 'telegraf'@'localhost' identified by 'Password!1';"

# Start Telegraf service
sudo systemctl enable telegraf
sudo systemctl start telegraf
