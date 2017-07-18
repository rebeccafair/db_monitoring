#!/bin/bash

# Install JDK 8+
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"
sudo yum localinstall -y jdk-8u131-linux-x64.rpm
rm jdk-8u131-linux-x64.rpm

# Import Elasticsearch signing key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Enable elasticsearch repo
sudo cp elasticsearch.repo /etc/yum.repos.d/

# Install elasticsearch
sudo yum install -y elasticsearch

# Start elasticsearch on boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

# Test elasticsearch
sudo systemctl status elasticsearch

# Install x-pack for elasticsearch
ES_HOME=/usr/share/elasticsearch
(cd $ES_HOME && exec sudo bin/elasticsearch-plugin install --batch x-pack)
sudo systemctl restart elasticsearch
sudo systemctl status elasticsearch

