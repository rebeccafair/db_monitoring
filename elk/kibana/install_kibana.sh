#!/bin/bash

# Import Kibana signing key
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Enable Kibana repo
sudo cp kibana.repo /etc/yum.repos.d/

# Install kibana
sudo yum install -y kibana
sudo cp kibana.yml /etc/kibana

# Start kibana on boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service

# Test kibana
sudo systemctl status kibana

