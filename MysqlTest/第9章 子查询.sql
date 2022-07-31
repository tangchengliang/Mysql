# 9.子查询
#1.引入
	#嵌套
	#练习：查询比'Abel'工资高的人
		#方式1：先找到'Abel'的工资，再找大于他工资的人
		#方式2：自连接，两张表来实现
		#方式3：子查询
		select e.last_name ,e.salary 
		from employees e 
		where e.salary > (
						  select e2.salary 
						  from employees e2
						  where e2.last_name = 'Abel');
#2.称谓规范：外查询（主查询），内查询（子查询）
	/*
	  ——子查询（内查询）在主查询之前一次执行完成。
	  ——子查询的结果被主查询（外查询）使用 。
	  注意事项
		子查询要包含在括号内
		将子查询放在比较条件的右侧
		单行操作符对应单行子查询，多行操作符对应多行子查询
	*/ 

#3.子查询的分类
	#角度1：从内查询返回的结果条目数----->单行子查询 VS 多行子查询
	#角度2：内查询是否被执行多次--------->相关子查询 VS 不相关子查询
		#练习：查询工资大于本部门平均工资的员工信息(相关子查询)
			#  查询工资大于本公司平均工资的员工信息(不相关子查询)
	
	#3.1单行子查询(>, >=, <, <=, =, !=)
		#练习：查询工资大于149号员工工资的员工信息
			select e.last_name ,e.salary 
			from employees e 
			where e.salary > (
							  select e2.salary 
							  from employees e2 
							  where e2.employee_id = 149
							  );
		#练习：返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
			select e.last_name ,e.job_id ,e.salary 
			from employees e 
			where e.job_id = (
							  select e2.job_id 
							  from employees e2
							  where e2.employee_id =141
							  ) and 
				  e.salary > (
				  			  select e3.salary 
				  			  from employees e3
				  			  where e3.employee_id=143);
  		#练习：返回公司工资最少的员工的last_name,job_id和salary
			select e.last_name ,e.job_id ,e.salary 
			from employees e 
			where salary = (
							select min(e2.salary)
							from employees e2);
		#练习：查询与141号或174员工的manager_id和department_id相同的其他员工的employee_id，
				#manager_id，department_id
			#方式1：
			select e.employee_id ,e.manager_id ,e.department_id 
			from employees e 
			where e.manager_id in (
								  select e2.manager_id 
								  from employees e2
								  where e2.employee_id in(141,174) )
		    and e.department_id in (
		   						  select e3.department_id 
								  from employees e3
								  where e3.employee_id in(141,174) )
			and e.employee_id not in(141,174);
			#方式二：成对查询
			select e.employee_id ,e.manager_id ,e.department_id 
			from employees e 
			where (e.manager_id,e.department_id ) in (
								  					select e2.manager_id ,e2.department_id 
								  					from employees e2
								  					where e2.employee_id in(141,174) );
		#3.2HAVING中的子查询
			#练习：查询最低工资大于50号部门最低工资的部门id和其最低工资
			select e.department_id ,min(e.salary)
			from employees e 
			where e.department_id is not null
			group by e.department_id 
			having min(e.salary) > (
									select min(e2.salary)
									from employees e2
									where e2.department_id=50);
		#3.3CASE中的子查询
			#练习：显式员工的employee_id,last_name和location。
			#其中，若员工department_id与location_id为1800的department_id相同，则location为’Canada’，
			#其余则为’USA’。
			select e.employee_id ,e.last_name ,
			case e.department_id when (
										select d.department_id 
										from departments d 
										where d.location_id =1800
										) then 'Canada' 
										else 'USA' end 'location'
			from employees e ;
		#3.4子查询中空值问题
			SELECT last_name, job_id
			FROM employees
			WHERE job_id =
							(SELECT job_id
							FROM employees
							WHERE last_name = 'Haas');
		#3.5非法子查询：单行查询()中只能返回一行结果，来做判断
