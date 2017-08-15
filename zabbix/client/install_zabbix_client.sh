sudo rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
sudo yum install -y zabbix-agent

sudo cp zabbix_agentd.conf /etc/zabbix/
sudo systemctl enable zabbix-agent

MYSQL_PASSWORD="Password!1"
mysql -u root -p$MYSQL_PASSWORD -e "grant select, process, replication client on *.* to 'zabbix'@'localhost' identified by 'Password!1';"

# Need to install plugin manually https://share.zabbix.com/databases/mysql/template-mysql-800-items

# Install Percona monitoring plugin https://www.percona.com/doc/percona-monitoring-plugins/LATEST/zabbix/index.html
sudo yum install -y php php-mysql
sudo yum install percona-zabbix-templates
sudo cp /var/lib/zabbix/percona/templates/userparameter_percona_mysql.conf /etc/zabbix/zabbix_agentd.d/userparameter_percona_mysql.conf
cp ss_get_mysql_stats.php.cnf /var/lib/zabbix/percona/scripts/
# Note: If percona plugins for cacti are installed on the same server, need to change all instances of /tmp/$HOST-mysql_cacti_stats.txt to /tmp/$HOST-mysql_zabbix_stats.txt in scripts in /var/lib/zabbix/percona/scripts dir

sudo systemctl restart zabbix-agent

# Enable log monitoring in Zabbix:
# Add zabbix user to mysql group so it can read slow query log
sudo usermod -a -G mysql zabbix

