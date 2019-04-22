# 安装
1. 下载对应版本解压，复制到`/usr/local/mongodb`
2. `mongod --help`查看操作
3. 编写`start.sh`并启动数据库
    ```
    #bin/bash
    ./mongod --dbpath=/usr/local/mongodb/data/ \
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
1. 插入数据 `db.集合.insert()`
    ```
    >use dbname
    >db.goods.insert({name:'huawei01',weight:135,number:35})
    >db.goods.insert({name:'xiaomi5',price:'1999',weight:'156',number:45,area:{province:'beijing',city:'beijing'}})
    >db.goods.insert({name:'xiaomimax',price:'4999',weight:'156',number:45,area:{province:'beijing',city:'beijing'},color:['black','white','red']})

    >db.goods.insert({name:'iphonex',price:'6999',weight:'156',number:45,area:{province:'chengdu',city:'sichuan'},color:['black','white','golden']})
    ```

2. 查询数据`db.集合.find()` [文档](https://docs.mongodb.com/manual/reference/operator/query/)
    ```
    db.goods.find() //全部查出
    db.goods.findOne()
    db.goods.find({name:'xiaomi5'})
    //条件查询
    //  >       <       >=      <=
    //  $gt     $lt     $gte    $lte

    //bad query
    db.goods.find({price:{'$lt':2000}})
    //right query
    db.goods.find({price:{$lt:"3000"}})

    //多维查询
    db.goods.find({'area.province':'beijing'})

    //

    db.goods.find({color:'red'})

    db.goods.find({color:{$all:['red','black']}})

    //显示哪些数据
    db.goods.find({color:{$all:['red','black']}},{name:1,_id:0})
    db.goods.find({},{name:1})

    //
    db.goods.find({$or:[{price:{$gt:'5000'}},{'area.city':'beijing'}]})

    db.goods.find().skip(2).limit(2)
    ```

3. 修改数据`db.集合.update({条件},{值})`
    ```
    db.goods.update({name:'iphonex'},{$set:{price:5999}})
    ```

4. 删除数据`db.集合.remove({条件})`
    ```
    db.goods.remove({price:'1999'})
    ```

5. php mongodb 扩展现在[pecl](http://pecl.php.net/)