#4.多行子查询   
	# IN 列表中任意一个
	# ANY 和单行比较操作符一起使用，和子查询的某一个值比较
	# ALL 和单行比较操作符一起使用，和子查询的所有值比较
	# SOME 和ANY一样
  #4.1 ANY/ ALL
	#练习：返回其它job_id中比job_id为‘IT_PROG’部门 “任一” 工资低的员工的员工号、姓名、job_id 以及salary
		select e.employee_id ,e.last_name ,e.job_id ,e.salary 
		from employees e 
		where e.job_id <> 'IT_PROG'
		and e.salary < any(
						select e2.salary 
						from employees e2
						where e2.job_id = 'IT_PROG');
	#练习：返回其它job_id中比job_id为‘IT_PROG’部门 “所有” 工资低的员工的员工号、姓名、job_id 以及salary
		select e.employee_id ,e.last_name ,e.job_id ,e.salary 
		from employees e 
		where e.job_id <> 'IT_PROG'
		and e.salary < all(
						select e2.salary 
						from employees e2
						where e2.job_id = 'IT_PROG');
	#练习：查询平均工资最低的部门id(注意：MySQL中聚合函数不能嵌套)
		#思维提升：不能嵌套，则将其值变为一个表，再调用这个表
		#方式1：
		select e2.department_id 
		from employees e2 
		group by e2.department_id 
		having avg(e2.salary)=(
								select min(avg_sal)
								from(
									select avg(e.salary) avg_sal
									from employees e 
									group by e.department_id ) t_dept_avg_sal);
		#方式2：ANY/ALL
		select e2.department_id 
		from employees e2 
		group by e2.department_id 
		having avg(e2.salary) <= all (
								select avg(e.salary) avg_sal
								from employees e 
								group by e.department_id ) ;
	#4.2空值问题
		#一定要注意处理null值，这里not in 和in，做实验
		SELECT last_name
		FROM employees
		WHERE employee_id NOT IN (
							SELECT manager_id
							FROM employees
							#where manager_id is not null  #处理null语句
		);

#5.相关子查询：每执行一次外部查询，子查询都要重新计算一次，这样的子查询就称之为 关联子查询 。
	#练习：查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
	#方式1：相关查询方法
		select e.last_name ,e.salary ,e.department_id 
		from employees e 
		where salary > (
						select avg( e2.salary) 
						from employees e2 
						where e2.department_id = e.department_id 
						);
	#方式2：在from中子查询,查询的表不存在，可以写出来放在from中
		select e.last_name ,e.salary ,e.department_id 
		from employees e ,(
						select e2.department_id,avg( e2.salary) avg_sal
						from employees e2 
						group by e2.department_id 
						) t_dept_avg_sal
		where e.department_id = t_dept_avg_sal.department_id
		and e.salary > t_dept_avg_sal.avg_sal;
	#在ORDER BY中使用子查询：查询员工的id,salary,按照department_name 排序
		select e.employee_id ,e.salary 
		from employees e 
		order by (
				  select d.department_name 
				  from departments d
				  where d.department_id = e.department_id) asc;
	#结论：在查询中除了GROUP BY 和LIMIT 之外不能使用子查询，其余都可以使用
		#练习：若employees表中employee_id与job_history表中employee_id相同的数目不小于2，
				#输出这些相同id的员工的employee_id,last_name和其job_id
			select e.employee_id ,e.last_name ,e.job_id 
			from employees e 
			where 2 <= (
						select count(*)
						from job_history jh 
						where e.employee_id =jh.employee_id ); 
	#EXISTS 与 NOT EXISTS
		#练习：查询公司管理者的employee_id，last_name，job_id，department_id信息
		#方式1：自连接
			select distinct mgr.employee_id ,mgr.last_name ,mgr.department_id 
			from employees e join employees mgr 
			on e.manager_id = mgr.employee_id ;
		#方式2：子查询
			select e2.employee_id ,e2.last_name ,e2.job_id ,e2.department_id 
			from employees e2 
			where e2.employee_id in (
									select distinct e.manager_id 
									from employees e );
		#方式3：EXISTS
			select e.employee_id ,e.last_name ,e.job_id ,e.department_id 
			from employees e
			where exists (
						  select * #这个*不重要，查到记录就行
						  from employees e2
						  where e.employee_id = e2.manager_id);
	#练习：查询departments表中，不存在于employees表中的部门的department_id和department_name
		#方式1：外连接
			select d.department_id ,d.department_name 
			from employees e right join departments d 
			on e.department_id = d.department_id
			where e.department_id is null;
		#方式2：
			select d.department_id ,d.department_name 
			from  departments d
			where not exists (
							select *
							from employees e
							where e.department_id  = d.department_id);
	#练习：
