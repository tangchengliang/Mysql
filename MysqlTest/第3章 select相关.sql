use atguigudb;
select employee_id ,phone_number from employees ;

#6.�еı���
# as:ȫ��  alias�������� ������ʡ��
#�еı�������ʹ��һ��""������:�紦��ո�
select employee_id emp_id,last_name as lname,department_id "����ID",salary *12 "annual sal" 
from employees ;

#7.ȥ���ظ���
#��ѯԱ������һ������Щ����id�أ�
select department_id from employees ; #û��ȥ��
select distinct department_id from employees ; #ȥ�� 

#8.��ֵ����
#(1)��ֵ��null  ������0��'','null'
#(2)��ֵ�������㣺���һ��ҲΪnull
select employee_id,salary "�¹���",salary * (1+commission_pct) * 12 "�깤��",commission_pct 
from employees;

select employee_id,salary "�¹���",salary * (1+ifnull(commission_pct,0)) * 12 "�깤��",commission_pct 
from employees; #����ifnull�����Ϊnull������Ϊ0

#9.���غ� ``, �ֶ����������ͱ����֡�ϵͳ���÷�����ͻ
# select * from order; ����
select * from `order` ;

#10.��ѯ����
select '�й��',123,employee_id,last_name
from employees;

#11.��ʾ��ṹ
describe employees; #��ʾ�����ֶε���ϸ��Ϣ
desc job_grades ;

#12.��������
#��ѯ90�Ų��ŵ�Ա����Ϣ
select *
from employees 
#��������
where department_id =90; 

#��ϰ����ѯlast_name='king'����Ϣ
select *
from employees 
#��������
where last_name='king';  

#��ѯ��Χ����
select *
from employees 
limit 10;

#�κ���ϰ
# 1.��ѯԱ��12���µĹ����ܺͣ��������ΪANNUAL SALARY
select employee_id ,last_name ,salary*(1+ifnull(commission_pct,0))*12 "ANNUAL SALARY"
from employees ;
# 2.��ѯemployees����ȥ���ظ���job_id�Ժ������
select distinct job_id 
from employees ;
# 3.��ѯ���ʴ���12000��Ա�������͹���
select employee_id ,last_name ,salary 
from employees 
where salary >12000;
# 4.��ѯԱ����Ϊ176��Ա���������Ͳ��ź�
select employee_id ,last_name ,department_id 
from employees
where employee_id =176;
# 5.��ʾ�� departments �Ľṹ������ѯ���е�ȫ������
desc departments ;
select * from departments ;