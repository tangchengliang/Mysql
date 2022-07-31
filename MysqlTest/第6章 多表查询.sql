#����ѯ
# 1.��Ϥ�����ļ�����
	desc departments ;
	desc employees ;
	desc locations ;

	#��������ѯ'King'�Ĺ����ص�
	select *
	from employees 
	where last_name ='King';  #���ҵ����ź�
	select *
	from departments 
	where department_id =90;  #�ҵ�location_id
	select *
	from locations  
	where location_id =1700;  #��ȡ����λ��

# 2.���ֵѿ������Ĵ���
	#����ԭ��ȱ�ٶ�����ӵ�����
	#����ķ�ʽ��ÿ��Ա������ÿ������ƥ����һ��
	select employee_id ,department_name
	from employees ,departments ;  #��ѯ�� 107*27=2889 ����¼
	
	#��ȷ���ӷ�ʽ
	select employee_id ,department_name
	from employees ,departments 
	where employees.department_id =departments.department_id ; #���������������ű�Ź���
# 3.�����ѯ����г����˶�������ڵ��ֶΣ������ָ�����ֶ����ڵı�
	#�磺department_id ������������
	select employee_id ,department_name,employees.department_id 
	from employees,departments
	where employees.department_id =departments.department_id ;
	
	# ����ÿ���ֶ�ǰ��ָ�������ڵı�
	select employees.employee_id ,departments.department_name,employees.department_id 
	from employees,departments
	where employees.department_id =departments.department_id ;
	
# 4.����ȡ��������select��where��ʹ�ñ�������ǿ�ɶ���
	#���ȡ�˱��������ڳ��ֵĵط�������ʹ�ñ���������ʹ��ԭ��
	select emp.employee_id ,dep.department_name,emp.department_id 
	from employees emp,departments dep
	where emp.department_id =dep.department_id ;

# 5.�����n������������Ҫn-1����������
	#��ϰ����ѯԱ����employee_id,last_name,department_name,city
	select e.employee_id ,e.last_name ,d.department_name ,l.city 
	from employees e ,departments d ,locations l 
	where e.department_id =d.department_id and d.location_id =l.location_id 
	
# 6.����ѯ�ķ���
	#�Ƕ�1����ֵ���� VS �ǵ�ֵ����
	#�Ƕ�2��������   VS ��������
	#�Ƕ�3��������   VS ������
	
	#6.1�ǵ�ֵ���Ӱ���
	select *
	from job_grades ;
	#��������ѯԱ�����������ʣ����Թ��ʷֵȼ�
	select e.last_name ,e.salary ,jg.grade_level 
	from employees e ,job_grades jg 
	where e.salary between jg.lowest_sal and jg.highest_sal ;

	#6.2������ VS ��������
	#��ϰ����ѯԱ��ID��������������ߵ�id������
	select e.employee_id ,e.last_name ,mgr.employee_id ,mgr .last_name 
	from employees e ,employees mgr
	where e.manager_id = mgr.employee_id ; #��e��ӦԱ������mgr��Ӧ������
	
	#6.3������   VS ������
		#�����ӣ��ϲ���ֻ����������ƥ����������
		#�����ӣ��ϲ�����������ƥ�����֮�⣬����ѯ������� �� �ұ��в�ƥ�����
			#�����ࣺ�������ӣ��������ӣ���������
	#��������ѯ �����С� Ա����last_name,department_name��Ϣ
#SQL92�﷨ʵ�������ӣ�ʹ�� + --------->MySQL��֧��92�﷨
	select e.last_name ,d.department_id 
	from employees e ,departments d 
	where e.department_id =d.department_id(+) ;
#SQL99�﷨��ʹ��JOIN...ON
	#(1)SQL99ʵ��������(ʡ����INNER)
	select e.last_name ,d.department_name 
	from employees e inner join departments d 
	on e.department_id = d.department_id ;  #2�ű�

	select e.last_name ,d.department_name ,l.city 
	from employees e join departments d 
	on e.department_id = d.department_id 
	join locations l 
	on d.location_id =l.location_id ;		#3�ű�
	
	#(2)SQL99ʵ��������(����LEFT������ʡ��OUTER)
	select e.last_name ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id ;  #2�ű�,��������
	
	select e.last_name ,d.department_name 
	from employees e right outer join departments d 
	on e.department_id = d.department_id ;  #2�ű�,��������
	
	select e.last_name ,d.department_name 
	from employees e outer join departments d 
	on e.department_id = d.department_id ;  #2�ű�,��������
	
# 7.7��joinʵ��
	#1.��ͼ��������
	select e.employee_id ,d.department_name 
	from employees e join departments d 
	on e.department_id = d.department_id ;
	#2.���ϣ���������
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id ;
	#3.���ϣ���������
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id ;
	#4.���У�
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id 
	where d.department_id is null;
	#5.���У�
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id 
	where e.department_id is null;
	#6.���£���������
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id 
	union all 
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id 
	where e.department_id is null;
	#7.����
	select e.employee_id ,d.department_name 
	from employees e left join departments d 
	on e.department_id = d.department_id 
	where d.department_id is null
	union all
	select e.employee_id ,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id 
	where e.department_id is null;