#1.查询和Zlotkey相同部门的员工姓名和工资
	select e.last_name ,e.salary 
	from employees e 
	where e.department_id = (
							 select e2.department_id 
							 from employees e2
							 where e2.last_name = 'Zlotkey')
	and e.last_name <> 'Zlotkey';
#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
	select e.employee_id ,e.last_name ,e.salary 
	from employees e 
	where e.salary > (
					  select avg(e2.salary) 
					  from employees e2);
#3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary
	select e.last_name ,e.job_id ,e.salary 
	from employees e 
	where e.salary > all (
							select e2.salary 
							from employees e2
							where e2.job_id = 'SA_MAN');
#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名*****************
	select e2.employee_id ,e2.last_name 
	from employees e2 
	where e2.department_id = any (
									select distinct e.department_id 
									from employees e 
									where e.last_name like '%u%');
	
#5.查询在部门的location_id为1700的部门工作的员工的员工号
	select e.employee_id 
	from employees e 
	where e.department_id in(
								select d.department_id 
								from departments d 
								where d.location_id =1700);
#6.查询管理者是King的员工姓名和工资
	select e.last_name ,e.salary 
	from employees e 
	where e.manager_id in (
						 select e2.employee_id 
						 from employees e2
						 where e2.last_name = 'King');
#7.查询工资最低的员工信息: last_name, salary
	select e.last_name ,e.salary 
	from employees e 
	where e.salary = (
					  select min(e2.salary) 
					  from employees e2);
#8.查询平均工资最低的部门信息
	select *
	from departments d 
	where d.department_id = (
							select e.department_id 
							from employees e 
							group by e.department_id 
							having avg(e.salary) <= all (
														select avg(e2.salary) 
														from employees e2 
														group by e2.department_id ));
							
#9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询）
	select d.*,(select avg(e3.salary) from employees e3  where e3.department_id = d.department_id ) ave_sal
	from departments d 
	where d.department_id = (
							select e.department_id 
							from employees e 
							group by e.department_id 
							having avg(e.salary) <= all (
														select avg(e2.salary) 
														from employees e2 
														group by e2.department_id ));
#10.查询平均工资最高的 job 信息
	select  *
	from jobs j 
	where j.job_id =(
						select e.job_id 
						from employees e 
						group by e.job_id 
						having avg(e.salary) >= all (
														select avg(e.salary) 
														from employees e 
														group by e.job_id ));

#11.查询平均工资高于公司平均工资的部门有哪些?
							select e.department_id ,e.salary 
							from employees e 
							where e.department_id is not null
							group by e.department_id
							having avg(e.salary) > (
													select avg(e2.salary) 
													from employees e2); 
#12.查询出公司中所有 manager 的详细信息
	select *
	from employees e 
	where e.employee_id in (
						  select distinct e2.manager_id 
						  from employees e2); 
#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少?
	select min(e.salary) 
	from employees e 
	where e.department_id = (
							 select e2.department_id 
							 from employees e2
							 group by e2.department_id
							 having max(e2.salary) <= all (SELECT MAX(salary) max_sal
															FROM employees
															GROUP BY department_id
															));
														

#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary
#15. 查询部门的部门号，其中不包括job_id是"ST_CLERK"的部门号
#16. 选择所有没有管理者的员工的last_name
#17．查询员工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan'
#18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（相关子查询）
#19.查询每个部门下的部门人数大于 5 的部门名称（相关子查询）
#20.查询每个国家下的部门个数大于 2 的国家编号（相关子查询
	