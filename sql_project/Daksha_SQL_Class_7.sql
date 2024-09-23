USE [sql_20231201];

SELECT TOP 10 * FROM [dbo].[student_activity]

SELECT TOP 10 * FROM [dbo].[sports]



DROP TABLE IF EXISTS student_activity;


CREATE TABLE student_activity
	(
		student_id INT PRIMARY KEY IDENTITY(1, 1)
		,student_name VARCHAR(60) NOT NULL
		,sport_code CHAR(4) NOT NULL
		,student_year INT NOT NULL
	);


INSERT INTO student_activity
( student_name, sport_code, student_year)
VALUES
('Rakesh Kumar', 'VOLL', 3)
,('Shubham Kumar', 'CRIC', 2)
,('Sreelekha Sahu', 'VOLL', 3)
,('Simran Behera','CRIC', 1)
,('Saroj Kumar Behera', 'VOLL', 2);



DROP TABLE IF EXISTS sports

CREATE TABLE sports
(
	sport_code CHAR(4) PRIMARY KEY
	,sport_name VARCHAR(100) NOT NULL
	,sport_contact VARCHAR(100) NOT NULL
);

INSERT INTO sports
VALUES
	('BADM', 'Badminton', 'Ajay Kumar')
	,('CRIC', 'Cricket', 'Deb Verma')
	,('VOLL', 'Volley Ball', 'Anusuiya Dutta')
	,('BSK','Basket Ball', 'Hardeep Puri')
	,('PING', 'Table Tennis', 'Beena Kumari');






SELECT 
	TOP 10 * 
	FROM 
	[dbo].[sports];


--- can we find the sports where no student is enrolled ????



SELECT
	sports.*
FROM
	student_activity RIGHT JOIN  sports
ON 
	student_activity.sport_code=sports.sport_code
WHERE
	student_activity.student_name IS NULL;



CREATE TABLE employee_information_tab
(
	employee_id INT NOT NULL PRIMARY KEY
	,emp_name VARCHAR(100) NOT NULL
	,dept_id VARCHAR(100) NOT NULL
	,salary INT NOT NULL
	,manager_id INT 
);


INSERT INTO employee_information_tab
VALUES
	(101, 'Ratan Deep', 'SD-Web', 35000, 201)
	,(102, 'Sharda Deep', 'SD-DB', 65000, 202)
	,(103, 'Pooran Singh', 'SD-Web', 65000, 201)
	,(104, 'Hukum Singh', 'SD-Report', 55000, 201)
	,(201, 'Veena', 'SD-Web', 105000, 202)
	,(202, 'Hari Deep', 'SD-Report', 115000, NULL)
	,(124, 'Unmesh Deep', 'SD-Report', 75000, 201)
	,(125, 'Shekhar', 'SD-DB', 85000, 202)
	,(106, 'Poornima Kumari Singh', 'SD-Report', 65000, 202)
	,(107, 'Vayu Singh', 'SD-Report', 50000, 202)
	,(108, 'Kuwar Aditya', 'SD-Web', 105000, 202)
	,(109, 'Hari Singh Nalwa', 'SD-DB', 95000, 202)
	,(110, 'Simran Deepa', 'SD-Report', 85000, 201)
	,(111, 'ShriLekha', 'SD-DB', 95000, 202)
	,(112, 'Rakesh Kumar Swain', 'SD-Report', 85000, 202)
	,(113, 'Saroj Kumar Singh', 'SD-DB', 100000, 202)
	,(115, 'Kuwar Vivek', 'SD-Web', 105000, 202)
	,(116, 'Balarama Nalwa', 'SD-DB', 75000, 202)
	,(117, 'Shubham Maada', 'SD-Web', 70000, 201)
	,(118, 'Geethika Banga', 'SD-Report', 85000, 201)
	,(119, 'Koel Mathew', 'SD-Report', 95000, 201)	
	,(120, 'Lohani Sheetal', 'SD-Report', 85000, 201)
	,(121, 'Saroj Nandi', 'SD-Report', 78000, 201)
	,(122, 'Geethika Banga', 'SD-DB', 88000, 201)
	,(123, 'Koel Mathew', 'SD-Web', 99000, 201);


INSERT INTO employee_information_tab
VALUES	
	(126, 'Lhgarhi Sheetal', 'SD-DB', 125000, 201)
	,(127, 'Shailaja Bala Nandi', 'SD-Report', 28000, 202)
	,(128, 'Harini Balachandaran', 'SD-Web', 148000, 202)
	,(129, 'Koel Harini Kannan', 'SD-DB', 99000, 202);



---- Find the average salary for the Web Development department


SELECT
	AVG(salary) AS average_salary
FROM
	employee_information_tab
WHERE
	dept_id = 'SD-Web';


--- Find the number of people woriking in each department
--- the final answer should be sorted in descending order by the
--- number of people in the department



