# 9.�Ӳ�ѯ
#1.����
	#Ƕ��
	#��ϰ����ѯ��'Abel'���ʸߵ���
		#��ʽ1�����ҵ�'Abel'�Ĺ��ʣ����Ҵ��������ʵ���
		#��ʽ2�������ӣ����ű���ʵ��
		#��ʽ3���Ӳ�ѯ
		select e.last_name ,e.salary 
		from employees e 
		where e.salary > (
						  select e2.salary 
						  from employees e2
						  where e2.last_name = 'Abel');
#2.��ν�淶�����ѯ������ѯ�����ڲ�ѯ���Ӳ�ѯ��
	/*
	  �����Ӳ�ѯ���ڲ�ѯ��������ѯ֮ǰһ��ִ����ɡ�
	  �����Ӳ�ѯ�Ľ��������ѯ�����ѯ��ʹ�� ��
	  ע������
		�Ӳ�ѯҪ������������
		���Ӳ�ѯ���ڱȽ��������Ҳ�
		���в�������Ӧ�����Ӳ�ѯ�����в�������Ӧ�����Ӳ�ѯ
	*/ 

#3.�Ӳ�ѯ�ķ���
	#�Ƕ�1�����ڲ�ѯ���صĽ����Ŀ��----->�����Ӳ�ѯ VS �����Ӳ�ѯ
	#�Ƕ�2���ڲ�ѯ�Ƿ�ִ�ж��--------->����Ӳ�ѯ VS ������Ӳ�ѯ
		#��ϰ����ѯ���ʴ��ڱ�����ƽ�����ʵ�Ա����Ϣ(����Ӳ�ѯ)
			#  ��ѯ���ʴ��ڱ���˾ƽ�����ʵ�Ա����Ϣ(������Ӳ�ѯ)
	
	#3.1�����Ӳ�ѯ(>, >=, <, <=, =, !=)
		#��ϰ����ѯ���ʴ���149��Ա�����ʵ�Ա����Ϣ
			select e.last_name ,e.salary 
			from employees e 
			where e.salary > (
							  select e2.salary 
							  from employees e2 
							  where e2.employee_id = 149
							  );
		#��ϰ������job_id��141��Ա����ͬ��salary��143��Ա�����Ա��������job_id�͹���
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
  		#��ϰ�����ع�˾�������ٵ�Ա����last_name,job_id��salary
			select e.last_name ,e.job_id ,e.salary 
			from employees e 
			where salary = (
							select min(e2.salary)
							from employees e2);
		#��ϰ����ѯ��141�Ż�174Ա����manager_id��department_id��ͬ������Ա����employee_id��
				#manager_id��department_id
			#��ʽ1��
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
			#��ʽ�����ɶԲ�ѯ
			select e.employee_id ,e.manager_id ,e.department_id 
			from employees e 
			where (e.manager_id,e.department_id ) in (
								  					select e2.manager_id ,e2.department_id 
								  					from employees e2
								  					where e2.employee_id in(141,174) );
		#3.2HAVING�е��Ӳ�ѯ
			#��ϰ����ѯ��͹��ʴ���50�Ų�����͹��ʵĲ���id������͹���
			select e.department_id ,min(e.salary)
			from employees e 
			where e.department_id is not null
			group by e.department_id 
			having min(e.salary) > (
									select min(e2.salary)
									from employees e2
									where e2.department_id=50);
		#3.3CASE�е��Ӳ�ѯ
			#��ϰ����ʽԱ����employee_id,last_name��location��
			#���У���Ա��department_id��location_idΪ1800��department_id��ͬ����locationΪ��Canada����
			#������Ϊ��USA����
			select e.employee_id ,e.last_name ,
			case e.department_id when (
										select d.department_id 
										from departments d 
										where d.location_id =1800
										) then 'Canada' 
										else 'USA' end 'location'
			from employees e ;
		#3.4�Ӳ�ѯ�п�ֵ����
			SELECT last_name, job_id
			FROM employees
			WHERE job_id =
							(SELECT job_id
							FROM employees
							WHERE last_name = 'Haas');
		#3.5�Ƿ��Ӳ�ѯ�����в�ѯ()��ֻ�ܷ���һ�н���������ж�
#4.�����Ӳ�ѯ   
	# IN �б�������һ��
	# ANY �͵��бȽϲ�����һ��ʹ�ã����Ӳ�ѯ��ĳһ��ֵ�Ƚ�
	# ALL �͵��бȽϲ�����һ��ʹ�ã����Ӳ�ѯ������ֵ�Ƚ�
	# SOME ��ANYһ��
  #4.1 ANY/ ALL
	#��ϰ����������job_id�б�job_idΪ��IT_PROG������ ����һ�� ���ʵ͵�Ա����Ա���š�������job_id �Լ�salary
		select e.employee_id ,e.last_name ,e.job_id ,e.salary 
		from employees e 
		where e.job_id <> 'IT_PROG'
		and e.salary < any(
						select e2.salary 
						from employees e2
						where e2.job_id = 'IT_PROG');
	#��ϰ����������job_id�б�job_idΪ��IT_PROG������ �����С� ���ʵ͵�Ա����Ա���š�������job_id �Լ�salary
		select e.employee_id ,e.last_name ,e.job_id ,e.salary 
		from employees e 
		where e.job_id <> 'IT_PROG'
		and e.salary < all(
						select e2.salary 
						from employees e2
						where e2.job_id = 'IT_PROG');
	#��ϰ����ѯƽ��������͵Ĳ���id(ע�⣺MySQL�оۺϺ�������Ƕ��)
		#˼ά����������Ƕ�ף�����ֵ��Ϊһ�����ٵ��������
		#��ʽ1��
		select e2.department_id 
		from employees e2 
		group by e2.department_id 
		having avg(e2.salary)=(
								select min(avg_sal)
								from(
									select avg(e.salary) avg_sal
									from employees e 
									group by e.department_id ) t_dept_avg_sal);
		#��ʽ2��ANY/ALL
		select e2.department_id 
		from employees e2 
		group by e2.department_id 
		having avg(e2.salary) <= all (
								select avg(e.salary) avg_sal
								from employees e 
								group by e.department_id ) ;
	#4.2��ֵ����
		#һ��Ҫע�⴦��nullֵ������not in ��in����ʵ��
		SELECT last_name
		FROM employees
		WHERE employee_id NOT IN (
							SELECT manager_id
							FROM employees
							#where manager_id is not null  #����null���
		);

#5.����Ӳ�ѯ��ÿִ��һ���ⲿ��ѯ���Ӳ�ѯ��Ҫ���¼���һ�Σ��������Ӳ�ѯ�ͳ�֮Ϊ �����Ӳ�ѯ ��
	#��ϰ����ѯԱ���й��ʴ��ڱ�����ƽ�����ʵ�Ա����last_name,salary����department_id
	#��ʽ1����ز�ѯ����
		select e.last_name ,e.salary ,e.department_id 
		from employees e 
		where salary > (
						select avg( e2.salary) 
						from employees e2 
						where e2.department_id = e.department_id 
						);
	#��ʽ2����from���Ӳ�ѯ,��ѯ�ı����ڣ�����д��������from��
		select e.last_name ,e.salary ,e.department_id 
		from employees e ,(
						select e2.department_id,avg( e2.salary) avg_sal
						from employees e2 
						group by e2.department_id 
						) t_dept_avg_sal
		where e.department_id = t_dept_avg_sal.department_id
		and e.salary > t_dept_avg_sal.avg_sal;
	#��ORDER BY��ʹ���Ӳ�ѯ����ѯԱ����id,salary,����department_name ����
		select e.employee_id ,e.salary 
		from employees e 
		order by (
				  select d.department_name 
				  from departments d
				  where d.department_id = e.department_id) asc;
	#���ۣ��ڲ�ѯ�г���GROUP BY ��LIMIT ֮�ⲻ��ʹ���Ӳ�ѯ�����඼����ʹ��
		#��ϰ����employees����employee_id��job_history����employee_id��ͬ����Ŀ��С��2��
				#�����Щ��ͬid��Ա����employee_id,last_name����job_id
			select e.employee_id ,e.last_name ,e.job_id 
			from employees e 
			where 2 <= (
						select count(*)
						from job_history jh 
						where e.employee_id =jh.employee_id ); 
	#EXISTS �� NOT EXISTS
		#��ϰ����ѯ��˾�����ߵ�employee_id��last_name��job_id��department_id��Ϣ
		#��ʽ1��������
			select distinct mgr.employee_id ,mgr.last_name ,mgr.department_id 
			from employees e join employees mgr 
			on e.manager_id = mgr.employee_id ;
		#��ʽ2���Ӳ�ѯ
			select e2.employee_id ,e2.last_name ,e2.job_id ,e2.department_id 
			from employees e2 
			where e2.employee_id in (
									select distinct e.manager_id 
									from employees e );
		#��ʽ3��EXISTS
			select e.employee_id ,e.last_name ,e.job_id ,e.department_id 
			from employees e
			where exists (
						  select * #���*����Ҫ���鵽��¼����
						  from employees e2
						  where e.employee_id = e2.manager_id);
	#��ϰ����ѯdepartments���У���������employees���еĲ��ŵ�department_id��department_name
		#��ʽ1��������
			select d.department_id ,d.department_name 
			from employees e right join departments d 
			on e.department_id = d.department_id
			where e.department_id is null;
		#��ʽ2��
			select d.department_id ,d.department_name 
			from  departments d
			where not exists (
							select *
							from employees e
							where e.department_id  = d.department_id);
	#��ϰ��
#1.��ѯ��Zlotkey��ͬ���ŵ�Ա�������͹���
	select e.last_name ,e.salary 
	from employees e 
	where e.department_id = (
							 select e2.department_id 
							 from employees e2
							 where e2.last_name = 'Zlotkey')
	and e.last_name <> 'Zlotkey';
#2.��ѯ���ʱȹ�˾ƽ�����ʸߵ�Ա����Ա���ţ������͹��ʡ�
	select e.employee_id ,e.last_name ,e.salary 
	from employees e 
	where e.salary > (
					  select avg(e2.salary) 
					  from employees e2);
#3.ѡ���ʴ�������JOB_ID = 'SA_MAN'��Ա���Ĺ��ʵ�Ա����last_name, job_id, salary
	select e.last_name ,e.job_id ,e.salary 
	from employees e 
	where e.salary > all (
							select e2.salary 
							from employees e2
							where e2.job_id = 'SA_MAN');
#4.��ѯ�������а�����ĸu��Ա������ͬ���ŵ�Ա����Ա���ź�����*****************
	select e2.employee_id ,e2.last_name 
	from employees e2 
	where e2.department_id = any (
									select distinct e.department_id 
									from employees e 
									where e.last_name like '%u%');
	
#5.��ѯ�ڲ��ŵ�location_idΪ1700�Ĳ��Ź�����Ա����Ա����
	select e.employee_id 
	from employees e 
	where e.department_id in(
								select d.department_id 
								from departments d 
								where d.location_id =1700);
#6.��ѯ��������King��Ա�������͹���
	select e.last_name ,e.salary 
	from employees e 
	where e.manager_id in (
						 select e2.employee_id 
						 from employees e2
						 where e2.last_name = 'King');
#7.��ѯ������͵�Ա����Ϣ: last_name, salary
	select e.last_name ,e.salary 
	from employees e 
	where e.salary = (
					  select min(e2.salary) 
					  from employees e2);
#8.��ѯƽ��������͵Ĳ�����Ϣ
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
							
#9.��ѯƽ��������͵Ĳ�����Ϣ�͸ò��ŵ�ƽ�����ʣ�����Ӳ�ѯ��
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
#10.��ѯƽ��������ߵ� job ��Ϣ
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

#11.��ѯƽ�����ʸ��ڹ�˾ƽ�����ʵĲ�������Щ?
							select e.department_id ,e.salary 
							from employees e 
							where e.department_id is not null
							group by e.department_id
							having avg(e.salary) > (
													select avg(e2.salary) 
													from employees e2); 
#12.��ѯ����˾������ manager ����ϸ��Ϣ
	select *
	from employees e 
	where e.employee_id in (
						  select distinct e2.manager_id 
						  from employees e2); 
#13.���������� ��߹�������͵��Ǹ����ŵ� ��͹����Ƕ���?
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
														

#14.��ѯƽ��������ߵĲ��ŵ� manager ����ϸ��Ϣ: last_name, department_id, email, salary
#15. ��ѯ���ŵĲ��źţ����в�����job_id��"ST_CLERK"�Ĳ��ź�
#16. ѡ������û�й����ߵ�Ա����last_name
#17����ѯԱ���š�����������ʱ�䡢���ʣ�����Ա���Ĺ�����Ϊ 'De Haan'
#18.��ѯ�������й��ʱȱ�����ƽ�����ʸߵ�Ա����Ա����, �����͹��ʣ�����Ӳ�ѯ��
#19.��ѯÿ�������µĲ����������� 5 �Ĳ������ƣ�����Ӳ�ѯ��
#20.��ѯÿ�������µĲ��Ÿ������� 2 �Ĺ��ұ�ţ�����Ӳ�ѯ
	