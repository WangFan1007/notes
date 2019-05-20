# 参照 `NameNode HA With QJM`

## zookeeper搭建
### /etc/profile
```
export ZOOKEEPER_HOME=/opt/zookeeper-3.4.14
export PATH=$PATH:$ZOOKEEPER_HOME/bin
```
### zoo.cfg
```
dataDir=/var/hadoop/zk
...
server.1=192.168.153.12:2888:3888
server.2=192.168.153.13:2888:3888
server.3=192.168.153.14:2888:3888
```
### myid
```
mkdir /var/hadoop/zk
echo 1|2|3 > /var/hadoop/zk/myid
```

### 分发到其他节点并创建目录，修改myid,配置环境变量
```
scp -r zookeeper-3.4.14 root@node03:`pwd`
```

## hadoop HA
### hdfs-site.xml
```
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
    <property>
        <name>dfs.namenode.http-address</name>
        <value>node01:50070</value>
    </property>

     <property>
        <name>dfs.nameservices</name>
        <value>mycluster</value>
    </property>

    <property>
        <name>dfs.ha.namenodes.mycluster</name>
        <value>nn1,nn2</value>
    </property>

    <property>
        <name>dfs.namenode.rpc-address.mycluster.nn1</name>
        <value>node01:8020</value>
    </property>
    <property>
        <name>dfs.namenode.rpc-address.mycluster.nn2</name>
        <value>node02:8020</value>
    </property>

    <property>
        <name>dfs.namenode.http-address.mycluster.nn1</name>
        <value>node02:50070</value>
    </property>
    <property>
        <name>dfs.namenode.http-address.mycluster.nn2</name>
        <value>node01:50070</value>
    </property>

    <property>
  	<name>dfs.namenode.shared.edits.dir</name>
  	<value>qjournal://node01:8485;node02:8485;node02:8485/mycluster</value>
    </property>

    <property>
  	<name>dfs.journalnode.edits.dir</name>
  	<value>/var/hadoop/ha/jn</value>
   </property>

    <property>
  	<name>dfs.client.failover.proxy.provider.mycluster</name>
  	<value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
    </property>
	
    <property>
      <name>dfs.ha.fencing.methods</name>
      <value>sshfence</value>
    </property>

    <property>
      <name>dfs.ha.fencing.ssh.private-key-files</name>
      <value>/root/.ssh/id_dsa</value>
    </property>
    <property>
   	<name>dfs.ha.automatic-failover.enabled</name>
   	<value>true</value>
    </property>

</configuration>

```

### core-site.xml
```
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://mycluster</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/var/hadoop/ha</value>
    </property>
    <property>
   	<name>ha.zookeeper.quorum</name>
   	<value>node02:2181,node03:2181,node04:2181</value>
    </property>

</configuration>
```

### 分发配置
```
scp hdfs-site.xml core-site.xml node02:`pwd`
scp hdfs-site.xml core-site.xml node03:`pwd`
scp hdfs-site.xml core-site.xml node04:`pwd`
```

### nameNode 之间的免密配置
```
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat id_dsa >> authorized_keys
ssh localhost
exit
scp id_dsa.pub root@node01:`pwd`/node02.pub

```


## 启动journal
```
hadoop-daemon.sh start journalnode

```