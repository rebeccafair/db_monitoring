#!/bin/bash

sudo yum -y install cpan
yes "" | sudo cpan

sudo cpan DBD::mysql

wget https://www.percona.com/downloads/percona-toolkit/3.0.4/binary/redhat/7/x86_64/percona-toolkit-3.0.4-1.el7.x86_64.rpm
sudo rpm -Uvh percona-toolkit-3.0.4-1.el7.x86_64.rpm
rm percona-toolkit-3.0.4-1.el7.x86_64.rpm


