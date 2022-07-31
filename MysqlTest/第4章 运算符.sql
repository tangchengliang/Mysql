#运算符
select 100,100+0.1,100+50
from dual;

select 100+'a'
from dual;

select 12%5,12 mod 5
from dual;

# (1) =
#null
select last_name ,commission_pct 
from employees 
where commission_pct =null;  #结果为空

#（2）<=> 安全等于，为null而生
select last_name ,commission_pct 
from employees 
where commission_pct <=> null;  #结果有值

#LEAST() \ GREATEST
select least('a','b','d') ,greatest('b','a','f','a')
from dual;
#判断字符长度
select least(first_name,last_name),least(length(first_name),length(last_name)) 
from employees ; 

#between 条件下界1 and 条件上界2
select employee_id ,salary 
from employees 
where salary between 6000  and 8000;

# in(set)  /not in (set)
select department_id ,salary 
from employees
#where department_id in (10,20,30);
where department_id not in (10,20,30);

#like:模糊查询
	# %：代表0个、一个、多个不确定的字符
	# _：表示一个不确定的字符
	select first_name 
	from employees 
	#where first_name like '%a%';  #包含字符a
	#where first_name like 'a%';   #以字符a开始
	#where first_name like '%a';   #以字符a结尾
	#where first_name like '%a%' and first_name like '%e%';  #包含字符a、e
	#where first_name like '_a%';  #第二个字母为a
	where first_name like '_\_a%'; #第二个字符就是'_',加入转义字符\
	
#正则表达式：REGEXP \ RLIKE
	# ^ $ . [] *
	select 'shacke' regexp '^sh','shacke' regexp 'e$','shacke' regexp 'ha','shacke' regexp 'h.c','shacke' regexp '[he]'
	,'shcke' regexp 'a*'
	from dual;

# 1.选择工资不在5000到12000的员工的姓名和工资
select first_name ,salary 
from employees 
where salary not between 5000 and 12000;
# 2.选择在20或50号部门工作的员工姓名和部门号
select first_name ,department_id 
from employees 
where department_id in (20,50);
# 3.选择公司中没有管理者的员工姓名及job_id
select first_name ,job_id ,manager_id 
from employees 
where manager_id <=> null ;
# 4.选择公司中有奖金的员工姓名，工资和奖金级别
select first_name ,salary  *(1+commission_pct)*12 ,commission_pct 
from employees 
where commission_pct is not null;
# 5.选择员工姓名的第三个字母是a的员工姓名
select first_name  
from employees 
where first_name like '__a%';
# 6.选择姓名中有字母a和k的员工姓名
select first_name  
from employees 
where first_name like '%a%' and first_name like '%k%';
# 7.显示出表 employees 表中 first_name 以 'e'结尾的员工信息
select first_name  
from employees 
where first_name regexp 'e$';
# 8.显示出表 employees 部门编号在 80-100 之间的姓名、工种
select first_name,job_id ,department_id 
from employees 
where department_id between 80 and 100;
# 9.显示出表 employees 的 manager_id 是 100,101,110 的员工姓名、工资、管理者id
select first_name,salary ,manager_id 
from employees 
where manager_id in (100,101,110);
  
