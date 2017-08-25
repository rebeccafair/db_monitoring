#!/bin/bash

# Install pip
#sudo yum install -y python-pip
#sudo pip install --upgrade pip

# Install gcc
#sudo yum group install -y "Development Tools"

# Install other prerequisites
#sudo pip install -U setuptools
#sudo yum install -y python-devel

# Install elastalert and ensure elasticsearch compatibility
#sudo pip install -U elastalert
#sudo pip install "elasticsearch>=5.0.0"

# Install via zip
#wget https://github.com/Yelp/elastalert/archive/v0.1.19.tar.gz
#tar -xvzf v0.1.19.tar.gz
#rm -f v0.1.19.tar.gz
#cd elastalert-0.1.19; sudo python setup.py install; sudo pip install -e .

# Create elasticsearch index for elastalert to write to
#sudo pip install -U urllib3
#yes "" | elastalert-create-index --host "vm307.nubes.stfc.ac.uk" --port 9200 --no-auth --no-ssl

# Create elastalert home dir
sudo mkdir -p /etc/elastalert/conf.d
sudo cp config.yaml /etc/elastalert
sudo cp -r elastalert_rules/* /etc/elastalert/conf.d

# Run elastalert as a service
sudo cp elastalert.service /lib/systemd/system/
sudo ln -s /lib/systemd/system/elastalert.service /etc/systemd/system/elastalert.service
sudo systemctl daemon-reload
sudo systemctl enable elastalert.service
sudo systemctl start elastalert.service
sudo systemctl status elastalert.service
