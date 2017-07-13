FROM centos:centos7

RUN yum install -y wget
RUN wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
RUN yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
RUN yum -y install mysql-community-client
RUN rm mysql57-community-release-el7-11.noarch.rpm

