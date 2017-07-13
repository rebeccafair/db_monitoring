FROM mysql:5.7.18

ENV MYSQL_ROOT_PASSWORD="Password!1"
ENV MYSQL_DATABASE="test"


# Enable Percona repository and download Percona monitoring client
RUN apt-get update
RUN apt-get install -y wget lsb-release vim
RUN wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
RUN dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
RUN apt-get update
RUN apt-get install -y pmm-client

ADD general_log.cnf /etc/mysql/conf.d

# Copy db schema to db init directory
#ADD dummy_data/create_user_table.sql /docker-entrypoint-initdb.d

# Copy script for connecting to pmm_server (run manually on startup)
#COPY pmm_connect.sh .
#COPY pmm_connect.sh /docker-entrypoint-initdb.d
#RUN cat pmm_connect.sh entrypoint.sh > combined.txt; mv combined.txt entrypoint.sh
# Note: Must wait for db to populate before pmm-admin gets configured
#RUN cat pmm_connect.sh >> entrypoint.sh
#RUN sed -i -e "/echo 'FLUSH PRIVILEGES ;' | \"\${mysql\[@\]}\"/r pmm_connect.sh" entrypoint.sh
#RUN sed -i '176r pmm_connect.sh' entrypoint.sh
#RUN sed -i '176r pmm_connect.sh' /usr/local/bin/docker-entrypoint.sh
