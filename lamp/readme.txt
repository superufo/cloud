网络创建
#docker network create -d overlay --attachable my-overlay 
#docker networks create -d bridge --subnet 172.18.0.1/16 lnmp-net

#network_mode: bridge  
docker volume create  db-data

docker build  -t coollyj@php7.0.33fpm:v0.01  .
docker build  -t coollyj/tgx-nginx1.61:v0.02:v0.01  .

docker run -its -p9000:9000 --name ngnix -v ./nginx/conf/vhost:/usr/local/nginx/conf/vhost  ./nginx/app/www/php:/app/www/php  --network lnmp-net coollyj/tgx-nginx1.61:v0.02  /bin/sh

docker exec -its ID  /bin/sh

MySQL段镜像说明
#mysql镜像 https://hub.docker.com/_/mysql/?tab=tags&page=1   
#https://yeasy.gitbooks.io/docker_practice/content/appendix/repo/mysql.html   


使用 deploy
 php7.2fpm: 
    build: ./php7.2fpm
    .......
    #
    labels:
      oa365.com: "mike" 	
	deploy:
	  replicas: 2       #节点
	  update_config:
		parallelism: 2
		delay: 10s
	  restart_policy:
		condition: on-failure
	configs:
		  - my_config		