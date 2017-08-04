# Install php and modules
#sudo yum install -y php php-gd php-ctype php-xml php-xmlreader \
#                    php-xmlwriter php-session php-net-socket php-mbstring \
#                    php-gettext php-mysqli

# Need to get Remi repository to install certain php modules
#wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#sudo rpm -Uvh epel-release-latest-7*.rpm
#rm epel-release-latest-7.noarch.rpm
#wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
#sudo rpm -Uvh remi-release-7*.rpm
#rm remi-release-7.rpm
#sudo yum --enablerepo=remi install -y php-bcmath php-xml

# Install apache server
#sudo yum install -y htttpd
#sudo systemctl enable httpd
#sudo systemctl start httpd

# Get Zabbix rpm
#sudo rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
#sudo yum install -y zabbix-server-mysql zabbix-web-mysql

# Create MySQL zabbix db/user and set permissions
MYSQL_PASSWORD='Password!1'
#mysql -u root -p$MYSQL_PASSWORD -e "create database zabbix character set utf8 collate utf8_bin;"
#mysql -u root -p$MYSQL_PASSWORD -e "grant all privileges on zabbix.* to zabbix@localhost identified by 'Password!1';"
#zcat /usr/share/doc/zabbix-server-mysql-3.2.7/create.sql.gz | mysql -u zabbix -p$MYSQL_PASSWORD zabbix

# Copy configurations
#sudo cp zabbix_server.conf /etc/zabbix/
#sudo cp zabbix.conf /etc/httpd/conf.d/
sudo cp zabbix.conf.php /usr/share/zabbix/conf/

# Enable Zabbix to connect to server (if SELinux enabled)
#setsebool -P httpd_can_connect_zabbix on
#sudo systemctl restart httpd

# Start Zabbix
#sudo systemctl start zabbix-server
#sudo systemctl enable zabbix-server
# Then follow instructions here https://www.zabbix.com/documentation/3.2/manual/installation/install#installing_frontend
