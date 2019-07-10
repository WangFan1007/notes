CREATE DATABASE bigData;
use bigData;

CREATE TABLE dept(
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	deptno MEDIUMINT UNSIGNED not NULL DEFAULT 0,
	dname varchar(20) not null DEFAULT "",
	loc varchar(13) not NULL DEFAULT ""
) engine=innodb DEFAULT charset=utf8;

CREATE TABLE emp(
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	empno MEDIUMINT UNSIGNED not NULL DEFAULT 0,
	ename varchar(20) not null  DEFAULT "",
	job varchar(9) not null DEFAULT "",
	mgr MEDIUMINT UNSIGNED not null DEFAULT 0,
	hiredate date not null,
	sal decimal(7,2) not null,
	comm decimal(7,2) not null,
	deptno MEDIUMINT UNSIGNED not null DEFAULT 0
)engine=innodb default charset=utf8;


SHOW variables like 'log_bin_trust_function_creators';
set GLOBAL log_bin_trust_function_creators=1;


delimiter $$
CREATE FUNCTION rand_string(n int) RETURNS varchar(255)
BEGIN
	DECLARE chars_str varchar(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	DECLARE return_str varchar(255) DEFAULT '';
	DECLARE i int DEFAULT 0;
	WHILE i < n DO
		set return_str = CONCAT(return_str,SUBSTRING(chars_str,FLOOR(1+rand()*52),1));
		set i=i+1;
	END WHILE;
	RETURN return_str;
END $$


SELECT rand_string(5);

delimiter $$
CREATE FUNCTION rand_num() RETURNS int(5)
BEGIN
	DECLARE i int DEFAULT 0;
	set i = FLOOR(100+RAND()*10);
	RETURN i;
END $$

delimiter $$
CREATE PROCEDURE insert_emp(in start int(10),in max_num int(10))
BEGIN
	DECLARE i int DEFAULT 0;
	set autocommit = 0;
	REPEAT
		set i=i+1;
		insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) VALUES ((start+i),
		rand_string(6),'SALESMAN',0001,CURDATE(),2000,400,rand_num());
		UNTIL i=max_num
	end REPEAT;
	COMMIT;
END $$

delimiter $$
CREATE PROCEDURE insert_dept(in start int(10),in max_num int(10))
BEGIN
	DECLARE i int DEFAULT 0;
	set autocommit = 0;
	REPEAT
		set i=i+1;
		insert into dept(deptno,dname,loc) VALUES ((start+i),
		rand_string(6),rand_string(8));
		UNTIL i=max_num
	end REPEAT;
	COMMIT;
END $$

delimiter ;
call insert_dept(100,10);

















