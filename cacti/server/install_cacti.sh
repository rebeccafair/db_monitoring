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

# Install Cacti
sudo yum -y install cacti

# Create Cacti DB and user, and populate DB
mysql -u root -p$MYSQL_PASSWORD -e "create database cacti;"
mysql -u root -p$MYSQL_PASSWORD -e "grant all on cacti.* to 'cacti'@'localhost' identified by 'Password!1';"
mysql -u cacti -p$MYSQL_PASSWORD cacti < /usr/share/doc/cacti-1.1.10/cacti.sql
mysql -u root -p$MYSQL_PASSWORD -e "grant select on mysql.time_zone_name to 'cacti'@'localhost';"
mysql_tzinfo_to_sql /usr/share/zoneinfo/ | mysql -u root -p$MYSQL_PASSWORD mysql

# Copy Cacti config files
sudo cp -p db.php /etc/cacti/
sudo cp cacti.conf /etc/httpd/conf.d/

# Create Cacti user, correct permissions and create poller crontab
sudo useradd cacti -d '/usr/share/cacti' -s '/bin/false'
sudo chown -R cacti:cacti /usr/share/cacti/rra /usr/share/cacti/log /var/log/cacti /var/lib/cacti/rra
(sudo crontab -u cacti -l ; echo "*/5 * * * * /usr/bin/php /usr/share/cacti/poller.php > /dev/null 2>&1") | sudo crontab -u cacti -

# Download percona monitoring plugins for Cacti
sudo yum install -y percona-cacti-templates
# Copy config file
sudo cp ss_get_mysql_stats.php.cnf /etc/cacti/
# Scripts now in /usr/share/cacti/scripts and templates in /usr/share/cacti/resource/percona
# Need to import templates manually from Cacti interface see https://www.percona.com/files/PerconaMonitoringPlugins.pdf

# NOTE:      Cacti v 1.1.10 has a bug where developer logs cause an out of memory error. See fix at https://github.com/Cacti/cacti/issues/829
# ALSO NOTE: Cacti 1.1.10 combined with Percona Monitoring Plugins 1.1.7 has a bug causing MySQL user/password in config file to be 
#            overwritten by empty strings. See fix at https://github.com/percona/percona-monitoring-plugins/issues/40 

# Install Cacti thold plugin for alerting
sudo git clone https://github.com/Cacti/plugin_thold.git /usr/share/cacti/plugins/thold
# Then go to Configuration > Plugin Management then install and enable the plugin
