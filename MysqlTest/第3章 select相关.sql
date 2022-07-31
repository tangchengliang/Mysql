use atguigudb;
select employee_id ,phone_number from employees ;

#6.列的别名
# as:全称  alias（别名） ，可以省略
#列的别名可以使用一对""引起来:如处理空格
select employee_id emp_id,last_name as lname,department_id "部门ID",salary *12 "annual sal" 
from employees ;

#7.去除重复行
#查询员工表中一共有哪些部门id呢？
select department_id from employees ; #没有去重
select distinct department_id from employees ; #去重 

#8.空值运算
#(1)空值：null  不等于0，'','null'
#(2)空值参与运算：结果一定也为null
select employee_id,salary "月工资",salary * (1+commission_pct) * 12 "年工资",commission_pct 
from employees;

select employee_id,salary "月工资",salary * (1+ifnull(commission_pct,0)) * 12 "年工资",commission_pct 
from employees; #引入ifnull，如果为null，则视为0

#9.着重号 ``, 字段名、表名和保留字、系统常用方法冲突
# select * from order; 错误
select * from `order` ;

#10.查询常数
select '尚硅谷',123,employee_id,last_name
from employees;

#11.显示表结构
describe employees; #显示表中字段的详细信息
desc job_grades ;

#12.过滤数据
#查询90号部门的员工信息
select *
from employees 
#过滤条件
where department_id =90; 

#练习：查询last_name='king'的信息
select *
from employees 
#过滤条件
where last_name='king';  

#查询范围数据
select *
from employees 
limit 10;

#课后练习
# 1.查询员工12个月的工资总和，并起别名为ANNUAL SALARY
select employee_id ,last_name ,salary*(1+ifnull(commission_pct,0))*12 "ANNUAL SALARY"
from employees ;
# 2.查询employees表中去除重复的job_id以后的数据
select distinct job_id 
from employees ;
# 3.查询工资大于12000的员工姓名和工资
select employee_id ,last_name ,salary 
from employees 
where salary >12000;
# 4.查询员工号为176的员工的姓名和部门号
select employee_id ,last_name ,department_id 
from employees
where employee_id =176;
# 5.显示表 departments 的结构，并查询其中的全部数据
desc departments ;
select * from departments ;