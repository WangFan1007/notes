# 安装 rpm 安装包

## 初始密码 
 `grep 'temporary password' /var/log/mysqld.log`
## 更改密码
`mysql> set global validate_password_policy=0; `
<br>`set global validate_password_length=1;`
<br>`ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';`


## 按年月日分组统计查询

```sql
CREATE TABLE t_user(
	id integer NOT NULL PRIMARY KEY,
	username varchar(20),
	pwd varchar(40),
	regTime date
);

SELECT DATE_FORMAT(regTime,'%Y-%m-%d'),COUNT(*) FROM t_user GROUP BY DATE_FORMAT(regTime,'%Y-%m-%d');
```


## 配置
```
show variables like '%char%';
character_set_database
character_set_server
```