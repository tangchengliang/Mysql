#7�����к���

#1.��ֵ����
	#1.1��������
		SELECT
		ABS(-123),ABS(32),SIGN(-23),SIGN(43),PI(),CEIL(32.32),CEILING(-43.23),FLOOR(32.32),FLOOR(-43.23),MOD(12,5)
		FROM DUAL;
	#1.2�����
		SELECT RAND(),RAND(),RAND(10),RAND(10),RAND(-1),RAND(-1)
		FROM DUAL;
	#1.3�������룬�ضϲ���
		select ROUND(12.33),ROUND(12.343,2),ROUND(12.324,-1),TRUNCATE(12.66,1),TRUNCATE(12.66,-1)
		FROM DUAL;
	#1.3�Ƕ��뻡�Ȼ���
		SELECT RADIANS(30),RADIANS(60),RADIANS(90),DEGREES(2*PI()),DEGREES(RADIANS(90))
		FROM DUAL;
	#1.4���Ǻ���	������x�ǻ���ֵ
		SELECT
		SIN(RADIANS(30)),DEGREES(ASIN(1)),TAN(RADIANS(45)),DEGREES(ATAN(1)),DEGREES(ATAN2(1,1))
		FROM DUAL;
	#1.5ָ���Ͷ���
		SELECT POW(2,5),POWER(2,4),EXP(2),LN(10),LOG10(10),LOG2(4)
		FROM DUAL;
	#1.6����ת��
		SELECT BIN(10),HEX(10),OCT(10),CONV(10,2,8)
		FROM DUAL;
# 2.�ַ�������
	#CONCAT():ƴ������
		select concat(e.last_name," work for ",mgr.last_name) "detail" 
		from employees e join employees mgr 
		where e.manager_id =mgr .employee_id ;
	#CONCAT_WS(x,s1,s2,...)��x��Ϊ���ӷ�
		select concat_ws('-+','hello','word')
		from dual;
	#INSERT(str,idx,len,replacestr)�����滻�ַ�����ע��������1��ʼ
	#REPLACE(str,a,b):��str��a����b
		select insert('hello',2,3,'abcd'),replace('hello','ll','qe')
		from dual;
# 3.����ʱ������
	#3.1��ȡʱ��
		SELECT
		CURDATE(),CURTIME(),NOW(),SYSDATE()+0,UTC_DATE(),UTC_DATE()+0,UTC_TIME(),UTC_TIME()+0
		FROM DUAL;
	#3.2 ������ʱ�����ת��
		SELECT UNIX_TIMESTAMP() from dual;
		SELECT UNIX_TIMESTAMP('2011-11-11 11:11:11') from dual;
		SELECT FROM_UNIXTIME(1320981071) from dual;
	#3.3 ��ȡ�·ݡ����ڡ��������������Ⱥ���
		#���������ա�ʱ����
		SELECT YEAR(CURDATE()),MONTH(CURDATE()),DAY(CURDATE()),
			HOUR(CURTIME()),MINUTE(NOW()),SECOND(SYSDATE())
		FROM DUAL;
		#�����¡��ܡ����ڼ�
		SELECT MONTHNAME('2021-10-26'),DAYNAME('2021-10-26'),WEEKDAY('2021-10-26'),
			QUARTER(CURDATE()),WEEK(CURDATE()),DAYOFYEAR(NOW()),
			DAYOFMONTH(NOW()),DAYOFWEEK(NOW())
		FROM DUAL;
	#3.4���ڲ�������
		#EXTRACT(type FROM date)  ����ָ���������ض��Ĳ��֣�typeָ�����ص�ֵ
		SELECT EXTRACT(MINUTE FROM NOW()),EXTRACT( WEEK FROM NOW()),
		EXTRACT( QUARTER FROM NOW()),EXTRACT( MINUTE_SECOND FROM NOW())
		FROM DUAL;
	#3.5ʱ�������ת��
		SELECT TIME_TO_SEC(NOW()), SEC_TO_TIME(38295)
		from dual;
	#3.6�������ں�ʱ�亯��
		#��һ�飺
		#DATE_ADD(datetime, INTERVAL expr type)���������������ʱ�����INTERVALʱ��ε�����ʱ��
		#DATE_SUB(date,INTERVAL expr type)����
		select now(),date_add(now(),interval 1 year), date_add(now(),interval -1 year)
		from dual;
		
		#�ڶ���
		SELECT
		ADDTIME(NOW(),20),SUBTIME(NOW(),30),SUBTIME(NOW(),'1:1:3'),DATEDIFF(NOW(),'2021-10-01'),
		TIMEDIFF(NOW(),'2021-10-25 22:10:10'),FROM_DAYS(366),TO_DAYS('0000-12-25'),
		LAST_DAY(NOW()),MAKEDATE(YEAR(NOW()),12),MAKETIME(10,21,23),PERIOD_ADD(20200101010101,10)
		FROM DUAL;
	#3.7���ڵĸ�ʽ�������
		#��ʽ��������----->�ַ���
			select date_format(curdate(),'%Y-%m-%d') '������',
				time_format(curtime(),'%H:%i:%s') 'ʱ����',
				date_format(now(),'%Y-%m-%d %H:%i:%s %W %w %T %r') 'ʱ��'
			from dual;
		#�������ַ���----->����
			select str_to_date('2021-October-25th 11:37:30 Monday 1','%Y-%M-%D %h:%i:%S %W %w')
			from dual;
		#��ȡ��ʽGET_FORMAT()
			select get_format(DATE,'USA')
			from dual;

