#7—单行函数

#1.数值函数
	#1.1基本操作
		SELECT
		ABS(-123),ABS(32),SIGN(-23),SIGN(43),PI(),CEIL(32.32),CEILING(-43.23),FLOOR(32.32),FLOOR(-43.23),MOD(12,5)
		FROM DUAL;
	#1.2随机数
		SELECT RAND(),RAND(),RAND(10),RAND(10),RAND(-1),RAND(-1)
		FROM DUAL;
	#1.3四舍五入，截断操作
		select ROUND(12.33),ROUND(12.343,2),ROUND(12.324,-1),TRUNCATE(12.66,1),TRUNCATE(12.66,-1)
		FROM DUAL;
	#1.3角度与弧度互换
		SELECT RADIANS(30),RADIANS(60),RADIANS(90),DEGREES(2*PI()),DEGREES(RADIANS(90))
		FROM DUAL;
	#1.4三角函数	：其中x是弧度值
		SELECT
		SIN(RADIANS(30)),DEGREES(ASIN(1)),TAN(RADIANS(45)),DEGREES(ATAN(1)),DEGREES(ATAN2(1,1))
		FROM DUAL;
	#1.5指数和对数
		SELECT POW(2,5),POWER(2,4),EXP(2),LN(10),LOG10(10),LOG2(4)
		FROM DUAL;
	#1.6进制转换
		SELECT BIN(10),HEX(10),OCT(10),CONV(10,2,8)
		FROM DUAL;
# 2.字符串类型
	#CONCAT():拼接姓名
		select concat(e.last_name," work for ",mgr.last_name) "detail" 
		from employees e join employees mgr 
		where e.manager_id =mgr .employee_id ;
	#CONCAT_WS(x,s1,s2,...)用x作为连接符
		select concat_ws('-+','hello','word')
		from dual;
	#INSERT(str,idx,len,replacestr)插入替换字符串：注意索引从1开始
	#REPLACE(str,a,b):在str中a换成b
		select insert('hello',2,3,'abcd'),replace('hello','ll','qe')
		from dual;
# 3.日期时间类型
	#3.1获取时间
		SELECT
		CURDATE(),CURTIME(),NOW(),SYSDATE()+0,UTC_DATE(),UTC_DATE()+0,UTC_TIME(),UTC_TIME()+0
		FROM DUAL;
	#3.2 日期与时间戳的转换
		SELECT UNIX_TIMESTAMP() from dual;
		SELECT UNIX_TIMESTAMP('2011-11-11 11:11:11') from dual;
		SELECT FROM_UNIXTIME(1320981071) from dual;
	#3.3 获取月份、星期、星期数、天数等函数
		#具体年月日、时分秒
		SELECT YEAR(CURDATE()),MONTH(CURDATE()),DAY(CURDATE()),
			HOUR(CURTIME()),MINUTE(NOW()),SECOND(SYSDATE())
		FROM DUAL;
		#具体月、周、星期几
		SELECT MONTHNAME('2021-10-26'),DAYNAME('2021-10-26'),WEEKDAY('2021-10-26'),
			QUARTER(CURDATE()),WEEK(CURDATE()),DAYOFYEAR(NOW()),
			DAYOFMONTH(NOW()),DAYOFWEEK(NOW())
		FROM DUAL;
	#3.4日期操作函数
		#EXTRACT(type FROM date)  返回指定日期中特定的部分，type指定返回的值
		SELECT EXTRACT(MINUTE FROM NOW()),EXTRACT( WEEK FROM NOW()),
		EXTRACT( QUARTER FROM NOW()),EXTRACT( MINUTE_SECOND FROM NOW())
		FROM DUAL;
	#3.5时间和秒钟转换
		SELECT TIME_TO_SEC(NOW()), SEC_TO_TIME(38295)
		from dual;
	#3.6计算日期和时间函数
		#第一组：
		#DATE_ADD(datetime, INTERVAL expr type)，返回与给定日期时间相差INTERVAL时间段的日期时间
		#DATE_SUB(date,INTERVAL expr type)，减
		select now(),date_add(now(),interval 1 year), date_add(now(),interval -1 year)
		from dual;
		
		#第二组
		SELECT
		ADDTIME(NOW(),20),SUBTIME(NOW(),30),SUBTIME(NOW(),'1:1:3'),DATEDIFF(NOW(),'2021-10-01'),
		TIMEDIFF(NOW(),'2021-10-25 22:10:10'),FROM_DAYS(366),TO_DAYS('0000-12-25'),
		LAST_DAY(NOW()),MAKEDATE(YEAR(NOW()),12),MAKETIME(10,21,23),PERIOD_ADD(20200101010101,10)
		FROM DUAL;
	#3.7日期的格式化与解析
		#格式化：日期----->字符串
			select date_format(curdate(),'%Y-%m-%d') '年月日',
				time_format(curtime(),'%H:%i:%s') '时分秒',
				date_format(now(),'%Y-%m-%d %H:%i:%s %W %w %T %r') '时间'
			from dual;
		#解析：字符串----->日期
			select str_to_date('2021-October-25th 11:37:30 Monday 1','%Y-%M-%D %h:%i:%S %W %w')
			from dual;
		#获取格式GET_FORMAT()
			select get_format(DATE,'USA')
			from dual;

