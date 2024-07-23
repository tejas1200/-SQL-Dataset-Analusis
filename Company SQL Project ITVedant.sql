create database  company;
show databases;
use company;

create table company_divisions (department varchar(100),company_division varchar(100),primary key (department));

insert into company_divisions values ('Automotive','Auto & Hardware');
insert into company_divisions values ('Baby','Domestic');
insert into company_divisions values ('Beauty','Domestic');

insert into company_divisions values ('Clothing','Domestic'),
('Computers','Electronic Equipment'),('Electronics','Electronic Equipment'), 
('Games','Domestic'),('Garden','Outdoors & Garden'),('Grocery','Domestic'),
('Health','Domestic'), ('Home','Domestic'),('Industrial','Auto & Hardware'),
('Jewelery','Fashion'),('Kids','Domestic'),('Movies','Entertainment'), 
('Music','Entertainment'),('Outdoors','Outdoors & Garden'),
('Shoes','Domestic'), ('Sports','Games & Sports');

select * from company_divisions;

create table company_regions (
   region_id int,
   company_regions varchar(20),
   country varchar(20),
   primary key (region_id)
  );

insert into company_regions values (1, 'Northeast', 'USA');

insert into company_regions values (2, 'Southeast', 'USA'),
(3, 'Northwest', 'USA'), (4, 'Southwest', 'USA'),
(5, 'British Columbia', 'Canada'),
(6, 'Quebec', 'Canada'), 
(7, 'Nova Scotia', 'Canada');

select * from company_regions;


create table staff
  (
      id integer,
      last_name varchar(100),
      email varchar(200),
      gender varchar(10),
      department varchar(100),
      start_date date,
      salary integer,
      job_title varchar(100),
      region_id int,
      primary key (id)
  );
  
insert into staff values (1,'Kelley','rkelley0@soundcloud.com','Female','Computers','2009/2/10',67470,'Structural Engineer',2);
insert into staff values (2,'Armstrong','sarmstrong1@infoseek.co.jp','Male','Sports','2009/2/10',71869,'Financial Advisor',2);
insert into staff values (3,'Carr','fcarr2@woothemes.com','Male','Automotive','2009/2/10',101768,'Recruiting Manager',3);
insert into staff values (4,'Murray','jmurray3@gov.uk','Female','Jewelery','2009/2/10',96897,'Desktop Support Technician',3);
insert into staff values (5,'Ellis','jellis4@sciencedirect.com','Female','Grocery','2009/2/10',63702,'Software Engineer III',7);
insert into staff values (6,'Phillips','bphillips5@time.com','Male','Tools','2009/2/10',118497,'Executive Secretary',1);
insert into staff values (7,'Williamson','rwilliamson6@ted.com','Male','Computers','2009/2/10',65889,'Dental Hygienist',6);
insert into staff values (8,'Harris','aharris7@ucoz.com','Female','Toys','2009/2/10',84427,'Safety Technician I',4);
insert into staff values (9,'James','rjames8@prnewswire.com','Male','Jewelery','2009/2/10',108657,'Sales Associate',2);
insert into staff values (10,'Sanchez','rsanchez9@cloudflare.com','Male','Movies','2009/2/10',108093,'Sales Representative',1);
insert into staff values (11,'Jacobs','jjacobsa@sbwire.com','Female','Jewelery','2009/2/10',121966,'Community Outreach Specialist',7);
insert into staff values (12,'Black','mblackb@edublogs.org','Male','Clothing','2009/2/10',44179,'Data Coordiator',7);
insert into staff values (13,'Schmidt','sschmidtc@state.gov','Male','Baby','2009/2/10',85227,'Compensation Analyst',3);
insert into staff values (14,'Webb','awebbd@baidu.com','Female','Computers','2009/2/10',59763,'Software Test Engineer III',4);
insert into staff values (15,'Jacobs','ajacobse@google.it','Female','Games','2009/2/10',141139,'Community Outreach Specialist',7);

select * from  staff;


/************ Basic Statistics with SQL ************/

SELECT * FROM company_divisions
LIMIT 5;

SELECT * FROM company_regions
LIMIT 5;

SELECT * FROM staff
LIMIT 5;

