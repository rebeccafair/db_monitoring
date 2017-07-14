MYSQL_PASSWORD="Password!1"
PMM_SERVER="vm265.nubes.stfc.ac.uk:8080"

# Install mysql and change password
sudo wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
sudo yum install -y mysql-community-server
sudo service mysqld start
mysqladmin -u root -p$(sudo grep -oP '\[Note\] A temporary password is generated for root@localhost: \K(.*)$' /var/log/mysqld.log) password $MYSQL_PASSWORD

# Input test data into mysql
git clone https://github.com/datacharmer/test_db.git
cd test_db
mysql -u root -p$MYSQL_PASSWORD < employees_partitioned.sql

# Set variables for monitoring
# For mysql 5.6+ or mariadb 10.0+, only use perofmance_schema. For old versions use slow query log
mysql -u root -p$MYSQL_PASSWORD -e 'set global slow_query_log=ON;'
mysql -u root -p$MYSQL_PASSWORD -e 'set global long_query_time=1.0;'
mysql -u root -p$MYSQL_PASSWORD -e 'set session long_query_time=1.0;'
mysql -u root -p$MYSQL_PASSWORD -e 'set global innodb_monitor_enable=all;'

# Install PMM Client and connect to PMM Server
sudo yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm
sudo yum install -y pmm-client
sudo pmm-admin config --server $PMM_SERVER #--client-name name
sudo pmm-admin add mysql --create-user --user root --password $MYSQL_PASSWORD 
