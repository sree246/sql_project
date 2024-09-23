USE [sql_20231201];



CREATE TABLE student_info
(
	student_id INT PRIMARY KEY IDENTITY(1, 1)
	,student_name VARCHAR(100) NOT NULL
	,student_location VARCHAR(100)
	,contact CHAR(10) NOT NULL
);


INSERT INTO student_info
(
	student_name
	,student_location
	,contact
)VALUES
	(
		'Rakesh Kumar'
		,'Behrampur'
		,'8989898989'
	);



INSERT INTO student_info
(
	student_name
	,student_location
	,contact
)VALUES
	(
		'Suresh Kumar'
		,'Ganjam'
		,'9999999999'
	);



INSERT INTO student_info
(
	student_name
	,student_location
	,contact
)VALUES
	(
		'Pradeep Kumar'
		,'Cuttack'
		,'1234512345'
	);



INSERT INTO student_info
(
	student_name
	,student_location
	,contact
)VALUES
	(
		'Simran Behera'
		,'Behrampur'
		,'5656565656'
		
		);


INSERT INTO student_info
(
	student_name
	,student_location
	,contact
)VALUES
	(
		'Sreelekha Sahu'
		,'Rourkela'
		,'4433443311'
		);

INSERT INTO student_info
(
	student_name
	,student_location
	,contact
)VALUES
	(
		'Shubham Panigrahy'
		,'Ganjam'
		,'6789067890'
		);

INSERT INTO student_info
(
	student_name
	,student_location
	,contact
)VALUES
	(
		'Ashish Sahu'
		,'Rourkela'
		,'9123491234'
		);


----- CREATE TABLE FOR subject

CREATE TABLE student_marks
	(
		subject_name VARCHAR(100) NOT NULL
		,student_year INT NOT NULL
		,student_id INT NOT NULL
		,marks_obtained INT NOT NULL
		,total_marks  INT NOT NULL
	);





INSERT INTO student_marks
VALUES
	('Discrete Maths'
	,1
	,2
	,88
	,100
	);



INSERT INTO student_marks
VALUES
	('Discrete Maths'
	,1
	,3
	,78
	,100
	);



INSERT INTO student_marks
VALUES
	('Compiler Design'
	,3
	,1
	,98
	,100
	);

INSERT INTO student_marks
VALUES
	('Compiler Design'
	,1
	,2
	,78
	,100
	);

INSERT INTO student_marks
VALUES
	('Compiler Design'
	,1
	,4
	,88
	,100
	);



INSERT INTO student_marks
VALUES
	('Compiler Design'
	,1
	,5
	,66
	,100
	);











INSERT INTO student_marks
VALUES
	('Discrete Maths'
	,1
	,5
	,78
	,100
	);


INSERT INTO student_marks
VALUES
	('Discrete Maths'
	,1
	,10
	,78
	,100
	);


INSERT INTO student_marks
VALUES
	('Discrete Maths'
	,1
	,25
	,78
	,100
	);



SELECT * FROM student_info;


SELECT * FROM student_marks;




--- get the student_name, location, contact, subject_name, marks_obtained



SELECT
	s_inf.student_name AS [name]
	,s_inf.student_location AS [location]
	,s_inf.contact AS contact
	,s_mar.subject_name AS [subject]
	,s_mar.marks_obtained AS marks
	,s_mar.total_marks AS total
FROM
	student_info AS s_inf
INNER JOIN   --- inner join only gives back matching records
	student_marks AS s_mar
ON  --- join condition
	s_inf.student_id = s_mar.student_id ;


-- That i want to see all the student information and their respective marks
--- even if the student has not appeared in any exam

SELECT 
	s_marks.student_id AS [student id]
	,s_info.student_name AS [name]
	,s_info.student_location AS [location]
	,s_info.contact AS [contact]
	,s_marks.subject_name AS [subject]
	,s_marks.marks_obtained AS [marks]
	,s_marks.total_marks AS [total]
FROM
	student_info AS s_info
LEFT JOIN 
	student_marks AS s_marks
ON
	s_info.student_id = s_marks.student_id;

--- RIGHT JOIN
SELECT 
	s_marks.student_id AS [student id]
	,s_info.student_name AS [name]
	,s_info.student_location AS [location]
	,s_info.contact AS [contact]
	,s_marks.student_id AS [right student id]
	,s_marks.subject_name AS [subject]
	,s_marks.marks_obtained AS [marks]
	,s_marks.total_marks AS [total]
FROM
	student_info AS s_info
RIGHT JOIN 
	student_marks AS s_marks
ON
	s_info.student_id = s_marks.student_id;