/* 1. How many total employees in this company */
SELECT COUNT(*) FROM staff;


/*2. What about gender distribution? */
SELECT gender, COUNT(*) AS total_employees
FROM staff
GROUP BY gender;

/* 3. How many employees in each department */
SELECT department, COUNT(*) AS total_employee
FROM staff
GROUP BY department
ORDER BY department;


/* 4. How many distinct departments ? */
SELECT DISTINCT(department)
FROM staff
ORDER BY department;


/*5.  What is the highest and lowest salary of employees? */
SELECT MAX(salary) AS Max_Salary, MIN(salary) AS Min_Salary
FROM staff;


/* 6. what about salary distribution by gender group? */

SELECT gender, MIN(salary) As Min_Salary, MAX(salary) AS Max_Salary, AVG(salary) AS Average_Salary
FROM staff
GROUP BY gender;


/* 7. How much total salary company is spending each year? */
SELECT SUM(salary)
FROM staff;


/* 8. want to know distribution of min, max average salary by department */ 
SELECT
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	AVG(salary) AS Average_Salary, 
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 4 DESC;


/* 9.  how spread out those salary around the average salary in each department ? */

SELECT 
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	AVG(salary) AS Average_Salary,
	VAR_POP(salary) AS Variance_Salary,
	STDDEV_POP(salary) AS StandardDev_Salary,
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 4 DESC;


/* 10. which department has the highest salary spread out ? */
SELECT 
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	ROUND(AVG(salary),2) AS Average_Salary,
	ROUND(VAR_POP(salary),2) AS Variance_Salary,
	ROUND(STDDEV_POP(salary),2) AS StandardDev_Salary,
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 6 DESC;


/* 11. Let's see Health department salary */
SELECT department, salary
FROM staff
WHERE department LIKE 'Health'
ORDER BY 2 ASC;

/* 12. we will make 3 buckets to see the salary earning status for Health Department */
CREATE VIEW health_dept_earning_status
AS 
	SELECT 
		CASE
			WHEN salary >= 100000 THEN 'high earner'
			WHEN salary >= 50000 AND salary < 100000 THEN 'middle earner'
			ELSE 'low earner'
		END AS earning_status
	FROM staff
	WHERE department LIKE 'Health';


/* 13. we can see that there are 24 high earners, 14 middle earners and 8 low earners */
SELECT earning_status, COUNT(*)
FROM health_dept_earning_status
GROUP BY 1;


/* 14. Let's find out about Outdoors department salary */
SELECT department, salary
FROM staff
WHERE department LIKE 'Outdoors'
ORDER BY 2 ASC;


CREATE VIEW outdoors_dept_earning_status
AS 
	SELECT 
		CASE
			WHEN salary >= 100000 THEN 'high earner'
			WHEN salary >= 50000 AND salary < 100000 THEN 'middle earner'
			ELSE 'low earner'
		END AS earning_status
	FROM staff
	WHERE department LIKE 'Outdoors';
	
/* 15. we can see that there are 34 high earners, 12 middle earners and 2 low earners */
SELECT earning_status, COUNT(*)
FROM outdoors_dept_earning_status
GROUP BY 1;


/* 
After comparing to Health department with Outdoors department, there are higher numbers of middle 
and low earners buckets in Health than Outdoors. So from those salary earners point of view, the average salary
for Outdoors deparment may be a little bit more stretch than Outdoors deparment which has more high earners.
That's why salary standard deviation value of Health is highest among all departments.
*/
-- drop the unused views
DROP VIEW health_dept_earning_status;
DROP VIEW outdoors_dept_earning_status;


/* 16. What are the deparment start with B */
SELECT
	DISTINCT(department)
FROM staff
WHERE department LIKE 'B%';



/********** Filterig, Join and Aggregration ************/

/* 17. we want to know person's salary comparing to his/her department average salary */
SELECT
	s.last_name,s.salary,s.department,
	(SELECT ROUND(AVG(salary),2)
	 FROM staff s2
	 WHERE s2.department = s.department) AS department_average_salary
FROM staff s;


