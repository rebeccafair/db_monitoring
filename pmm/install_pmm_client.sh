#!/bin/bash

# Install client
sudo yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm
sudo yum install -y pmm-client

# Connect to pmm server
sudo pmm-admin config --server vm265.nubes.stfc.ac.uk:8080 –client-name vm111

# Add mysql monitoring
sudo pmm-admin add mysql --create-user --password 'Password!1' 

