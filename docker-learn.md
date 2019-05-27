```shell
yum install docker
systemctl enable docker  #开机启动
service docker start

#mysql
docker search mysql
docker pull mysql

docker images #列出本地镜像
docker run --name 自定义名字 -p 主机端口:容器端口 -d  应用名
docker ps 
docker stop/start 容器id
docker rm 镜像名/容器id


docker run --name mysql01 -e MYSQL_ROOT_PASSWORD=triplog1 -d -p 3306:3306 mysql


```

