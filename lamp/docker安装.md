# 1. Docker 安装

Os: win7

下载路径: https://github.com/docker/toolbox/releases  https://get.daocloud.io/toolbox/

下载版本 DockerToolbox-18.09.0.exe

使用的最新版本报错，否则报错: msg="Unable to use system certificate pool: crypto/x509: system root pool is not available on Windows"

 

启动的时候,会提示需要下载 最新版本的boot2docker.iso 

Dockser 会一直卡在这里， 

手动下载https://github.com/boot2docker/boot2docker/releases 

boot2docker.iso v19.03.5

然后将文件放在：C:\Users\Administrator\.docker\machine\cache 

再启动docker 就ok了。

 

# 2    Docker go 镜像

​	下载镜像：docker pull Ubuntu

​    运行：docker run -t -i ubuntu /bin/bash

​     Docker go dockerfile

```shell
#
# Go Dockerfile
#
# https://github.com/dockerfile/go
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Go
RUN \
  mkdir -p /goroot && \
  curl https://storage.googleapis.com/golang/go1.11.8.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Define working directory.
WORKDIR /gopath

# Define default command.
CMD ["bash"]
```

运行命令：

```shell
docker run -it -d  -v /g/gopro:/gopro b253458d3e9e  [image_id]  /bin/bash
                      本地目录：docker目录 -p 本地port：dockerport          

#批量删除多个 docker容器  rm 删除容器  rmi  删除镜像
docker rm -v $(docker ps -aq -f status=exited)
docker search golang 

# 生成新镜像
docker commit  -m ""  -a  容器id  新的镜像名称  如：[coollyj/test]

#运行容器
docker exec  -it  容器id  /bin/bash
docker attach 

#tag 
docker tag IMAGEID(镜像id) REPOSITORY:TAG（仓库：标签）
docker tag b253458d3e9e  docker.io/coollyj/redis

C:\Users\Administrator\Documents\Kitematic\gracious_kirch\go
```

# 3.docker-compose lnmp

文件结构

--lnmp|--redis

​            |--php7.2fpm

​            |--mysql

​            |--ngnix

​            |--jenkins

​            |--mongdb

​            |--docker-compose.yml

![image-20191125103615860](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20191125103615860.png)



docker-compose.yml

```





```

## redis 镜像构建 

运行命令  docker  run   -it    -p 6666:6379     coollyj/ygx-redis:v0.01 /bin/sh 

建造镜像命令： docker  build  -t    coollyj/ygx-redis4.0.14:v0.01  . 

dockerfile:

```shell
from alpine:latest
MAINTAINER mike "mike@365oa.com" 
 
WORKDIR /
copy dockerfile dockerfile

##添加阿里云的源 当前alpine为3.10  在首行添加一行  
#RUN apk add sed 
RUN sed  -i '1i http://mirrors.aliyun.com/alpine/v3.10/community\n\n' /etc/apk/repositories
RUN sed  -i '1i http://mirrors.aliyun.com/alpine/v3.10/main\n\n' /etc/apk/repositories

#apk update
RUN  apk add  --no-cache wget g++ gcc libxslt-dev python3-dev openssl-dev  linux-headers

#Redis-4.0.14
RUN	mkdir /download 
WORKDIR /download 
  
RUN  apk add make 	
RUN wget http://download.redis.io/releases/redis-4.0.14.tar.gz \
     && tar zxvf redis-4.0.14.tar.gz \ 
	 && cd redis-4.0.14 \
	 && make \
	 && make install 
	 
RUN cp  /download/redis-4.0.14/redis.conf  /etc/redis.conf	 
	 
WORKDIR /usr/local/bin

CMD /usr/local/bin/redis-server /etc/redis.conf
#ENV  REDIS_HOME=/usr/local/bin 
```



## mysql5.7.28 镜像 

建造镜像命令：docker build -t coollyj/tgx-mysql5.7.28:v0.01 .

dockerfile:





## nginx 镜像 

建造镜像命令：docker build -t coollyj/tgx-nginx1.6.1:v0.01 .

dockerfile:



## php7.133-fpm 镜像 

建造镜像命令：docker build -t coollyj/tgx-php7.1.33fpm:v0.01  .

原来的生产环境为7.0.33，选择用Stable 版本 7.1.33 

dockerfile:



## jenkins 镜像





# 4.参考

  docker php扩展安装    https://blog.csdn.net/liyyzz33/article/details/97265262 

 sed 添加一行  https://www.cnblogs.com/jeffkuang/articles/7799282.html  

​                          https://blog.csdn.net/baidu_33615716/article/details/78871190 

apk  https://pkgs.alpinelinux.org/packages?name=ncurses&branch=v3.10&repo=main&arch=x86_64&maintainer=7heo 