SELECT
	dept_id, COUNT(*) AS count_dept
FROM
	employee_information_tab
GROUP BY
	dept_id
ORDER BY 
	count_dept DESC;


-- find the department with the highest number of people

SELECT  TOP 1 
	dept_id
FROM
	employee_information_tab
GROUP BY
	dept_id
ORDER BY 
	COUNT(*) DESC;


---- Find the minimum and maximum salary in each department ?


SELECT
	dept_id
	,MAX(salary) AS [max salary]
	,MIN(salary) AS [min salary]
FROM
	employee_information_tab
GROUP BY
	dept_id;



SELECT TOP 10 * FROM employee_information_tab



--- How can I find the employee who had employee_id  of 201
SELECT
	*
FROM
	employee_information_tab
WHERE
	employee_id  = 201




-- SELF Joins
SELECT
	emp_info.employee_id AS employee_id
	,emp_info.emp_name AS employee_name
	,emp_info.dept_id AS [employee department]
	,emp_info.salary AS [employee salary]
	,man_info.emp_name AS [manager name]
	,man_info.dept_id AS [manager department]
	,man_info.salary AS [manager salary]
FROM
	employee_information_tab AS emp_info   --table 1 
INNER JOIN
	employee_information_tab AS man_info  --- table 2
ON
	emp_info.manager_id  = man_info.employee_id


---- find all the employees who work in the same department as the manager

SELECT
	emp_info.employee_id AS employee_id
	,emp_info.emp_name AS employee_name
	,emp_info.dept_id AS [employee department]
	,emp_info.salary AS [employee salary]
	,man_info.emp_name AS [manager name]
	,man_info.dept_id AS [manager department]
	,man_info.salary AS [manager salary]
FROM
	employee_information_tab AS emp_info   --table 1 
INNER JOIN
	employee_information_tab AS man_info  --- table 2
ON
	emp_info.manager_id  = man_info.employee_id
AND
	--- second join condition
	emp_info.dept_id = man_info.dept_id;  ---- non equi joins


---- find all the employees who work in a different department than his /her manager


SELECT
	emp_info.employee_id AS employee_id
	,emp_info.emp_name AS employee_name
	,emp_info.dept_id AS [employee department]
	,emp_info.salary AS [employee salary]
	,man_info.emp_name AS [manager name]
	,man_info.dept_id AS [manager department]
	,man_info.salary AS [manager salary]
FROM
	employee_information_tab AS emp_info   --table 1 
INNER JOIN
	employee_information_tab AS man_info  --- table 2
ON
	emp_info.manager_id  = man_info.employee_id
AND
	--- second join condition
	emp_info.dept_id != man_info.dept_id;  ---- non equi joins


--- find all the employee who earn more than their respective managers

SELECT
	emp_info.employee_id AS employee_id
	,emp_info.emp_name AS employee_name
	,emp_info.dept_id AS [employee department]
	,emp_info.salary AS [employee salary]
	,man_info.emp_name AS [manager name]
	,man_info.dept_id AS [manager department]
	,man_info.salary AS [manager salary]
FROM
	employee_information_tab AS emp_info   --table 1 
INNER JOIN
	employee_information_tab AS man_info  --- table 2
ON
	emp_info.manager_id  = man_info.employee_id
AND
	--- second join condition
	emp_info.salary > man_info.salary

--- find all the employees whose salary is atleast 90% of the manager salary


SELECT
	emp_info.employee_id AS employee_id
	,emp_info.emp_name AS employee_name
	,emp_info.dept_id AS [employee department]
	,emp_info.salary AS [employee salary]
	,man_info.emp_name AS [manager name]
	,man_info.dept_id AS [manager department]
	,man_info.salary AS [manager salary]
FROM
	employee_information_tab AS emp_info   --table 1 
INNER JOIN
	employee_information_tab AS man_info  --- table 2
ON
	emp_info.manager_id  = man_info.employee_id
AND
	--- second join condition
	emp_info.[salary] >=  man_info.salary * 90/100


--- Find what percentage is the employee salary to the manager

SELECT  90 * 1.0 /100



SELECT
	emp_info.employee_id AS employee_id
	,emp_info.emp_name AS employee_name
	,emp_info.dept_id AS [employee department]
	,emp_info.salary AS [employee salary]
	,man_info.emp_name AS [manager name]
	,man_info.dept_id AS [manager department]
	,man_info.salary AS [manager salary]
	,emp_info.salary * 1.0 / man_info.salary *100 AS perc_of_man_sal
FROM
	employee_information_tab AS emp_info   --table 1 
INNER JOIN
	employee_information_tab AS man_info  --- table 2
ON
	emp_info.manager_id  = man_info.employee_id
ORDER BY
	perc_of_man_sal DESC


SELECT 900 * 1.0 /1000