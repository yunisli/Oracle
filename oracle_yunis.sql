select * from employees where commission_pct is not null;
select * from employees where manager_id is null;
select * from locations where country_id='UK' order by postal_code;
select first_name||' '||last_name as full_name from employees order by first_name,last_name;
select * from locations where country_id='UK' order by postal_code nulls first;
select * from jobs where job_title in('President','Administration Vice President','Administration Assistant');
select first_name, last_name, email,job_id from employees where job_id not in('FI_MGR','FI_ACCOUNT');

select distinct * from yunis;
select * from employees;
select * from y;
drop table y;
rollback;
commit;

select * from employees,departments where employees.department_id=departments.department_id and departments.department_name='Marketing';


select * from employees;
select concat(first_name,' ', last_name) as full_name from employees;

select employees.first_name||' '||employees.last_name as full_name,employees.email, locations.city from employees,locations,departments
where employees.department_id=departments.department_id and departments.location_id=locations.location_id
and departments.department_name='Marketing';

select employees.first_name||' '||employees.last_name as full_name,employees.email, locations.city from employees inner join departments
on employees.department_id=departments.department_id and departments.department_name='Marketing'
inner join locations on departments.location_id=locations.location_id;

select first_name from employees intersect
select department_name from departments;

--show tables;
select * from employees;
select * from jobs;
select first_name||' '||last_name full_name, e.job_id, j.job_id, min_salary from employees e join jobs j on e.job_id=j.job_id
where j.min_salary= 20000;

select d.department_name, first_name ||' '||last_name full_name from departments d left join employees e on d.department_id=e.department_id;
select e.* from departments d right join employees e on d.department_id=e.department_id;
select * from departments d full join employees e on d.department_id=e.department_id;
select m.first_name||' '||m.last_name as full_name, e.first_name as manager from employees e right join employees m on e.employee_id=m.manager_id;

select * from employees;
delete from yunis;
drop table yunis;
'''CREATE TABLE NON_FUNCTIONAL_LOCATIONS(
LOCATION_ID NUMBER,
POSTAL_CODE NUMBER,
CITY VARCHAR2(30),
COUNTRY_ID CHAR(2));

INSERT INTO NON_FUNCTIONAL_LOCATIONS(LOCATION_ID, POSTAL_CODE, CITY, COUNTRY_ID)
VALUES(1000, 411007, 'PUNE', 'IN');

INSERT INTO NON_FUNCTIONAL_LOCATIONS(LOCATION_ID, POSTAL_CODE, CITY, COUNTRY_ID)
VALUES(1001, 495442, 'RATANPUR', 'IN');

INSERT INTO NON_FUNCTIONAL_LOCATIONS(LOCATION_ID, POSTAL_CODE, CITY, COUNTRY_ID)
VALUES(1002, 110001, 'DELHI', 'IN');

INSERT INTO NON_FUNCTIONAL_LOCATIONS(LOCATION_ID, POSTAL_CODE, CITY, COUNTRY_ID)
VALUES(1003, 00989, 'Roma', 'IT');

INSERT INTO NON_FUNCTIONAL_LOCATIONS(LOCATION_ID, POSTAL_CODE, CITY, COUNTRY_ID)
VALUES(1004, 10934, 'Venice', 'IT');

INSERT INTO NON_FUNCTIONAL_LOCATIONS(LOCATION_ID, POSTAL_CODE, CITY, COUNTRY_ID)
VALUES(1005, 1689, 'Tokyo', 'JP'); 
'''
SELECT postal_code, city FROM non_functional_locations
UNION 
SELECT CASE WHEN REGEXP_LIKE(postal_code, '^\d+$') THEN TO_NUMBER(postal_code) END AS postal_code, city FROM locations;


select city from locations minus 
select city from non_functional_locations; 
select city from non_functional_locations intersect select city from locations;
select * from employees;
select department_name,avg(salary) over(partition by job_id)as avg from employees e,departments d where e.department_id=d.department_id;

update employees set email='y.yunisli11@gmail.com' where email='SKING';
update employees set phone_number='+420773669691' where phone_number='515.123.4567';
select * from employees;
select * from jobs;
select * from departments;
select * from locations;

