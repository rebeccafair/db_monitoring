MYSQL_PASSWORD="Password!1"

# Install Cacti prerequisites:

# Install MySQL and change password
sudo wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
sudo yum install -y mysql-community-server
sudo service mysqld start
sudo systemctl enable mysqld.service
mysqladmin -u root -p$(sudo grep -oP '\[Note\] A temporary password is generated for root@localhost: \K(.*)$' /var/log/mysqld.log) password $MYSQL_PASSWORD
rm -f mysql57-community-release-el7-11.noarch.rpm

# Install other dependencies (Apache, PHP, PHP-SNMP, NET-SNMP, RRDTool
sudo yum install -y httpd httpd-devel
sudo yum insyall -y php
sudo cp php.ini /etc
sudo yum install -y php-mysql php-pear php-common php-gd php-devel php-mbstring php-cli php-snmp
 If there are issues with httpd do 'sudo cp /usr/lib64/php/modules/* /etc/php.d'
sudo cp httpd.conf /etc/httpd/conf
sudo cp php.conf /etc/httpd/conf.d
sudo yum install -y net-snmp-utils net-snmp-libs
sudo yum install -y rrdtool

# Start Apache and SNMP and configure to start on boot
sudo service httpd start
sudo systemctl enable httpd.service
sudo service snmpd start
sudo systemctl enable snmpd.service

# Install cacti
sudo yum -y install cacti
mysql -u root -p$MYSQL_PASSWORD -e "create database cacti;"
mysql -u root -p$MYSQL_PASSWORD -e "grant all on cacti.* to 'cacti'@'localhost' identified by 'Password!1';"
mysql -u cacti -p$MYSQL_PASSWORD cacti < /usr/share/doc/cacti-1.1.10/cacti.sql
mysql -u root -p$MYSQL_PASSWORD -e "grant select on mysql.time_zone_name to 'cacti'@'localhost';"
mysql_tzinfo_to_sql /usr/share/zoneinfo/ | mysql -u root -p$MYSQL_PASSWORD mysql
sudo cp -p db.php /etc/cacti/
sudo cp cacti.conf /etc/httpd/conf.d/
sudo useradd cacti -d '/usr/share/cacti' -s '/bin/false'
sudo chown -R cacti:cacti /usr/share/cacti/rra /usr/share/cacti/log /var/log/cacti /var/lib/cacti/rra
(sudo crontab -u cacti -l ; echo "*/5 * * * * /usr/bin/php /usr/share/cacti/poller.php > /dev/null 2>&1") | sudo crontab -u cacti -
