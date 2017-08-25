#!/bin/bash

# Install dependency
sudo yum install -y perl-DBD-MySQL

wget https://www.percona.com/downloads/percona-toolkit/3.0.4/binary/redhat/7/x86_64/percona-toolkit-3.0.4-1.el7.x86_64.rpm
sudo rpm -Uvh percona-toolkit-3.0.4-1.el7.x86_64.rpm
rm percona-toolkit-3.0.4-1.el7.x86_64.rpm


