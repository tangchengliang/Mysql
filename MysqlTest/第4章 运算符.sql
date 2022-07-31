#�����
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
where commission_pct =null;  #���Ϊ��

#��2��<=> ��ȫ���ڣ�Ϊnull����
select last_name ,commission_pct 
from employees 
where commission_pct <=> null;  #�����ֵ

#LEAST() \ GREATEST
select least('a','b','d') ,greatest('b','a','f','a')
from dual;
#�ж��ַ�����
select least(first_name,last_name),least(length(first_name),length(last_name)) 
from employees ; 

#between �����½�1 and �����Ͻ�2
select employee_id ,salary 
from employees 
where salary between 6000  and 8000;

# in(set)  /not in (set)
select department_id ,salary 
from employees
#where department_id in (10,20,30);
where department_id not in (10,20,30);

#like:ģ����ѯ
	# %������0����һ���������ȷ�����ַ�
	# _����ʾһ����ȷ�����ַ�
	select first_name 
	from employees 
	#where first_name like '%a%';  #�����ַ�a
	#where first_name like 'a%';   #���ַ�a��ʼ
	#where first_name like '%a';   #���ַ�a��β
	#where first_name like '%a%' and first_name like '%e%';  #�����ַ�a��e
	#where first_name like '_a%';  #�ڶ�����ĸΪa
	where first_name like '_\_a%'; #�ڶ����ַ�����'_',����ת���ַ�\
	
#������ʽ��REGEXP \ RLIKE
	# ^ $ . [] *
	select 'shacke' regexp '^sh','shacke' regexp 'e$','shacke' regexp 'ha','shacke' regexp 'h.c','shacke' regexp '[he]'
	,'shcke' regexp 'a*'
	from dual;

# 1.ѡ���ʲ���5000��12000��Ա���������͹���
select first_name ,salary 
from employees 
where salary not between 5000 and 12000;
# 2.ѡ����20��50�Ų��Ź�����Ա�������Ͳ��ź�
select first_name ,department_id 
from employees 
where department_id in (20,50);
# 3.ѡ��˾��û�й����ߵ�Ա��������job_id
select first_name ,job_id ,manager_id 
from employees 
where manager_id <=> null ;
# 4.ѡ��˾���н����Ա�����������ʺͽ��𼶱�
select first_name ,salary  *(1+commission_pct)*12 ,commission_pct 
from employees 
where commission_pct is not null;
# 5.ѡ��Ա�������ĵ�������ĸ��a��Ա������
select first_name  
from employees 
where first_name like '__a%';
# 6.ѡ������������ĸa��k��Ա������
select first_name  
from employees 
where first_name like '%a%' and first_name like '%k%';
# 7.��ʾ���� employees ���� first_name �� 'e'��β��Ա����Ϣ
select first_name  
from employees 
where first_name regexp 'e$';
# 8.��ʾ���� employees ���ű���� 80-100 ֮�������������
select first_name,job_id ,department_id 
from employees 
where department_id between 80 and 100;
# 9.��ʾ���� employees �� manager_id �� 100,101,110 ��Ա�����������ʡ�������id
select first_name,salary ,manager_id 
from employees 
where manager_id in (100,101,110);
  
