#!/bin/bash

#wget https://dl.influxdata.com/kapacitor/releases/kapacitor-1.3.1.x86_64.rpm
#sudo yum localinstall kapacitor-1.3.1.x86_64.rpm
#rm kapacitor-1.3.1.x86_64.rpm

sudo yum install -y kapacitor

sudo cp kapacitor.conf /etc/kapacitor

sudo systemctl enable kapacitor
sudo systemctl start kapacitor
#sudo systemctl daemon-reload
#sudo systemctl restart kapacitor

# Note: Ensure DB retention policy is correct when defining alerts!
# 'kapacitor stats ingress' to view dbrp for different data streams
kapacitor define load_alert -type stream -tick load_alert.tick -dbrp telegraf.autogen

