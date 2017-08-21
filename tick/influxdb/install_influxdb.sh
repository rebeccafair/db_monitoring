#!/bin/bash

sudo cp influxdb.repo /etc/yum.repos.d/

sudo yum install -y influxdb
sudo systemctl enable influxdb
sudo systemctl start influxdb
