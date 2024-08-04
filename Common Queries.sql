CREATE TABLE WORKER (
worker_id int primary key auto_increment,
first_name varchar(25),
last_name varchar(25),
salary int(15),
joining_date datetime,
department varchar(25)
);

select * from worker;

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
        
select * from worker;

CREATE TABLE BONUS(
	worker_ref_id int , 
    bonus_amt int , 
    bonus_date datetime , 
    foreign key (worker_ref_id)references worker(worker_id) on delete cascade
    -- you can also do on delete set null
);

select * from bonus;

insert into bonus (worker_ref_id , bonus_amt , bonus_date) values (001,5000,'16-02-20'),(002 , 3000 , '16-06-11'),(003 , 4000 , '16-02-20') , (001 , 4500 , '16-02-20'),(002 , 3500 , '16-06-11');

select * from bonus;

drop table title;

create table title (worker_ref_id int , worker_title varchar(25) , affected_from datetime , foreign key (worker_ref_id)references worker(worker_id) on delete cascade);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 
 select * from title;
 
 -- Q1 .) Fetch first_names of workers with alias worker_name
 select first_name as worker_name from worker; 
 
 -- Q2.) Print all first_names in upper case
 select UPPER(first_name) as worker_name from worker;
 
 -- Q3.) Print unique departments from worker table
 select distinct(department) from worker;
 select department from worker group by department;
 
 -- Q4.) Print first 3 characters of first names in worker table , substring(string , @start , @howMany)
 select substring(first_name , 1 ,3) from worker;
 
 -- Q5.) Find the position of the alphabet 'b' in the first_name column 'Amitabh' from the worker table. , instr finds first occurence of string in another string (case in-sensitive , b = B)
 select INSTR(first_name,'b') from worker where first_name = 'Amitabh';
 
 -- Q6.) Print first_name from worker after removing whitespaces from right side.
 select RTRIM(first_name) from worker;
 
 -- Q7.) unique values of departments with length
 select distinct department , length(department) as length from worker;
 
 -- Q8.) Print first_name as modified name from worker after replacing a with A
 select replace(first_name,'a' , 'A') as modified_name from worker;
 
 -- Q9.) First_name last_name as single column complete_name
 select concat(first_name ," ", last_name) as complete_name from worker;
 
 -- Q10.) Sort the worker details and print by ascending order in first_name
 select * from worker order by first_name;
 
 -- Q11.) Q10 DESCENDING ON DEPARTMENT ALSO
 select * from worker order by first_name , department desc;
 
 -- Q12.) Print details of satish and vipul from worker table
 select * from worker where first_name = "vipul" OR first_name = "satish";
 select * from worker where first_name in ("vipul" , "satish");
 
 -- Q13.)EXCLUDE VIPUL AND SATISH DETAILS
 select * from worker where first_name not in ("vipul" , "satish");
 
 -- Q14.) Details of worker in admin*
 select * from worker where department like 'admin%';
 
 -- Q15.) PRINT DETAILS OF WORKERS WHOSE FIRST NAME CONTAINS 'a'
 select * from worker where first_name like '%a%';
 
 -- Q16.) First name ends with a
 select * from worker where first_name like '%a';
 
 -- Q17.) first name ends with h and contains 6 alphabets
 select * from worker where first_name like '_____h';
 select * from worker where first_name like '%h' and length(first_name) = 6;
 
 -- Q18.) Print details of workers whose salary lies between 1 lakh and 5 lakh , between is inclusive of both.
 select * from worker where salary>=100000 and salary<=500000;
 select * from worker where salary between 100000 and 500000; 
 
 -- Q19.) Details of workers joined in feb 2014 , datetime pe query ese karlo
 select * from worker where year(joining_date)=2014 and month(joining_date) = 02;
 
 -- Q20.) Count of employees working in department "Admin" , here we have multiple employees , so we have to aggregate and count , but agar sirf ek hi department ki baat kar rahe ho to 
 -- group by na b lagaao chalega
 select department , count(*) as admin_strength from worker where department = "Admin";
 select department , count(*) as admin_strength from worker group by department having department = "Admin";
 
 -- Q21.) get full names of workers with salary>=50000 and <=100000
 select salary , concat(first_name , " " , last_name) as full_name from worker where salary between 50000 and 100000;
 
 -- Q22.) No of workers from each department in descending order
 select department , count(*) from worker group by department order by count(*) desc;
 
 -- Q23.) Print details of workers who are also managers(from the title table) , therefore a join is needed!
 -- understand like this 
 -- select what from [both tables joined] ON [condition]
 -- ab join hoke bada table bangaya , ab where lagaalo to filter out more.
 -- rEFERENCE Everything with alias.column
 
 select * from worker as w inner join title as t on w.worker_id = t.worker_ref_id;
 select * from worker as w left join title as t on w.worker_id = t.worker_ref_id where t.worker_title = "Manager";
 
 -- but i just needed worker details
 select w.* from worker as w inner join title as t on w.worker_id=t.worker_ref_id where t.worker_title = "Manager";
 
 -- Q24.) No of diffrent titles in the org
 select count(distinct(worker_title)) from title;
 
  -- Q25.) no of same titles in the org of diffrent types , but only give jisme more than 1 employees hon
  select worker_title , count(*) as no_of_employees from title group by worker_title having no_of_employees > 1;
  
  -- Q26.) Show only odd rows from the table.
  select * from worker where MOD(worker_id , 2)!=0;
  -- even ke liye
  select * from worker where MOD(worker_id , 2) = 0;
  
  -- Q27.) Clone a new table from another table , like is also used to clone the schema.
  create table worker_clone like worker;
  insert into worker_clone (select * from worker);
  select * from worker_clone;
  
  -- Q28.) Get intersecting records from 2 tables.
  select worker.* from worker inner join worker_clone using(worker_id);
  
  -- Q29.) Show records from one table which another table does not have. (watch lecture 9)
