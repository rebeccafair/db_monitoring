pmm-admin config --server pmm_server
#pmm-admin add mysql --user root --password $MYSQL_ROOT_PASSWORD --host localhost
pmm-admin add mysql --create-user --defaults-file ~/.my.cnf 
