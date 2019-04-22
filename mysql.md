# 安装 rpm 安装包

## 初始密码 
 `grep 'temporary password' /var/log/mysqld.log`
## 更改密码
`mysql> set global validate_password_policy=0; `
<br>`set global validate_password_length=1;`
<br>`ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';`