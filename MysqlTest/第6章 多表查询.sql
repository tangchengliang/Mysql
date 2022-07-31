#多表查询
# 1.熟悉常见的几个表
	desc departments ;
	desc employees ;
	desc locations ;

	#案例：查询'King'的工作地点
	select *
	from employees 
	where last_name ='King';  #先找到部门号
	select *
	from departments 
	where department_id =90;  #找到location_id
	select *
	from locations  
	where location_id =1700;  #获取具体位置

# 2.出现笛卡尔积的错误
	#错误原因：缺少多表连接的条件
	#错误的方式：每个员工都与每个部门匹配了一遍
	select employee_id ,department_name
	from employees ,departments ;  #查询出 107*27=2889 条记录
	
	#正确连接方式
	select employee_id ,department_name
	from employees ,departments 
	where employees.department_id =departments.department_id ; #这两个表依靠部门编号关联
# 3.如果查询语句中出现了多个表都存在的字段，则必须指明此字段所在的表
	#如：department_id 存在两个表中
	select employee_id ,department_name,employees.department_id 
	from employees,departments
	where employees.department_id =departments.department_id ;
	
	# 建议每个字段前都指明其所在的表
	select employees.employee_id ,departments.department_name,employees.department_id 
	from employees,departments
	where employees.department_id =departments.department_id ;
	
# 4.给表取别名，在select和where中使用别名，增强可读性
	#如果取了别名，则在出现的地方，必须使用别名，不能使用原名
	select emp.employee_id ,dep.department_name,emp.department_id 
	from employees emp,departments dep
	where emp.department_id =dep.department_id ;

# 5.如果有n个表，则至少需要n-1个连接条件
	#练习：查询员工的employee_id,last_name,department_name,city
	select e.employee_id ,e.last_name ,d.department_name ,l.city 
	from employees e ,departments d ,locations l 
	where e.department_id =d.department_id and d.location_id =l.location_id 
	
# 6.多表查询的分类
	#角度1：等值连接 VS 非等值连接
	#角度2：自连接   VS 非自连接
	#角度3：内连接   VS 外连接
	
	#6.1非等值连接案例
	select *
	from job_grades ;
	#案例：查询员工姓名、工资，并对工资分等级
	select e.last_name ,e.salary ,jg.grade_level 
	from employees e ,job_grades jg 
	where e.salary between jg.lowest_sal and jg.highest_sal ;

	#6.2自连接 VS 非自连接
	#练习：查询员工ID姓名，及其管理者的id和姓名
	select e.employee_id ,e.last_name ,mgr.employee_id ,mgr .last_name 
	from employees e ,employees mgr
	where e.manager_id = mgr.employee_id ; #表e对应员工，表mgr对应管理者
	
	#6.3内连接   VS 外连接
		#内连接：合并，只满足两个表匹配条件的行
		#外连接：合并，除了两表匹配的行之外，还查询到了左表 或 右表中不匹配的行
			#：分类：左外连接，右外连接，满外连接
	#案例：查询 “所有” 员工的last_name,department_name信息
#SQL92语法实现外连接：使用 + --------->MySQL不支持92语法
	select e.last_name ,d.department_id 
	from employees e ,departments d 
	where e.department_id =d.department_id(+) ;
#SQL99语法：使用JOIN...ON
	#(1)SQL99实现内连接(省略了INNER)
	select e.last_name ,d.department_name 
	from employees e inner join departments d 
	on e.department_id = d.department_id ;  #2张表

	select e.last_name ,d.department_name ,l.city 
	from employees e join departments d 
	on e.department_id = d.department_id 
	join locations l 
	on d.location_id =l.location_id ;		#3张表
	
	#(2)SQL99实现外连接(加了LEFT，可以省略OUTER)
	select e.last_name ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id ;  #2张表,左外连接
	
	select e.last_name ,d.department_name 
	from employees e right outer join departments d 
	on e.department_id = d.department_id ;  #2张表,左外连接
	
	select e.last_name ,d.department_name 
	from employees e outer join departments d 
	on e.department_id = d.department_id ;  #2张表,左外连接
	
# 7.7种join实现
	#1.中图：内连接
	select e.employee_id ,d.department_name 
	from employees e join departments d 
	on e.department_id = d.department_id ;
	#2.左上：左外连接
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id ;
	#3.右上：右外连接
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id ;
	#4.左中：
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id 
	where d.department_id is null;
	#5.右中：
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id 
	where e.department_id is null;
	#6.左下：满外连接
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id 
	union all 
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id 
	where e.department_id is null;
	#7.右下
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id 
	where d.department_id is null
	union all
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id 
	where e.department_id is null;