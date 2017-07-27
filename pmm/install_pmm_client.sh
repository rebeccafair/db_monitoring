#!/bin/bash

# Install client
sudo yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm

# Connect to pmm server
#sudo pmm-admin config --server pmm_server –client-name vm257

# Add mysql monitoring
#pmm-admin add mysql --create-user --password 'Password!1' 