# 4.���̿��ƺ���
	#IF(���������1�����2)
		select last_name ,salary ,if(salary >= 6000,'�߹���','�͹���') 'detail'
		from employees e ;
	#IFNULL(value1,value2)
		select e.commission_pct ,ifnull(commission_pct,0) 'detail' 
		from employees e ;
	#CASE WHEN ... THEN ...WHEN ...THEN ... ELSE ... END:��ѡһ
		select e.last_name ,e.salary ,case when e.salary >= 15000 then '����'
											when e.salary >= 10000 then '����'
											when e.salary >= 8000  then '��˿'
											else 'SB' end "details"
		from employees e ;
	#��ϰ����ѯ���ź�Ϊ 10,20, 30 ��Ա����Ϣ, �����ź�Ϊ 10, ���ӡ�乤�ʵ� 1.1 ��, 
			#20 �Ų���, ���ӡ�乤�ʵ� 1.2 ��, 30 �Ų��Ŵ�ӡ�乤�ʵ� 1.3 ������
		select e.employee_id ,e.last_name ,e.department_id ,case department_id when 10 then e.salary *1.1
																when 20 then e.salary *1.2
																when 30 then e.salary *1.3
																end "detail"
		from employees e 
		where department_id in(10,20,30);
#5.��������ܺ���
	#PASSWORD��str��:MySQL8.0������
	#ENCODE()��DECODE()Ҳ������
	#������--->�������ƽ⣺MD5(str);SHA(str);(����ȫ)
	select md5('mysql'),sha('123456')
	from dual;
#7.MySQL��Ϣ����
	SELECT DATABASE();
	
	select version(),connection_id(),database() ,schema() ,user(),charset('�й��'),collation('�й��')
	from dual;
#8.��������
	#��������
	SELECT FORMAT(123.123, 2), FORMAT(123.523, 0), FORMAT(123.123, -2);
	#����ת��
	SELECT CONV(16, 10, 2), CONV(8888,10,16), CONV(NULL, 10, 2);
	#IP��ַת��
	SELECT INET_ATON('192.168.1.100'),INET_NTOA(3232235876);
	#���Ժ�������ʱ��
	SELECT BENCHMARK(1, MD5('mysql'));
	SELECT BENCHMARK(1000000, MD5('mysql'));
	#�鿴ת������
	SELECT CHARSET('mysql'), CHARSET(CONVERT('mysql' USING 'gbk'))
	from dual;

# 1.��ʾϵͳʱ��(ע������+ʱ��)
	select now() ; 
# 2.��ѯԱ���ţ����������ʣ��Լ�������߰ٷ�֮20%��Ľ����new salary��
	select e.employee_id ,e.last_name ,e.salary ,e.salary *1.2 "new salary"
	from employees e ;
# 3.��Ա��������������ĸ���򣬲�д�������ĳ��ȣ�length��
	select e.employee_id ,e.last_name ,length(e.last_name) "length"
	from employees e 
	order by e.last_name asc;
# 4.��ѯԱ��id,last_name,salary������Ϊһ�������������ΪOUT_PUT
	select concat_ws(' ',e.employee_id,e.last_name,e.salary)  "out put"
	from employees e ;
# 5.��ѯ��˾��Ա���������������������������������������Ľ�������
	select e.last_name ,e.hire_date ,datediff(curdate(),e.hire_date)/365 "year" ,datediff(curdate(),e.hire_date) "day"
	from employees e
    order by  year desc;
# 6.��ѯԱ��������hire_date , department_id����������������
    #����ʱ����1997��֮��department_idΪ80 �� 90 ��110, commission_pct��Ϊ��
   select e.last_name ,e.hire_date ,e.department_id 
   from employees e
   where e.department_id in(80,90,110) 
   and e.commission_pct is not null 
   #and e.hire_date >= '1997-01-01'; #��ʽת��
   #and date_format(hire_date,'%Y-%m-%d') >= '1997-07-01'; #��ʾת������ʽ��������--->�ַ���
   #and date_format(hire_date,'%Y') >= '1997'; 
   and e.hire_date >= str_to_date('1997-01-01','%Y-%m-%d');  #��ʾת�����������ַ���--->����
   
# 7.��ѯ��˾����ְ����10000���Ա����������ְʱ��
  select e.last_name ,e.hire_date 
  from employees e 
  where datediff(curdate(),date_format(hire_date,'%Y-%m-%d')) >= 10000;
# 8.��һ����ѯ����������Ľ��
#<last_name> earns <salary> monthly but wants <salary*3>
	select concat(e.last_name,' earns ',e.salary,' monthly but wants ',e.salary*3)
	from employees e ;

	select concat(e.last_name,' earns ',truncate(e.salary,0) ,' monthly but wants ',truncate(e.salary*3,0))
	from employees e ;

# 9.ʹ��case-when�����������������
/*job grade
AD_PRES A
ST_MAN B
IT_PROG C
SA_REP D
ST_CLERK E
��������Ľ��:
*/
	select e.last_name ,e.job_id ,case job_id when 'AD_PRES' then 'A'
												when 'ST_MAN' then 'B'
												when 'IT_PROG' then 'C'
												when  'SA_REP' then 'D'
												when 'ST_CLERK' then 'E'
												else 'O' end 'grade'
	from employees e ;