select * from employees e where exists(select 1 from jobs j where e.job_id=j.job_id)
and exists(select department_id from departments d where e.department_id=d.department_id);



select e.*, d.department_name, l.city from employees e full join departments d on e.department_id=d.department_id full join locations l on d.location_id=l.location_id 
where city = 'Roma';

select first_name,  rank() over(partition by department_id order by salary) from employees;

select first_name||' '||last_name as "Full Name", d.department_id, d.min,d.max,d.count,d.total,d.average  from employees e join (select department_id,min(salary) min,max(salary) max,count(*) count, sum(salary) total, round(avg(salary),1) average from employees where department_id is not null group by department_id) d
on e.department_id=d.department_id;

SELECT department_id,
       min_salary,
       max_salary,
       employee_count,
       total_salary,
       avg_salary
FROM (
    SELECT department_id,
           MIN(salary) AS min_salary,
           MAX(salary) AS max_salary,
           COUNT(*) AS employee_count,
           SUM(salary) AS total_salary,
           ROUND(AVG(salary), 1) AS avg_salary,
           RANK() OVER (ORDER BY department_id) AS rnk
    FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id
)
WHERE rnk = 1;

select count(first_name) from employees;
select * from employees;
select first_name||' '|| last_name,
case
when salary>10000
then 'rich'
when salary<10000 and salary>5000
then 'so-so'
else 'survining'
end as status
from employees;
select * from employees,(select round(avg(salary),1) avrg from employees) avrg;
select * from locations;
create or replace view yunis as
with yun as(select location_id from locations)
select * from employees ,yun;

CREATE OR REPLACE VIEW yan as
with al as(
SELECT y.*, rownum FROM employees y)
select * from al;
select * from yan;


select count(salary) from employees;
select count(*),salary from employees group by salary order by salary desc;

select salary,rownum from employees where salary not in
with rnk as (select distinct salary from employees order by salary desc)
select rnk.*, rownum from rnk where rownum<3;

select department_id,listagg(distinct (first_name||' '||last_name),',')within group(order by last_name)as fullname from employees group by department_id;

select * from employees;
select count(commission_pct) from employees;

create or replace view aun as (
select listagg(hire_date,',') within group(order by full_name) as listlandiya from (select first_name||' '||last_name as full_name, hire_date, 
case when hire_date<to_date('01-JAN-1990','dd-mm-yyyy')
then 'old'
when hire_date>to_date('01-Jan-1990','dd-mm-yyyy') and hire_date<to_date('01-Jan-1995','dd-mm-yyyy')
then 'medium'
else 'new'
end as categorized from employees));

select * from aun;

--with tab1 as(select salary from employees order by salary desc)
--select e.*,rownum from employees e join tab1 on e.salary=tab1.salary order by tab1.salary desc;
select max(salary) from employees where salary not in  
(with t1 as (select salary from employees group by salary order by salary desc)
select salary,rownum from t1 where rownum<3 order by salary desc);


SELECT MAX(salary)
FROM employees
WHERE salary NOT IN  
    (SELECT salary
     FROM (SELECT salary, ROWNUM AS rn
           FROM (SELECT salary
                 FROM employees
                 GROUP BY salary
                 ORDER BY salary DESC)
           WHERE ROWNUM <= 2)
    );
desc non_functional_locations;

with t1 as (select location_id,postal_code,city,country_id from locations union    
select location_id, cast(postal_code as varchar(30)),city,country_id from non_functional_locations)
select t1.* from t1 join (select count(*),location_id from t1 group by location_id having count(*)>1) t2 on t1.location_id=t2.location_id;

with tt as (select location_id,postal_code, city,country_id from locations union
select location_id,cast(postal_code as varchar(20)),city,country_id from non_functional_locations)
select listagg(tt.city,',') within group(order by tt.location_id)as unique_cities from tt join (select city,count(city) from tt group by city having count(city)=1) tt1 on tt.city=tt1.city;

select * from employees e join jobs j on j.job_id=e.job_id
and (salary>max_salary or salary<min_salary);
