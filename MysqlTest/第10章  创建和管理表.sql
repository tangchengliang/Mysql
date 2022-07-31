#第10章  创建和管理表
	#DDL：数据定义语言
#1.创建数据库
		create database mytest1;#方式1:默认字符集
		create database mytest2 character set 'gbk'; #方式2：创建数据库并指定字符集
	#方式3：判断数据库是否已经存在，不存在则创建数据库
		#如果MySQL中已经存在相关的数据库，则忽略创建语句，不再创建数据库。
		CREATE DATABASE IF NOT EXISTS mytest1; 
		
	#1.2数据库的使用
		show databases; #查看当前所有的数据库
		use mytest2;	#使用/切换数据库
		select database (); #查看当前正在使用的数据库
		show tables from mysql; #查看指定库下所有的表
	
	#1.3数据库的修改
		alter database mytest1 character set 'gbk'; #更改数据库字符集
	#1.4删除数据库
		drop database mytest1; 	#删除指定数据库
		drop database if exists mytest2; #推荐
	
#2.创建表
	use atguigudb;
	show create database atguigudb;
	show tables;
	#方式1：
		create table if not exists myemp1(
		id int,
		emp_name varchar(15), #varchar()定义字符串，必须指明长度
		hire_date date
		);
	#查看表结构
		desc myemp1;
		show create table myemp1; 
	#方式2：基于现有的表创建新的表（复制）
		create table myemp2
		as
		select e.last_name ,e.salary 
		from employees e ;
		#查询表结构
			desc myemp2;
			select * from myemp2;
		#结论：查询语句的结构----->创建表
				#查询语句的别名，可以作为新表的字段名称
		#练习：复制表头，不复制数据
			create table mytest4
			as
			select *
			from employees 
			where false;
		select * from mytest4;

#3.修改表
	desc myemp1 ;
	#3.1添加一个字段
		alter table myemp1 
		add salary double(10,2); #默认添加到表的最后一个字段
		
		alter table myemp1 
		add phone_number varchar(20) first; #放在首位
		
		alter table myemp1 
		add email varchar(40) after emp_name; #放在...之后
	#3.2修改一个字段:数据类型、长度、默认值...
		alter table myemp1 
		modify emp_name varchar(50);	#修改长度
		
		alter table myemp1 
		modify emp_name varchar(10) default 'aaa'; #添加默认值
	
		alter table myemp1 
		change salary month_salary double(10,2);
	#3.3删除
		alter table myemp1 
		drop column email;
	#3.4重命名
		#方式1：RENAME
			rename table myemp1 
			to myemp11;
		#方式2：ALTER RENAME
			alter table myemp2 
			rename to myemp22;
#4.删除表
	drop table if exists myemp2 ;
	#撤销不了

#5.清空表：只删除表数据，表结构还存在
	#复制表
		create table employees_copy
		as
		select *
		from employees ;
	select * from employees_copy;
	#清空表
		truncate table employees_copy;
		
		select * from employees_copy;
		desc employees_copy;
#6.DCL中 COMMIT 和 ROLLBACK
	#COMMIT：提交数据，一旦执行，数据就永久的保存在数据库中，意味着数据不能回滚
	#ROLLBACK：回滚数据，可以实现数据的回滚。回滚到最近一次COMMIT

#7.对比   TRUNCATE TABLE 和 DELETE from 
	#相同点：都可以实现对表中数据的删除，同时保留表结构
	#不同点
		/*
		 	TRUNCATE TABLE:表数据全部清除，数据不可回滚
		 	DELETE FROM：表数据可以全部清除（不带WHERE）。同时，数据是可以实现回滚
		 */
#8.DDL  和 DML的说明
	# DDL：一旦执行，不可回滚.（一定会执行一次COMMIT，而DDL不受 SET autocommit = FALSE的影响）
	# DML：操作默认不回滚，但执行DML之前，执行了 SET autocommit = FALSE，则可以回滚
	#练习：前提准备
			create table myemp2
			as
			select e.employee_id ,e.last_name ,e.salary 
			from employees e ;
			#查询表结构
				desc myemp2;
				select * from myemp2;
		#8.1DELETE from 
			commit;		#提交
			select * from myemp2;
			set autocommit = false;
			delete from myemp2 ;
			rollback;   #回滚到上一次COMMIT之后
		#8.2TRUNCATE TABLE:
			commit;
			truncate table myemp2 ;
			rollback;
#课后练习
#1. 创建数据库test01_office,指明字符集为utf8。并在此数据库下执行下述操作
	create database test01_office character set 'utf8';
#2. 创建表dept01
/*
字段 类型
id INT(7)
NAME VARCHAR(25)
*/
	use test01_office;
	create table if not exists dep01(id int(7),name varchar(25));
	desc dep01;
#3. 将表departments中的数据插入新表dept02中
	CREATE TABLE dept02
	AS
	SELECT *
	FROM atguigudb.departments;
	
#4. 创建表emp01
/*
字段 类型
id INT(7)
first_name VARCHAR (25)
last_name VARCHAR(25)
dept_id INT(7)
*/
	CREATE TABLE emp01(
					id INT(7),
					first_name VARCHAR(25),
					last_name VARCHAR(25),
					dept_id INT(7)
					);
desc emp01;
#5. 将列last_name的长度增加到50
	alter table emp01
	modify last_name varchar(50);
#6. 根据表employees创建emp02
	create table emp02
	as
	select *
	from atguigudb.employees ;
desc emp02;
select *
from emp02;
#7. 删除表emp01
drop table emp01;
show tables from test01_office;
#8. 将表emp02重命名为emp01
	rename table emp02 to emp01;
#9.在表dept02和emp01中添加新列test_column，并检查所作的操作
	alter table emp01
	add test_column int;
	desc emp01;
#10.直接删除表emp01中的列 department_id
	alter table emp01
	drop column department_id;