# 4.流程控制函数
	#IF(条件，结果1，结果2)
		select last_name ,salary ,if(salary >= 6000,'高工资','低工资') 'detail'
		from employees e ;
	#IFNULL(value1,value2)
		select e.commission_pct ,ifnull(commission_pct,0) 'detail' 
		from employees e ;
	#CASE WHEN ... THEN ...WHEN ...THEN ... ELSE ... END:多选一
		select e.last_name ,e.salary ,case when e.salary >= 15000 then '高手'
											when e.salary >= 10000 then '将就'
											when e.salary >= 8000  then '屌丝'
											else 'SB' end "details"
		from employees e ;
	#练习：查询部门号为 10,20, 30 的员工信息, 若部门号为 10, 则打印其工资的 1.1 倍, 
			#20 号部门, 则打印其工资的 1.2 倍, 30 号部门打印其工资的 1.3 倍数。
		select e.employee_id ,e.last_name ,e.department_id ,case department_id when 10 then e.salary *1.1
																when 20 then e.salary *1.2
																when 30 then e.salary *1.3
																end "detail"
		from employees e 
		where department_id in(10,20,30);
#5.加密与解密函数
	#PASSWORD（str）:MySQL8.0中弃用
	#ENCODE()和DECODE()也不可用
	#不可逆--->不容易破解：MD5(str);SHA(str);(更安全)
	select md5('mysql'),sha('123456')
	from dual;
#7.MySQL信息函数
	SELECT DATABASE();
	
	select version(),connection_id(),database() ,schema() ,user(),charset('尚硅谷'),collation('尚硅谷')
	from dual;
#8.其他函数
	#四舍五入
	SELECT FORMAT(123.123, 2), FORMAT(123.523, 0), FORMAT(123.123, -2);
	#进制转换
	SELECT CONV(16, 10, 2), CONV(8888,10,16), CONV(NULL, 10, 2);
	#IP地址转换
	SELECT INET_ATON('192.168.1.100'),INET_NTOA(3232235876);
	#测试函数运行时间
	SELECT BENCHMARK(1, MD5('mysql'));
	SELECT BENCHMARK(1000000, MD5('mysql'));
	#查看转换编码
	SELECT CHARSET('mysql'), CHARSET(CONVERT('mysql' USING 'gbk'))
	from dual;

# 1.显示系统时间(注：日期+时间)
	select now() ; 
# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
	select e.employee_id ,e.last_name ,e.salary ,e.salary *1.2 "new salary"
	from employees e ;
# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
	select e.employee_id ,e.last_name ,length(e.last_name) "length"
	from employees e 
	order by e.last_name asc;
# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
	select concat_ws(' ',e.employee_id,e.last_name,e.salary)  "out put"
	from employees e ;
# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
	select e.last_name ,e.hire_date ,datediff(curdate(),e.hire_date)/365 "year" ,datediff(curdate(),e.hire_date) "day"
	from employees e
    order by  year desc;
# 6.查询员工姓名，hire_date , department_id，满足以下条件：
    #雇用时间在1997年之后，department_id为80 或 90 或110, commission_pct不为空
   select e.last_name ,e.hire_date ,e.department_id 
   from employees e
   where e.department_id in(80,90,110) 
   and e.commission_pct is not null 
   #and e.hire_date >= '1997-01-01'; #隐式转换
   #and date_format(hire_date,'%Y-%m-%d') >= '1997-07-01'; #显示转换：格式化：日期--->字符串
   #and date_format(hire_date,'%Y') >= '1997'; 
   and e.hire_date >= str_to_date('1997-01-01','%Y-%m-%d');  #显示转换：解析：字符串--->日期
   
# 7.查询公司中入职超过10000天的员工姓名、入职时间
  select e.last_name ,e.hire_date 
  from employees e 
  where datediff(curdate(),date_format(hire_date,'%Y-%m-%d')) >= 10000;
# 8.做一个查询，产生下面的结果
#<last_name> earns <salary> monthly but wants <salary*3>
	select concat(e.last_name,' earns ',e.salary,' monthly but wants ',e.salary*3)
	from employees e ;

	select concat(e.last_name,' earns ',truncate(e.salary,0) ,' monthly but wants ',truncate(e.salary*3,0))
	from employees e ;

# 9.使用case-when，按照下面的条件：
/*job grade
AD_PRES A
ST_MAN B
IT_PROG C
SA_REP D
ST_CLERK E
产生下面的结果:
*/
	select e.last_name ,e.job_id ,case job_id when 'AD_PRES' then 'A'
												when 'ST_MAN' then 'B'
												when 'IT_PROG' then 'C'
												when  'SA_REP' then 'D'
												when 'ST_CLERK' then 'E'
												else 'O' end 'grade'
	from employees e ;

