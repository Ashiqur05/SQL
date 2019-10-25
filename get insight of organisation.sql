use organisation;
######################################################################
select * from salaries limit 10;
select * from employees limit 10 ;
select * from dept_manager limit 10;
select * from dept_emp limit 10;
select * from departments limit 10;
######################################################################
## Query 1: What is the employee id of the highest paid employee?
select  emp_id, max(salary) 
from salaries
group by emp_id 
order by salary desc 
limit 1;
-- ------or----------
select emp_id, salary
from salaries
order by salary desc
limit 10 ;

## Query 2: What is the name of youngest employee ?
select first_name,last_name, birth_date as youngest_employee  
from employees
order by birth_date desc;
-- ------or----------
select first_name,last_name,max(birth_date)   
from employees
group by  first_name,last_name  
order by max(birth_date)  desc  ;

## Query 3: What is the name of the first hired employee ? 
select emp_id,first_name,last_name,hire_date 
from employees
order by hire_date,emp_id;
-- ------or----------
select min(emp_id),first_name,last_name,min(hire_date) 
from employees
group by first_name,last_name 
order by min(hire_date),emp_id;

## Query 4: What percentage of employees are Female ?
select count(gender) from employees where gender='F';
select 
(select count(gender) from employees where gender='F')*100/
(select count(gender)from employees) from employees limit 1;

## Query 5 :Show the employee count by department name wise, sorted alphabetically on department name.   
select dept_name,count(departments.dept_no )
from departments 
join dept_emp 
on departments.dept_no=dept_emp.dept_no
group by dept_name 
order by dept_name;

## Query 6:Count the number of employees by each calendar year ( take the value of year from from_date)
select extract(year from dept_emp.from_date) as calendar_year, count(employees.emp_id) 
from employees join dept_emp on employees.emp_id=dept_emp.emp_id
group by calendar_year
order by calendar_year desc;

## Query 7 :Count the number of employees by each calendar year (take the value of year from from_date) ordered by calendar year exlcuding all years before 1990.
## Divide the employee count based on gender.
select extract(year from dept_emp.from_date) as calendar_year ,gender,count(employees.emp_id)
from employees join dept_emp on employees.emp_id=dept_emp.emp_id
group by calendar_year,gender having calendar_year>1989
order by calendar_year;

### Query 8:What is the number of managers hired each calendar year. 
select extract(year from from_date) as calendar_year ,count(dept_manager.emp_id) as manager
from dept_manager 
group by calendar_year 
order by calendar_year;

## Query 9:What will be the department wise break up of managers ?

select extract(year from dept_manager.from_date) as calendar_year ,dept_name,count(dept_manager.emp_id) as manager
from dept_manager join departments on dept_manager.dept_no = departments.dept_no 
group by calendar_year,dept_name
order by calendar_year;

##Query 10 :What is the number of male managers and female managers hired each calendar year from the year 1990 onwards?
select extract(year from dept_manager.from_date) as calendar_year ,gender,count(dept_manager.emp_id)
from employees join dept_manager on employees.emp_id=dept_manager.emp_id
group by calendar_year,gender 
order by calendar_year;
