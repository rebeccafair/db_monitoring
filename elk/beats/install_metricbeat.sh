#!/bin/bash

# Install metricbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.5.0-x86_64.rpm
sudo rpm -vi metricbeat-5.5.0-x86_64.rpm
rm metricbeat-5.5.0-x86_64.rpm

# Copy metricbeat configuration
sudo cp metricbeat.yml /etc/metricbeat

# Add metricbeat template to elasticsearch
curl --user elastic:changeme -H 'Content-Type: application/json' -XPUT 'http://vm307.nubes.stfc.ac.uk:9200/_template/metricbeat' -d@/etc/metricbeat/metricbeat.template.json

# Add mysql user for metricbeat data collection
MYSQL_PASSWORD="Password!1"
mysql -u root -p$MYSQL_PASSWORD -e "grant process on *.* to 'metricbeat'@'localhost' identified by 'Password!1';"

# Start metricbeat
sudo /etc/init.d/metricbeat start
