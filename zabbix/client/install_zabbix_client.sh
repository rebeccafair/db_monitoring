#sudo rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
#sudo yum install -y zabbix-agent

#sudo cp zabbix_agentd.conf /etc/zabbix/
#sudo systemctl enable zabbix-agent
#sudo systemctl restart zabbix-agent

MYSQL_PASSWORD="Password!1"
mysql -u root -p$MYSQL_PASSWORD -e "grant select, replication client on *.* to 'zabbix'@'localhost' identified by 'Password!1';"

# Need to install plugin manually https://share.zabbix.com/databases/mysql/template-mysql-800-items
