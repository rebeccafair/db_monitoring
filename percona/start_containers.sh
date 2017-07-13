#docker stop pmm_server
#docker stop sql_client_1
docker stop sql_server
#docker rm pmm_server
#docker rm sql_client_1
docker rm sql_server

#docker run -d -p 8080:80 --volumes-from pmm_data --name pmm_server --restart always --network=sql_net percona/pmm-server:1.1.5

#docker run --name sql_client_1 --network=sql_net -t -d sql_client

docker run --name sql_server --network=sql_net -d sql_server
