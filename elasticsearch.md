## 下载6.7
## 解压启动
```
./elasticsearch #不成功
#创建用户组和用户
groupadd esgroup
useradd esuser -g esuser -p espassword
chown -R esuser:esgroup elasticsearch-xxx

su esuser
./elasticsearch

#允许远程访问
#network.host: 192.168.154.4

#出错
ERROR: [3] bootstrap checks failed
[1]: max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]
[2]: max number of threads [3796] for user [esuser] is too low, increase to at least [4096]
[3]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

#[1]/etc/security/limits.conf
esuser soft nofile 65535
esuser hard nofile 65535
esuser soft nproc 4096
esuser hard nproc 4096

#[2]/etc/security/limits.d/20-nproc.conf
esuser soft nproc 4096

#[3]/etc/sysctl.conf
vm.max_map_count=655360

#使之生效
sysctl -p

```