# 安装(centOS7)
1. VMware 安装，不选择默认开启网络
2. 安装完成后配置网络
    ```
    vi /etc/sysconfig/network-scripts/ifcfg-ens33

    BOOTPROTO=static
    ONBOOT=yes
    IPADDR=192.168.153.4
    NETMASK=255.255.255.0
    GATEWAY=192.168.153.2
    DNS1=114.114.114.114

    #配置完成后
    service network restart

    #关闭防火墙
    systemctl disable firewalld.service

    #关闭SELINUX
    cd /etc/selinux/
    vim config
    SELINUX=disabled

    #配置网络别名
    vim /etc/hosts
    192.168.153.11  node01
    192.168.153.12  node02
    192.168.153.13  node03
    192.168.153.14  node04

    #克隆出虚拟机后配置静态IP
    #克隆出虚拟机后配置静网络主机名
    vim /etc/sysconfig/network
    NETWORKING=YES
    HOSTNAME=node01
    ```

# shell命令
    ```
    type 命令 #显示对应的可执行文件信息 命令类型（外部命令&内部命令）
    file 文件全路径  #显示文件属性
    help 内部命令帮助
    man  外部命令帮助
        1.用户命令（/bin,/usr/bin,/usr/local/bin）
        2.系统调用
        3.库用户
        4.特殊文件（设备文件）
        5.文件格式 （配置文件语法）
        6.游戏
        7.杂项
        8.管理命令 （/bin,/usr/bin,/usr/local/bin）
    ```


# 脚本文件执行四种方式
```
#在当前进程执行
. 1.txt
source 1.txt
#开启新线程执行
#!/bin/bash
bash 1.txt
```

# 练习脚本创建用户
```
#!/bin/bash
[ ! $# -eq 1 ] && echo "args error..." && exit 2
id $1 &> /dev/null && echo "user exist..." && exit 3
user add $1 &> /dev/null && echo $1 | passwd --stdin $1 &> /dev/null && echo "user added ok" && exit 0
echo "wei zhi cuo wu" && exit 9
```


# ssh 配置
```
#免密钥登陆
ssh-keygen -t dsa -P '' -f /root/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
```

# 安装JDK 下载hadoop-common
```
#配置环境变量
export JAVA_HOME=/usr/java/jdk1.7.0_80
export HADOOP_HOME=/opt/sxt/hadoop-2.6.5
export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

#二次配置JAVA_HOME
    hadoop-env.sh
    mapred-env.sh  
    yarn-env.sh
使用绝对路径赋值其中的JAVA_HOME
```

# hadoop单机配置(伪分布式)
## core-site.xml namenode 与存储位置
```
    <configuration>
            <property>
                    <name>fs.defaultFS</name>
                    <value>hdfs://node01:9000</value>
            </property>
            <property>
                    <name>hadoop.tmp.dir</name>
                    <value>/var/sxt/hadoop/local</value>
            </property>
    </configuration>
```
## hdfs-site.xml 单机
```
    <configuration>
            <property>
                    <name>dfs.replication</name>
                    <value>1</value>
            </property>

            <property>
                <name>dfs.namenode.secondary.http-address</name>
                <value>node01:50090</value>
        </property>
    </configuration>
```
```
[root@node01 hadoop]# cat slaves 
node01
```

# 配置完成操作

```
#格式化
hdfs namenode -format

#启动服务
start-dfs.sh

#测试
hdfs dfs -mkdir -p /user/root
hdfs dfs -put ./hadoop-2.6.5.tar.gz /user/root/

for i in `seq 100000`;do echo "hello sxt $i" >> test.txt;done
hdfs dfs -D dfs.blocksize=1048576 -put test.txt
```

# hadoop完全分布式搭建

## 免登录配置
```
scp id_dsa.pub root@node04:`pwd`/node01.pub
#到相应主机.ssh目录
cat node01.pub >> authorized_keys
```

## core-site.xml
```
<configuration>
        <property>
                <name>fs.defaultFS</name>
                <value>hdfs://node01:9000</value>
        </property>
        <property>
                <name>hadoop.tmp.dir</name>
                <value>/var/sxt/hadoop/full</value>
        </property>
</configuration>
```

## slaves
```
node02
node03
node04
```

## hdfs-site.xml
```
<configuration>
        <property>
                <name>dfs.replication</name>
                <value>2</value>
        </property>
        <property>
                <name>dfs.namenode.secondary.http-address</name>
                <value>node02:50090</value>
        </property>
</configuration>
```

## 配置完成后
```
hdfs namenode -format

#永久关闭防火墙
systemctl disable firewalld
```
