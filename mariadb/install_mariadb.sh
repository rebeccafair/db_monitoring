MYSQL_PASSWORD="Password!1"
PMM_SERVER="vm265.nubes.stfc.ac.uk:8080"

# Install MariaDB
sudo cp MariaDB.repo /etc/yum.repos.d/
sudo yum install -y MariaDB-server MariaDB-client
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Next run sudo mysql_secure_installation and set root passwords

# Input test data into mysql
#git clone https://github.com/datacharmer/test_db.git
#cd test_db
#mysql -u root -p$MYSQL_PASSWORD < employees_partitioned.sql

# Set variables for monitoring
# For mysql 5.6+ or mariadb 10.0+, only use perofmance_schema. For old versions use slow query log
#mysql -u root -p$MYSQL_PASSWORD -e 'set global slow_query_log=ON;'
#mysql -u root -p$MYSQL_PASSWORD -e 'set global long_query_time=0.5;'
#mysql -u root -p$MYSQL_PASSWORD -e 'set session long_query_time=0.5;'
#mysql -u root -p$MYSQL_PASSWORD -e 'set global innodb_monitor_enable=all;'

#mysql -u root -p$MYSQL_PASSWORD -e "create user if not exists 'reader1' identified by 'Password!1';"
#mysql -u root -p$MYSQL_PASSWORD -e "grant select on employees.* to reader1;"
#mysql -u root -p$MYSQL_PASSWORD -e "create user if not exists 'reader2' identified by 'Password!1';"
#mysql -u root -p$MYSQL_PASSWORD -e "grant select on employees.* to reader2;"
#mysql -u root -p$MYSQL_PASSWORD -e "create user if not exists 'reader3' identified by 'Password!1';"
#mysql -u root -p$MYSQL_PASSWORD -e "grant select on employees.* to reader3;"
