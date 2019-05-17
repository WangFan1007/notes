# 准备
```
#node02 node03
yum install httpd -y
vim /var/www/html/index.html   (node02 index, node03 index)
service httpd start
#分别访问两台主机ip测试web服务器是否能正常访问
#realserver 还需要配置以下
cd /proc/sys/net/ipv4/conf
cd ens33
echo 1 > arp_ignore
echo 2 > arp_announce
cd ../all
echo 1 > arp_ignore
echo 2 > arp_announce
#realserver也需要配置虚拟ip
ifconfig lo:4 192.168.153.100 netmask 255.255.255.255 broadcast 192.168.153.100


#node01 node04 LVS 主从负载均衡
yum install keepalived -y
```