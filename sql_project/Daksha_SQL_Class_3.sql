USE [sql_20231201];


USE [sql_20231201];

SELECT * FROM employee
ORDER BY employee_id DESC

SELECT *
FROM
	employee
ORDER BY
	salary DESC;


-- Categorize our salaries
--- where each salary will be in a different BUCKET
---- WHO earns more than 60000 will be classified as HIGH income
--- WHO earns less than 60000 
----but more than 40000 will be classified  AS MEDIUM income
--- anyone who earns less than 40000 will be classified as LOW INCOME



SELECT 
	emp_name AS employee_name
	,emp_dob AS employee_date_of_birth
	,dept_name AS department_name
	,[location] AS employee_location
 	,salary AS employee_salary
	,CASE   -- This is the start of the CASE Statement
		WHEN salary >= 60000	THEN 'High Income'
		WHEN salary >=40000 AND salary < 60000 THEN 'Medium Income'
		WHEN salary >= 30000 AND salary < 40000 THEN ' Medium Low Income'
		ELSE 'Low Income'
	END  AS  salary_categorization--- end is the end command of the CASE statement
FROM
	employee

	-- 240000

---


SELECT 
	emp_name
	,emp_dob
	,dept_name
	,[location]
	,salary
	,CASE
		WHEN dept_name = 'SD-Web' THEN 'Development Team'
		WHEN dept_name = 'SD-DB'  THEN 'Development Team'
		WHEN dept_name = 'SD-Report' THEN 'Non Development Team'
		WHEN dept_name = 'SD-Infra' THEN 'Non Development Team'
		ELSE 'Unknown'
	END
FROM
	employee


--- Select all the people who are from the WEB team or the DB team

SELECT 
	*
FROM
	employee
WHERE
	dept_name = 'SD-Web'
OR	
	dept_name = 'SD-DB';


SELECT
	*
FROM
	employee
WHERE
	dept_name
	IN
		('SD-DB', 'SD-Web');


--- SD-WEB SD-DB SD-Infra

SELECT
	*
FROM
	employee
WHERE
	dept_name IN ('SD-Web', 'SD-DB', 'SD-Infra')
ORDER BY
	dept_name;


--- SD-DB or SD-Web --- then those teams are classified as Development teams


SELECT
	emp_name
	,emp_dob AS emp_date_of_birth
	,dept_name
	,[location] AS emp_location
	,salary
	,CASE
		WHEN dept_name IN ('SD-WEB', 'SD-DB', 'SD-Mobile', 'SD-QA') 
				THEN 'Development Department'
		WHEN dept_name IN ('SD-Infra', 'SD-Report', 'SD-Devops')
				THEN 'Non Development Department'
	END AS dept_category
FROM
	employee


SELECT
	*
FROM
	employee
WHERE
	dept_name
IN
	(
		'SD-DB'
		,'SD-Web'
		,'SD-Mobile'
		,'SD-Devops'
	)
ORDER BY
	dept_name


SELECT
	*
FROM
	employee
WHERE
	dept_name = 'SD-DB'
OR
	dept_name = 'SD-Web'
OR
	dept_name = 'SD-Mobile'
OR
	dept_name = 'SD-Devops'
ORDER BY
	dept_name;


---
SELECT
	*
FROM
	employee
WHERE
	[location] like '%Kerela%'
AND
	dept_name = 'SD-DB'
ORDER BY
	salary DESC;


--- GROUP BY


--- AGG FUNCTIONS

SELECT
	MAX(salary) AS max_salary  --- MAX is an Aggregate function
FROM
	employee


SELECT
	MIN(salary) AS min_salary
FROM
	employee;


SELECT 
	AVG(salary) AS average_salary
FROM	
	employee;

SELECT
	SUM(salary) AS total_salary_paid_to_all_emps
FROM
	employee;

SELECT COUNT(employee_id) FROM employee;

---

SELECT
	dept_name, MAX(salary) AS max_salary   --- MAX salary of each grp
FROM
	employee  ----  step 1, SQL will notice the TABLE
GROUP BY
	dept_name ---- step 2, SQL will split the table it took of notice
				---- in smaller groups based on the dept_name


SELECT
		dept_name, MIN(salary) AS min_salary
FROM
	employee
GROUP BY
	dept_name;


SELECT
	dept_name  AS employee_department
	,MIN(salary) AS min_salary
	,MAX(salary) AS max_salary
	,SUM(salary) AS total_salary_dept
	,AVG(salary) AS avg_salary
	,COUNT(*) AS number_emp_dept
FROM
	employee   ---- Step 1 >> Table name
GROUP BY
	dept_name   --- always do GROUP BY on the original column that
ORDER BY
	max_salary DESC;   ----ORDER BY happens at the end
			--- just before the output is presented on the screen
			--- just before the output is displayed to the user
	



--- we want to find the
--- max salary
--- min salary
--- avg salary
--- count
----  BY dept_name

--- oNLY FOR people who are from Kerela , Karnataka and Tamil


SELECT
	 dept_name,
	 AVG(salary) AS average_salary
	 ,MIN(salary) AS minimum_salary
	 ,MAX(salary) AS maximum_salary
	 ,COUNT(*) AS emp_count
FROM
	employee
WHERE  -- The WHERE clause comes before the GROUP BY clause
	[location] LIKE  '%Kerela%'
OR
	[location] LIKE '%Karnataka%'
OR
	[location] LIKE '%Tamil%'
GROUP BY
	dept_name
ORDER BY
	average_salary DESC;


SELECT
	 dept_name  -- only use columns that you have used to GROUP BY
	 ,AVG(salary) AS average_salary
	 ,MIN(salary) AS minimum_salary
	 ,MAX(salary) AS maximum_salary
	 ,COUNT(*) AS emp_count
FROM
	employee
WHERE  -- The WHERE clause comes before the GROUP BY clause
	[location] LIKE  '%Kerela%'
OR
	[location] LIKE '%Karnataka%'
OR
	[location] LIKE '%Tamil%'
GROUP BY
	dept_name
ORDER BY
	average_salary DESC;


SELECT
	 dept_name  -- only use columns that you have used to GROUP BY
	 ,AVG(salary) AS average_salary
	 ,MIN(salary) AS minimum_salary
	 ,MAX(salary) AS maximum_salary
	 ,COUNT(*) AS emp_count
FROM
	employee
GROUP BY
	dept_name
HAVING
	MIN(salary) >= 30000   -- use HAVING clause
							  -- when you want to filter by AGG values
ORDER BY
	average_salary DESC;


-- see only those records where the MIN(salary) >= 30000
SELECT
	dept_name
	,AVG(salary) AS avg_salary
FROM
	employee
WHERE
	salary >= 30000
GROUP BY
	dept_name
ORDER BY avg_salary


--- 
	

--- 
---Column "employee.location" 
---is invalid in the ORDER BY clause 
----because it is not contained in either an 
-----aggregate function or the GROUP BY clause.