SELECT t1.name
FROM table1 t1
LEFT JOIN table2 t2 ON t2.name = t1.name
WHERE t2.name IS NULL (MINUS)
  
  -- Q30.) Current date and time , curdate = only date , now = both date and time.
  select curdate();
  select now(); 
  
  -- Q31.) Write a sql query to show top 5 records based on higher salaries
  select * from worker order by salary desc limit 5;
  
  -- Q32.) Find the nth maximum salary from the table n = 5 , limit 4,1 means 4th se shuru krke ek salary chahiye ab. 4 is offset.
  select * from worker order by salary desc limit 4,1;
  
  -- Q33.) How do you find 5th max salary without using limit? (see lec 9 for correlated subqueries)
  select * from worker w1
  where 4 = (
	select count(distinct(w2.salary)) from worker w2
    where w2.salary>=w1.salary
  );
  
   -- Q34.) Get list of employees with same salary (self join kar sakte ho) (2 tables , seperated means inner join only)
   select w1.* from worker w1 , worker w2 where w1.salary = w2.salary and w1.worker_id!=w2.worker_id;
   
   -- Q35.) Get 2nd max salary using subquery , subqueries get solved first.
   select max(salary) as Second_MAX from worker where salary not in (select max(salary) from worker);
   
   -- Q36.) Get each row twice , union all gives duplicates bhi , union gives distinct.
   select * from worker
   UNION ALL
   select * from worker
   order by worker_id;
   
   -- Q37.) Give worker ids who dont get bonus
   select worker_id from worker where worker_id not in (select worker_ref_id from bonus);
   
   -- Q38.) Write SQL Query to fetch 50% records from the table
   select * from worker where worker_id <= (select count(worker_id)/2 from worker);
   
   -- Q39.) Fetch departments which have less than 4 people in it.
   select department from worker group by department having count(*) < 4;
   
   -- Q40.) Show last record from the table
   select * from worker where worker_id = (select max(worker_id) from worker);
   
   -- Q41.) First record from the table
   select * from worker where worker_id = (select min(worker_id) from worker);
   
	-- Q42.) Fetch last 5 records from the table
    select * from worker order by worker_id desc limit 5;
    -- to reverse its order now
    (select * from worker order by worker_id desc limit 5) order by worker_id;
    
    -- Q43.) Names of employees having highest salary in each department
    -- group by hone ke baad main max , min , sum , count to kar sakta hun , bandon ke naam to backend me chhup gaye groups ke..
    -- max salary leke aaunga , fir max salary ko compare karaunga kisi treeke aur department ko b.
    
    select max(salary) as maxsal , department from worker group by department; 
    
    -- max salary of each department aagayi , use this as temp table to perform a join
    
    select w.department , w.first_name , w.salary from (select max(salary) as maxsal , department from worker group by department) temp
    inner join worker w on temp.department = w.department and temp.maxsal = w.salary;
    
     -- Q44.) Name of workers who earn the highest salary.
     select first_name , last_name , salary from worker where salary = (select max(salary) from worker);
     
      -- Q45.) Total salaries paid in each dept
      select sum(salary) , department from worker group by department;

--Q46.) Do an update of male to female and female to male of gender column in 1 statement
	update table_name set gender = case when 'male' then 'female'
		when 'female' then 'male'
		else gender 
		end;
      
-- ALTER COMMANDS
-- add , modify , change column , add column , rename.

create table account(
id int primary key auto_increment,
name varchar(255) unique , 
balance int not null default 0
);

select * from account;

-- Add new column interest_rate

alter table account add interest_rate float not null default 0;

select * from account;

-- Change datatype of a particular column
alter table account modify interest_rate double not null default 0;

desc account;

-- Change column name
-- alter table name change column oldname newname info;
alter table account change column interest_rate savings_interest_rate double not null default 0;

-- Delete a column
alter table account drop column savings_interest_rate;

-- Rename the table
alter table account rename to account_details;

-- End of Alter ---

-- Update the records
update account_details set balance = 100 , name = 'Sanchit' where id = 1;
-- REPLACE (updates if exisits , else insert)
replace into account_details(id , name) values (1 , "Sanchit");
-- id deni zaroori hai replace me ,  poora row replace hoga aur new values new row banaayengi

-- Delete stuff
delete from account_details where id = 1;

-- VIEWS ---
create view accounts_view as select name from account_details;
select * from accounts_view;

update account_details set name = "Kashish" where name = "sanchit";
select * from account_details;
select * from accounts_view; 
-- view is not a snapshot , its only a layer of abstraction over a full table -- 
-- view can also be altered to redefine its structure ---
alter view accounts_view as select name , id from account_details;
select * from accounts_view;

-- You have a customers and orders table , you need to find customers who did not place any order (easily hojayga from left join)
-- What if you need to print total amount spent by each customer in left join and how to handle nulls?
--ifnull(expression , replacement if expression was null)

select first_name , last_name , email , ifnull(sum(order_amount) , 0) as money_spent
from customers left join orders on customers.customer_id = orders.customer_id
group by customers.customer_id
order by money_spent;


