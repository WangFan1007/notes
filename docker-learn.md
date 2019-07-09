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

# ubuntu18.04
先安装docker-ce
<br>配置非root用户可使用
```bash
sudo groupadd docker     #添加docker用户组
sudo gpasswd -a $USER docker     #将登陆用户加入到docker用户组中
newgrp docker     #更新用户组
docker ps    #测试docker命令是否可以使用sudo正常使用

```

