sudo rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
sudo yum install -y zabbix-agent

sudo cp zabbix_agentd.conf /etc/zabbix/
sudo systemctl enable zabbix-agent
sudo systemctl restart zabbix-agent
