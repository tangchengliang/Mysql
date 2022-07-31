# 第8章 聚合函数

#1.常见的聚合函数
	#1.1 AVG 、SUM：只针对数值型操作，字符串求和没有意义，不会报错
		select avg(e.salary),sum(e.salary) ,avg(e.last_name) 
		from employees e ; 
					
	#1.2 MAX 、MIN：任意数据类型,可用于字符串、日期、时间
		select max(e.salary),min(e.salary) ,max(e.last_name) 
		from employees e ;
		
	#1.3 COUNT：任意数值类型,作用：计算指定字段在查询结构中出现的个数
	#方式1：COUNT(*)
	#方式1：COUNT(1)
	#方式1：COUNT(具体字段)：不推荐，可能有null
	#count(*)会统计值为 NULL 的行，而 count(列名)不会统计此列为 NULL 值的行。
	#和存储引擎有关系：MySAM、InnoDB
		select count(e.employee_id) ,count(1) ,count(*) 
		from employees e 
		where department_id in(10,20,30);
		#注意：不计算null
		select count(e.commission_pct) 
		from employees e 
	    where e.commission_pct is not null;
   #注意：
	   #上面都不会记录null的行
	   #公式 :AVG=SUM/COUNT 
	  	 #练习：计算公式中平均奖金率
	   	select avg(e.commission_pct) #错误，因为没有计算null的行
	   	,sum(e.commission_pct) / count(ifnull(e.commission_pct,0)) #正确，考虑了所有人
	   	,avg(ifnull(e.commission_pct,0)) 
	  	from employees e ;
#2.GROUP BY的使用
  #2.1单列分组
	#需求：查询各个部门的平均工资
	  select e.department_id ,avg(e.salary) ,sum(e.salary) 
	  from employees e 
	  group by e.department_id ;
	#需求：查询各个job的平均工资
	  select e.job_id ,avg(e.salary) 
	  from employees e 
	  group by e.job_id ;
  #2.2多列分组
	 #查询各个部门的平均工资、job的平均工资
	 SELECT department_id dept_id, job_id, SUM(salary)
	 FROM employees
  	 GROUP BY department_id, job_id ; 
  	 
  	#结论1：select中出现的非组函数的字段一定要在group by之后出现，反之不一定
  	#结论2：Group by在from后，where后，order by前面，limit前面
  	#结论3：with rollup:该记录计算查询出的所有记录的总和，即统计记录数量。---->注意：不参与排序
  	  select e.job_id ,avg(e.salary) 
	  from employees e 
	  group by e.job_id with rollup ;
	 
#3. HAVING 的使用：过滤数据（where）
	 #3.1练习：查询各个部门中最高工资比1w高的部门信息
	 #传统作法where：报错
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 where max(e.salary)>=10000 
		 group by e.department_id ;
	#要求1：如果过滤条件使用了聚合函数，则必须使用HAVING来替换WHERE。否则报错
	#要求2：HAVING必须声明在GROUP BY 之后
		#正确作法having：
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 group by e.department_id 
		 having max(e.salary)>=10000; 
	#要求3：HAVING使用前提：有GROUP BY
		
	 #3.2练习：查询部门id各=10,20,30,40中最高工资比1w高的部门信息
		#方式1：
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 where e.department_id in (10,20,30,40)
		 group by e.department_id 
		 having max(e.salary)>=10000; 
	 	#方式2：
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 group by e.department_id 
		 having max(e.salary)>=10000 and e.department_id in(10,20,30,40); 
	 #结论：当过滤条件有聚合函数时，则此过滤条件必须声明在where中
	 #		建议使用方式1：先分组，可以减少开销，执行效率高
/*
	WHERE和HAVING的对比
		1.HAVING适用范围更广
		2.过滤条件没有聚合函数时，WHERE效率高于HAVING ：WHERE先筛选后连接	
*/
		
#4.SQL底层原理
	#即执行顺序
		
#课后习题
#1.where子句可否使用组函数进行过滤?
	#no
#2.查询公司员工工资的最大值，最小值，平均值，总和
	select max(e.salary),min(e.salary),avg(e.salary),sum(e.salary) 
	from employees e ;
#3.查询各job_id的员工工资的最大值，最小值，平均值，总和
	select e.job_id ,max(e.salary),min(e.salary),avg(e.salary),sum(e.salary) 
	from employees e
	group by e.job_id ; 
#4.选择具有各个job_id的员工人数
	select e.job_id ,count(*),count(e.job_id) 
	from employees e 
	group by e.job_id ;
# 5.查询员工最高工资和最低工资的差距（DIFFERENCE）
	select max(e.salary),min(e.salary),  max(e.salary)-min(e.salary) "DIFFERENCE"
	from employees e ;
# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
	select e.manager_id ,min(e.salary) 
	from employees e 
	where e.department_id is not null
	group by e.manager_id 
	having min(e.salary)>=6000 ;
	
# 7.查询所有部门的名字，location_id，员工数量和平均工资，并按平均工资降序
	select d.department_name ,d.location_id ,count(e.employee_id),avg(e.salary) avg_sal
	from departments d left join employees e 
	on e.department_id =d.department_id 
	group by d.department_id ,d.location_id 
	order by avg_sal desc;

SELECT department_name, location_id, COUNT(employee_id), AVG(salary) avg_sal
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
GROUP BY department_name, location_id
ORDER BY avg_sal DESC;
# 8.查询每个部门的部门名、工种名和最低工资
	select d.department_name ,e.job_id ,min(e.salary) 
	from employees e right join departments d 
	on e.department_id =d.department_id
	group by d.department_name ,e.job_id ;

	SELECT department_name,job_id,MIN(salary)
	FROM departments d LEFT JOIN employees e
	ON e.`department_id` = d.`department_id`
	GROUP BY department_name,job_id
	