# Install and start docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
wget http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.9-4.el7.noarch.rpm
sudo rpm -Uvh container-selinux-2.9-4.el7.noarch.rpm
rm container-selinux-2.9-4.el7.noarch.rpm
sudo yum install -y docker-ce
sudo systemctl start docker

# Create docker image for storing monitoring data
sudo docker create -v /opt/prometheus/data -v /opt/consul-data -v /var/lib/mysql -v /var/lib/grafana --name pmm_data percona/pmm-server:1.1.5 /bin/true

# Run docker container for PMM Server
sudo docker run -d -p 8080:80 -e METRICS_RETENTION=168h -e METRICS_MEMORY=2097152 --volumes-from pmm_data --name pmm_server --restart always percona/pmm-server:1.1.5
