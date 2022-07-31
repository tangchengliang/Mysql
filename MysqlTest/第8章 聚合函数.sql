# ��8�� �ۺϺ���

#1.�����ľۺϺ���
	#1.1 AVG ��SUM��ֻ�����ֵ�Ͳ������ַ������û�����壬���ᱨ��
		select avg(e.salary),sum(e.salary) ,avg(e.last_name) 
		from employees e ; 
					
	#1.2 MAX ��MIN��������������,�������ַ��������ڡ�ʱ��
		select max(e.salary),min(e.salary) ,max(e.last_name) 
		from employees e ;
		
	#1.3 COUNT��������ֵ����,���ã�����ָ���ֶ��ڲ�ѯ�ṹ�г��ֵĸ���
	#��ʽ1��COUNT(*)
	#��ʽ1��COUNT(1)
	#��ʽ1��COUNT(�����ֶ�)�����Ƽ���������null
	#count(*)��ͳ��ֵΪ NULL ���У��� count(����)����ͳ�ƴ���Ϊ NULL ֵ���С�
	#�ʹ洢�����й�ϵ��MySAM��InnoDB
		select count(e.employee_id) ,count(1) ,count(*) 
		from employees e 
		where department_id in(10,20,30);
		#ע�⣺������null
		select count(e.commission_pct) 
		from employees e 
	    where e.commission_pct is not null;
   #ע�⣺
	   #���涼�����¼null����
	   #��ʽ :AVG=SUM/COUNT 
	  	 #��ϰ�����㹫ʽ��ƽ��������
	   	select avg(e.commission_pct) #������Ϊû�м���null����
	   	,sum(e.commission_pct) / count(ifnull(e.commission_pct,0)) #��ȷ��������������
	   	,avg(ifnull(e.commission_pct,0)) 
	  	from employees e ;
#2.GROUP BY��ʹ��
  #2.1���з���
	#���󣺲�ѯ�������ŵ�ƽ������
	  select e.department_id ,avg(e.salary) ,sum(e.salary) 
	  from employees e 
	  group by e.department_id ;
	#���󣺲�ѯ����job��ƽ������
	  select e.job_id ,avg(e.salary) 
	  from employees e 
	  group by e.job_id ;
  #2.2���з���
	 #��ѯ�������ŵ�ƽ�����ʡ�job��ƽ������
	 SELECT department_id dept_id, job_id, SUM(salary)
	 FROM employees
  	 GROUP BY department_id, job_id ; 
  	 
  	#����1��select�г��ֵķ��麯�����ֶ�һ��Ҫ��group by֮����֣���֮��һ��
  	#����2��Group by��from��where��order byǰ�棬limitǰ��
  	#����3��with rollup:�ü�¼�����ѯ�������м�¼���ܺͣ���ͳ�Ƽ�¼������---->ע�⣺����������
  	  select e.job_id ,avg(e.salary) 
	  from employees e 
	  group by e.job_id with rollup ;
	 
#3. HAVING ��ʹ�ã��������ݣ�where��
	 #3.1��ϰ����ѯ������������߹��ʱ�1w�ߵĲ�����Ϣ
	 #��ͳ����where������
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 where max(e.salary)>=10000 
		 group by e.department_id ;
	#Ҫ��1�������������ʹ���˾ۺϺ����������ʹ��HAVING���滻WHERE�����򱨴�
	#Ҫ��2��HAVING����������GROUP BY ֮��
		#��ȷ����having��
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 group by e.department_id 
		 having max(e.salary)>=10000; 
	#Ҫ��3��HAVINGʹ��ǰ�᣺��GROUP BY
		
	 #3.2��ϰ����ѯ����id��=10,20,30,40����߹��ʱ�1w�ߵĲ�����Ϣ
		#��ʽ1��
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 where e.department_id in (10,20,30,40)
		 group by e.department_id 
		 having max(e.salary)>=10000; 
	 	#��ʽ2��
		 select e.department_id ,max(e.salary) 
		 from employees e 
		 group by e.department_id 
		 having max(e.salary)>=10000 and e.department_id in(10,20,30,40); 
	 #���ۣ������������оۺϺ���ʱ����˹�����������������where��
	 #		����ʹ�÷�ʽ1���ȷ��飬���Լ��ٿ�����ִ��Ч�ʸ�
/*
	WHERE��HAVING�ĶԱ�
		1.HAVING���÷�Χ����
		2.��������û�оۺϺ���ʱ��WHEREЧ�ʸ���HAVING ��WHERE��ɸѡ������	
*/
		
#4.SQL�ײ�ԭ��
	#��ִ��˳��
		
#�κ�ϰ��
#1.where�Ӿ�ɷ�ʹ���麯�����й���?
	#no
#2.��ѯ��˾Ա�����ʵ����ֵ����Сֵ��ƽ��ֵ���ܺ�
	select max(e.salary),min(e.salary),avg(e.salary),sum(e.salary) 
	from employees e ;
#3.��ѯ��job_id��Ա�����ʵ����ֵ����Сֵ��ƽ��ֵ���ܺ�
	select e.job_id ,max(e.salary),min(e.salary),avg(e.salary),sum(e.salary) 
	from employees e
	group by e.job_id ; 
#4.ѡ����и���job_id��Ա������
	select e.job_id ,count(*),count(e.job_id) 
	from employees e 
	group by e.job_id ;
# 5.��ѯԱ����߹��ʺ���͹��ʵĲ�ࣨDIFFERENCE��
	select max(e.salary),min(e.salary),  max(e.salary)-min(e.salary) "DIFFERENCE"
	from employees e ;
# 6.��ѯ��������������Ա������͹��ʣ�������͹��ʲ��ܵ���6000��û�й����ߵ�Ա������������
	select e.manager_id ,min(e.salary) 
	from employees e 
	where e.department_id is not null
	group by e.manager_id 
	having min(e.salary)>=6000 ;
	
# 7.��ѯ���в��ŵ����֣�location_id��Ա��������ƽ�����ʣ�����ƽ�����ʽ���
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
# 8.��ѯÿ�����ŵĲ�����������������͹���
	select d.department_name ,e.job_id ,min(e.salary) 
	from employees e right join departments d 
	on e.department_id =d.department_id
	group by d.department_name ,e.job_id ;

	SELECT department_name,job_id,MIN(salary)
	FROM departments d LEFT JOIN employees e
	ON e.`department_id` = d.`department_id`
	GROUP BY department_name,job_id
	