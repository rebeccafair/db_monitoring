#!/bin/bash

# Install filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.5.0-x86_64.rpm
sudo rpm -vi filebeat-5.5.0-x86_64.rpm
rm filebeat-5.5.0-x86_64.rpm

# Copy filebeat configuration
sudo cp filebeat.yml /etc/filebeat

# Add filebeat template to elasticsearch
curl --user elastic:changeme -H 'Content-Type: application/json' -XPUT 'http://vm307.nubes.stfc.ac.uk/_template/filebeat' -d@/etc/filebeat/filebeat.template.json

# Start filebeat
sudo /etc/init.d/filebeat start
