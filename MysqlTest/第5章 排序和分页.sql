#第五章  排序和分页

#1.1基本排序使用
select * from employees ;
	#练习：对salary降序排序
	#order by :默认升序排列
	#升序：ASC   降序：DESC
	select employee_id ,last_name ,salary 
	from employees 
	order by salary desc;
	
	#1.2可以使用列的别名排序
	select employee_id ,salary * 12 annual_sal
	from employees 
	order by annual_sal desc;  #注意：列的别名只能在order by中使用，不能在where中使用
	
	#1.3 where在from之后，order之前
	
	#1.4相同值如何排序---->二级排序
	#练习：显示员工信息，按照id降序，salary升序
	select employee_id ,salary ,department_id 
	from employees 
	order by department_id desc ,salary asc;

# 2.分页：处理数据太多，分页查看
	# limit
	#2.1练习：每页显示前20条记录，此时显示第一页
	select employee_id ,last_name 
	from employees 
	limit 0,20;
	
	#练习：每页显示20条记录，此时显示第3页
	#第一个数，表示偏移量，第二个数表示几行
	#公式：LIMIT(pageNo-1)*pageSize,pageSize;
	select employee_id ,last_name 
	from employees 
	limit 40,20;
	
	#2.2  WHERE ... ORDER BY ...LIMIT
	select employee_id ,salary 
	from employees 
	where salary > 6000
	order by salary asc 
	limit 0,10;
	
	#练习：查询具体某一行数据，如31,32
	select * 
	from employees 
	limit 30,2;
	
	#2.3 MySQL8.0新特性：LIMIT...OFFSET...
	#这里:LIMIT后表示显示几条，OFFSET后表示偏移量
	select *
	from employees 
	limit 2 offset 30;
	
#练习：查看员工工资最高的员工信息
select employee_id ,salary 
from employees 
order by salary desc 
limit 1;

#1. 查询员工的姓名和部门号和年薪，按年薪降序,按姓名升序显示
select first_name ,department_id ,salary * 12 annual_sal
from employees 
order by  annual_sal desc ,first_name asc;
#2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序，显示第21到40位置的数据
select first_name ,salary 
from employees 
where salary not between 8000 and 17000
order by salary desc 
limit 20,20;
#3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
select * 
from employees 
where email like '%e%'
#where email regexp '[e]'
order by length(email) desc ,department_id asc;

