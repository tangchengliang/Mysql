#������  ����ͷ�ҳ

#1.1��������ʹ��
select * from employees ;
	#��ϰ����salary��������
	#order by :Ĭ����������
	#����ASC   ����DESC
	select employee_id ,last_name ,salary 
	from employees 
	order by salary desc;
	
	#1.2����ʹ���еı�������
	select employee_id ,salary * 12 annual_sal
	from employees 
	order by annual_sal desc;  #ע�⣺�еı���ֻ����order by��ʹ�ã�������where��ʹ��
	
	#1.3 where��from֮��order֮ǰ
	
	#1.4��ֵͬ�������---->��������
	#��ϰ����ʾԱ����Ϣ������id����salary����
	select employee_id ,salary ,department_id 
	from employees 
	order by department_id desc ,salary asc;

# 2.��ҳ����������̫�࣬��ҳ�鿴
	# limit
	#2.1��ϰ��ÿҳ��ʾǰ20����¼����ʱ��ʾ��һҳ
	select employee_id ,last_name 
	from employees 
	limit 0,20;
	
	#��ϰ��ÿҳ��ʾ20����¼����ʱ��ʾ��3ҳ
	#��һ��������ʾƫ�������ڶ�������ʾ����
	#��ʽ��LIMIT(pageNo-1)*pageSize,pageSize;
	select employee_id ,last_name 
	from employees 
	limit 40,20;
	
	#2.2  WHERE ... ORDER BY ...LIMIT
	select employee_id ,salary 
	from employees 
	where salary > 6000
	order by salary asc 
	limit 0,10;
	
	#��ϰ����ѯ����ĳһ�����ݣ���31,32
	select * 
	from employees 
	limit 30,2;
	
	#2.3 MySQL8.0�����ԣ�LIMIT...OFFSET...
	#����:LIMIT���ʾ��ʾ������OFFSET���ʾƫ����
	select *
	from employees 
	limit 2 offset 30;
	
#��ϰ���鿴Ա��������ߵ�Ա����Ϣ
select employee_id ,salary 
from employees 
order by salary desc 
limit 1;

#1. ��ѯԱ���������Ͳ��źź���н������н����,������������ʾ
select first_name ,department_id ,salary * 12 annual_sal
from employees 
order by  annual_sal desc ,first_name asc;
#2. ѡ���ʲ��� 8000 �� 17000 ��Ա���������͹��ʣ������ʽ�����ʾ��21��40λ�õ�����
select first_name ,salary 
from employees 
where salary not between 8000 and 17000
order by salary desc 
limit 20,20;
#3. ��ѯ�����а��� e ��Ա����Ϣ�����Ȱ�������ֽ��������ٰ����ź�����
select * 
from employees 
where email like '%e%'
#where email regexp '[e]'
order by length(email) desc ,department_id asc;

