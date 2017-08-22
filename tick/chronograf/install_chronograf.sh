#!/bin/bash

sudo yum -y install chronograf

sudo systemctl enable chronograf
sudo systemctl start chronograf

# Connect to Chronograf on port 8888
