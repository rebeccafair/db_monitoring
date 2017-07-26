MYSQL_PASSWORD="Password!1"

# Create Cacti user and add correct privileges
mysql -u root -p$MYSQL_PASSWORD -e "grant super, process on *.* to 'cacti'@'%' identified by 'Password!1';"

# Install dependencies
sudo yum install -y net-snmp net-snmp-libs net-snmp-utils

# Copy configuration and restart
sudo cp snmpd.conf /etc/snmp
sudo systemctl restart snmpd

# Check if snmp works
#snmpwalk -v 2c -c public localhost

# Next add device in Cacti interface, click Management > Devices > Add and choose public for SNMP community. 
# Then create graphs for this host, Create > New Graphs, then select graphs to plot
# See instructions here https://www.percona.com/files/PerconaMonitoringPlugins.pdf