SELECT 
	s_info.student_id AS [student id]
	,s_info.student_name AS [name]
	,s_info.student_location AS [location]
	,s_info.contact AS [contact]
	,s_marks.student_id AS [right student id]
	,s_marks.subject_name AS [subject]
	,s_marks.marks_obtained AS [marks]
	,s_marks.total_marks AS [total]
FROM
	student_info AS s_info
FULL OUTER  JOIN 
	student_marks AS s_marks
ON
	s_info.student_id = s_marks.student_id;





--- Get me all the people who have not appeared for a single exam

SELECT 
	s_info.student_id AS [student id]
	,s_info.student_name AS [name]
	,s_info.student_location AS [location]
	,s_info.contact AS [contact]
	,s_marks.subject_name AS [subject]
	,s_marks.marks_obtained AS [marks]
	,s_marks.total_marks AS [total]
FROM
	student_info AS s_info
LEFT JOIN 
	student_marks AS s_marks
ON
	s_info.student_id = s_marks.student_id
WHERE
	s_marks.student_id IS NULL;


	--- get the list of students whose  student information is not available
	--- but the student has written an examination


SELECT
	s_inf.student_name AS [name]
	,s_inf.student_location AS [location]
	,s_inf.contact AS contact
	,s_mar.student_id AS [right student id]
	,s_mar.subject_name AS [subject]
	,s_mar.marks_obtained AS marks
	,s_mar.total_marks AS total
FROM
	student_info AS s_inf
RIGHT JOIN   --- inner join only gives back matching records
	student_marks AS s_mar
ON  --- join condition
	s_inf.student_id = s_mar.student_id
WHERE
	s_inf.student_id IS NULL;


----- find me those records
--- where either student info is present but student did not appear for any exam
--- or student appeared for exam but info is not present

SELECT
	s_inf.student_name AS [name]
	,s_inf.student_location AS [location]
	,s_inf.contact AS contact
	,s_mar.student_id AS [right student id]
	,s_mar.subject_name AS [subject]
	,s_mar.marks_obtained AS marks
	,s_mar.total_marks AS total
FROM
	student_info AS s_inf
FULL OUTER JOIN   --- inner join only gives back matching records
	student_marks AS s_mar
ON  --- join condition
	s_inf.student_id = s_mar.student_id
WHERE
	s_mar.student_id IS NULL
OR
	s_inf.student_id IS NULL;


---- 
SELECT MAX(usr_id) FROM user_info;


SELECT TOP 10 * FROM scores_info;





CREATE TABLE sports
(
	sport_code CHAR(4) NOT NULL
	,sport_name VARCHAR(100) NOT NULL
	,sport_contact VARCHAR(100)
);



ALTER TABLE sports
ADD PRIMARY KEY(sport_code);


INSERT INTO sports
VALUES
	('CRIC', 'Cricket', 'Mr Deb Verma'),
	('VOLL', 'Volley Ball', 'Anusuiya Dutta'),
	('BADM', 'Badminton', 'Ajay Kumar');


SELECT * FROM sports;


CREATE TABLE student_activity
(
	student_id INT PRIMARY KEY
	,student_name VARCHAR(100) NOT NULL
	,sport_code CHAR(4) NOT NULL
	,student_year INT 
	, FOREIGN KEY( sport_code) REFERENCES  sports(sport_code)
)

INSERT INTO student_activity
VALUES
(1, 'Rakesh Kumar', 'VOLL', 3),
(2, 'Shubham Kumar', 'CRIC', 2),
(3, 'Sreelekha Sahu', 'VOLL', 3),
(4, 'Simran Behera', 'Cric', 1);


INSERT INTO student_activity
VALUES
(5, 'Ajay Bhist', 'FOOT', 3)



SELECT  *
FROM
	sports
FULL OUTER JOIN
	student_activity
ON
	sports.sport_code = student_activity.sport_code


SELECT  *
FROM
	sports
LEFT JOIN
	student_activity
ON
	sports.sport_code = student_activity.sport_code


SELECT  TOP 10
	*
FROM
	[dbo].[user_info]


SELECT  TOP 10 *
FROM
	[dbo].[scores_info]


SELECT TOP 10
	us_in.usr_id
	,us_in.[user_name]
	,us_in.psswrd
	,sc_in.game_1_score
	,sc_in.game_2_score
FROM
	user_info as us_in
LEFT JOIN
	scores_info as sc_in
ON
	us_in.usr_id = sc_in.game_user_id
ORDER BY
	sc_in.game_1_score DESC
	,sc_in.game_2_score DESC;