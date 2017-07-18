#!/bin/bash

# Install JDK 8+
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"
sudo yum localinstall -y jdk-8u131-linux-x64.rpm
rm jdk-8u131-linux-x64.rpm

# Import Elasticsearch signing key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Enable logstash repo
sudo cp logstash.repo /etc/yum.repos.d/

# Install logstash
sudo yum install -y logstash

# Start logstash on boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable logstash.service
sudo systemctl start logstash.service

# Test logstash
sudo systemctl status logstash