/* 18. how many people are earning above/below the average salary of his/her department ? */
CREATE VIEW vw_salary_comparision_by_department
AS
	SELECT 
	s.department,
	(
		s.salary > (SELECT ROUND(AVG(s2.salary),2)
					 FROM staff s2
					 WHERE s2.department = s.department)
	)AS is_higher_than_dept_avg_salary
	FROM staff s
	ORDER BY s.department;
	
	
SELECT * FROM vw_salary_comparision_by_department;

SELECT department, is_higher_than_dept_avg_salary, COUNT(*) AS total_employees
FROM vw_salary_comparision_by_department
GROUP BY 1,2;

----------------------------------------------------------------------------------------------

/* 19. Assume that people who earn at latest 100,000 salary is Executive.
We want to know the average salary for executives for each department. */

SELECT department, ROUND(AVG(salary),2) AS average_salary
FROM staff
WHERE salary >= 100000
GROUP BY department
ORDER BY 2 DESC;


/* 20.  who earn the most in the company? 
*/
SELECT last_name, department, salary
FROM staff
WHERE salary = (
	SELECT MAX(s2.salary)
	FROM staff s2
);

/* 21. who earn the most in his/her own department */

SELECT s.department, s.last_name, s.salary
FROM staff s
WHERE s.salary = (
	SELECT MAX(s2.salary)
	FROM staff s2
	WHERE s2.department = s.department
)
ORDER BY 1;

SELECT * FROM company_divisions;

----------------------------------------------------------------------------------------------

/* 22. full details info of employees with company division
Based on the results, we see that there are only 953 rows returns. We know that there are 1000 staffs.
*/
SELECT s.last_name, s.department, cd.company_division
FROM staff s
JOIN company_divisions cd
	ON cd.department = s.department;
	
	
/* 23. now all 1000 staffs are returned, but some 47 people have missing company - division.*/
SELECT s.last_name, s.department, cd.company_division
FROM staff s
LEFT JOIN company_divisions cd
	ON cd.department = s.department;
    
/* 24. who are those people with missing company division? 
*/
SELECT s.last_name, s.department, cd.company_division
FROM staff s
LEFT JOIN company_divisions cd
	ON cd.department = s.department
WHERE company_division IS NULL;

----------------------------------------------------------------------------------------------
CREATE VIEW vw_staff_div_reg AS
	SELECT s.*, cd.company_division, cr.company_regions
	FROM staff s
	LEFT JOIN company_divisions cd ON s.department = cd.department
	LEFT JOIN company_regions cr ON s.region_id = cr.region_id;


SELECT COUNT(*)
FROM vw_staff_div_reg;


/* 25. How many staffs are in each company regions */
SELECT company_regions, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 1
ORDER BY 1;

SELECT company_regions, company_division, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 1,2
ORDER BY 1,2;

/* 26. How many employees with Assistant roles */
SELECT
	COUNT(*) AS employees_with_Assistant_role
FROM staff
WHERE job_title LIKE '%Assistant%';


/* 27. What are those Assistant roles? */
SELECT DISTINCT(job_title)
FROM staff
WHERE job_title LIKE '%Assistant%'
ORDER BY 1;


/* 28. let's check which roles are assistant role or not */
SELECT 
	DISTINCT(job_title),
	job_title LIKE '%Assistant%' is_assistant_role
FROM staff
ORDER BY 1;

/* 29. As there are several duplicated ones, we want to know only unique ones */
SELECT 
	DISTINCT(SUBSTRING(job_title FROM LENGTH('Assistant')+1)) AS job_category,
	job_title
FROM staff
WHERE job_title LIKE 'Assistant%';


---------------------- SubString words ----------------------------------------------------

SELECT 'abcdefghijkl' as test_string;


SELECT 
	SUBSTRING('abcdefghikl' FROM 5 FOR 3) as sub_string;


SELECT 
	SUBSTRING('abcdefghikl' FROM 5) as sub_string;

SELECT job_title
FROM staff
WHERE job_title LIKE 'Assistant%';

/* 30.********* Reformatting Characters Data *********/

SELECT DISTINCT(UPPER(department))
FROM staff
ORDER BY 1;

SELECT DISTINCT(LOWER(department))
FROM staff
ORDER BY 1;














  
  
