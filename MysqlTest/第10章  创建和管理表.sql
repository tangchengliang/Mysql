#��10��  �����͹����
	#DDL�����ݶ�������
#1.�������ݿ�
		create database mytest1;#��ʽ1:Ĭ���ַ���
		create database mytest2 character set 'gbk'; #��ʽ2���������ݿⲢָ���ַ���
	#��ʽ3���ж����ݿ��Ƿ��Ѿ����ڣ��������򴴽����ݿ�
		#���MySQL���Ѿ�������ص����ݿ⣬����Դ�����䣬���ٴ������ݿ⡣
		CREATE DATABASE IF NOT EXISTS mytest1; 
		
	#1.2���ݿ��ʹ��
		show databases; #�鿴��ǰ���е����ݿ�
		use mytest2;	#ʹ��/�л����ݿ�
		select database (); #�鿴��ǰ����ʹ�õ����ݿ�
		show tables from mysql; #�鿴ָ���������еı�
	
	#1.3���ݿ���޸�
		alter database mytest1 character set 'gbk'; #�������ݿ��ַ���
	#1.4ɾ�����ݿ�
		drop database mytest1; 	#ɾ��ָ�����ݿ�
		drop database if exists mytest2; #�Ƽ�
	
#2.������
	use atguigudb;
	show create database atguigudb;
	show tables;
	#��ʽ1��
		create table if not exists myemp1(
		id int,
		emp_name varchar(15), #varchar()�����ַ���������ָ������
		hire_date date
		);
	#�鿴��ṹ
		desc myemp1;
		show create table myemp1; 
	#��ʽ2���������еı����µı����ƣ�
		create table myemp2
		as
		select e.last_name ,e.salary 
		from employees e ;
		#��ѯ��ṹ
			desc myemp2;
			select * from myemp2;
		#���ۣ���ѯ���Ľṹ----->������
				#��ѯ���ı�����������Ϊ�±���ֶ�����
		#��ϰ�����Ʊ�ͷ������������
			create table mytest4
			as
			select *
			from employees 
			where false;
		select * from mytest4;

#3.�޸ı�
	desc myemp1 ;
	#3.1���һ���ֶ�
		alter table myemp1 
		add salary double(10,2); #Ĭ����ӵ�������һ���ֶ�
		
		alter table myemp1 
		add phone_number varchar(20) first; #������λ
		
		alter table myemp1 
		add email varchar(40) after emp_name; #����...֮��
	#3.2�޸�һ���ֶ�:�������͡����ȡ�Ĭ��ֵ...
		alter table myemp1 
		modify emp_name varchar(50);	#�޸ĳ���
		
		alter table myemp1 
		modify emp_name varchar(10) default 'aaa'; #���Ĭ��ֵ
	
		alter table myemp1 
		change salary month_salary double(10,2);
	#3.3ɾ��
		alter table myemp1 
		drop column email;
	#3.4������
		#��ʽ1��RENAME
			rename table myemp1 
			to myemp11;
		#��ʽ2��ALTER RENAME
			alter table myemp2 
			rename to myemp22;
#4.ɾ����
	drop table if exists myemp2 ;
	#��������

#5.��ձ�ֻɾ�������ݣ���ṹ������
	#���Ʊ�
		create table employees_copy
		as
		select *
		from employees ;
	select * from employees_copy;
	#��ձ�
		truncate table employees_copy;
		
		select * from employees_copy;
		desc employees_copy;
#6.DCL�� COMMIT �� ROLLBACK
	#COMMIT���ύ���ݣ�һ��ִ�У����ݾ����õı��������ݿ��У���ζ�����ݲ��ܻع�
	#ROLLBACK���ع����ݣ�����ʵ�����ݵĻع����ع������һ��COMMIT

#7.�Ա�   TRUNCATE TABLE �� DELETE from 
	#��ͬ�㣺������ʵ�ֶԱ������ݵ�ɾ����ͬʱ������ṹ
	#��ͬ��
		/*
		 	TRUNCATE TABLE:������ȫ����������ݲ��ɻع�
		 	DELETE FROM�������ݿ���ȫ�����������WHERE����ͬʱ�������ǿ���ʵ�ֻع�
		 */
#8.DDL  �� DML��˵��
	# DDL��һ��ִ�У����ɻع�.��һ����ִ��һ��COMMIT����DDL���� SET autocommit = FALSE��Ӱ�죩
	# DML������Ĭ�ϲ��ع�����ִ��DML֮ǰ��ִ���� SET autocommit = FALSE������Իع�
	#��ϰ��ǰ��׼��
			create table myemp2
			as
			select e.employee_id ,e.last_name ,e.salary 
			from employees e ;
			#��ѯ��ṹ
				desc myemp2;
				select * from myemp2;
		#8.1DELETE from 
			commit;		#�ύ
			select * from myemp2;
			set autocommit = false;
			delete from myemp2 ;
			rollback;   #�ع�����һ��COMMIT֮��
		#8.2TRUNCATE TABLE:
			commit;
			truncate table myemp2 ;
			rollback;
#�κ���ϰ
#1. �������ݿ�test01_office,ָ���ַ���Ϊutf8�����ڴ����ݿ���ִ����������
	create database test01_office character set 'utf8';
#2. ������dept01
/*
�ֶ� ����
id INT(7)
NAME VARCHAR(25)
*/
	use test01_office;
	create table if not exists dep01(id int(7),name varchar(25));
	desc dep01;
#3. ����departments�е����ݲ����±�dept02��
	CREATE TABLE dept02
	AS
	SELECT *
	FROM atguigudb.departments;
	
#4. ������emp01
/*
�ֶ� ����
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
#5. ����last_name�ĳ������ӵ�50
	alter table emp01
	modify last_name varchar(50);
#6. ���ݱ�employees����emp02
	create table emp02
	as
	select *
	from atguigudb.employees ;
desc emp02;
select *
from emp02;
#7. ɾ����emp01
drop table emp01;
show tables from test01_office;
#8. ����emp02������Ϊemp01
	rename table emp02 to emp01;
#9.�ڱ�dept02��emp01���������test_column������������Ĳ���
	alter table emp01
	add test_column int;
	desc emp01;
#10.ֱ��ɾ����emp01�е��� department_id
	alter table emp01
	drop column department_id;