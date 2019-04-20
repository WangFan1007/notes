# 安装
1. 下载对应版本解压，复制到`/usr/local/mongodb`
2. `mongod --help`查看操作
3. 编写`start.sh`并启动数据库
    ```
    #bin/bash
    ./mongod --dbpath=/usr/local/mogodb/data/ \
    --storageEngine=mmapv1 \
    --fork \
    --logpath=/usr/local/mongodb/log.log
    ```
4. `./mongo` 客户端默认连接本地数据库,进入会话后可操作
    ```
    >help           #查看帮助
    >use php61      #创建/使用数据库
    > db.getName()
    php61
    # js shell,可以执行js\
    >function test(a,b,c){print(a+b+c)}
    >test(1,2,3)
    6
    ```

# 数据操作
1. 

