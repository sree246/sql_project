USE [sql_20231201];

---

DROP TABLE IF EXISTS friends
CREATE TABLE friends
(
	friend_name VARCHAR(60)
	,phone_number CHAR(10)
	,dob DATE
);


INSERT INTO friends
VALUES
('Unmesh', '9898989898', '10-July-1986'),
(NULL, NULL, NULL);

INSERT INTO friends
VALUES
(NULL, '8888888888', '21-August-1991');



SELECT * FROM friends;



DROP TABLE IF EXISTS friends;
CREATE TABLE friends
(
	friend_name VARCHAR(60) NOT NULL  -- FRIEND NAME IS defined as NOT NULL
	,phone_number CHAR(10) NOT NULL
	,dob DATE
);


INSERT INTO friends
VALUES
(NULL, '8888888888', '21-August-1991');


INSERT INTO friends
(
	friend_name
	,dob
)
VALUES
(
	'Unmesh'
	,'21-August-1991'
);


INSERT INTO friends	
(

	friend_name
	,phone_number
)VALUES
(
	'Shekhar'
	,'7878787878'
);


INSERT INTO friends
VALUES
('Unmesh', '5555566666', '1985-10-19');

--- YYYY-MM-DD

SELECT * FROM friends;


DROP TABLE IF EXISTS students;
CREATE TABLE students
(
	roll_number INT
	,student_name VARCHAR(100) NOT NULL
	,major_subject VARCHAR(100)
	,PRIMARY KEY(roll_number)
);
	
EXEC sp_help students;

-- 

INSERT INTO students
VALUES
(101, 'Rakesh Kumar Swain', 'MCA');


SELECT * FROM students;



	INSERT INTO students
	(
		roll_number  -- roll_number is PK
		,student_name
		,major_subject
	)
	VALUES
	(
		NULL
		,'Kumar Manoj'
		,'Commerce'
	);

	INSERT INTO students
	(
		roll_number
		,student_name
		,major_subject
	)VALUES
	(
		101 ---- SAME roll_number is being used again
		,'Manojit Saha'
		,'BCOM'
	);


INSERT INTO students
(
	roll_number
	,student_name
	,major_subject
)VALUES
(
	102  --- This is PK value which is a new value
	,'Saroj' --- This is the student name which cannot be NULL
	,'MBA'
);

SELECT * FROM students;

INSERT INTO students
(
	roll_number
	,student_name
)VALUES
(
	103
	,'Sreelekha'
);

SELECT * FROM students;



INSERT INTO students
(
	roll_number
	,student_name
)VALUES
(
	104
	,'Sreelekha'
);


INSERT INTO students
(
	roll_number
	,student_name
)VALUES
(
	105
	,'Sreelekha'
);


DROP TABLE IF EXISTS dummy_table;  -- This query will run first and drop the table 
CREATE TABLE dummy_table
(	
	friend_id INT PRIMARY KEY IDENTITY(1, 1)--- syntetic primary keys
	,friend_name VARCHAR(30) NOT NULL
	,friend_house VARCHAR(100)
	,email VARCHAR(60) UNIQUE
);

INSERT INTO dummy_table
(
	friend_id
	,friend_name
	,friend_house
)
VALUES
(
	101
	,'Bharath Kumar'
	,'Nellore'
);


SELECT * FROM dummy_table;

INSERT INTO dummy_table
(
	friend_name
	,friend_house
)
VALUES
(
	'Rakesh Kumar'
	,'Berhampur'
);


SELECT * FROM dummy_table

-- Lets understand how to insert a explicit primary key when
--- primary key is IDENTITY columns
EXEC sp_help dummy_table;



INSERT INTO dummy_table
(
	friend_name
	,friend_house
	,email   -- the email column was defined as UNIQUE
)VALUES
(
	'Shubham Panigrahy'
	,'Behrampur, Odissa'
	,'superfriend@email.com'
);

SELECT * FROM dummy_table;

INSERT INTO dummy_table
(
	friend_name
	,friend_house
	,email  -- The email column was defined as UNIQUE
)
VALUES
	('Simran'
	,'Behrampur, Odissa'
	,'superfriend@email.com'
);



INSERT INTO dummy_table
(
	friend_name
	,friend_house
)VALUES
	(
		'Simran'
		,'Behrampur, Odissa'
	);

SELECT * FROM dummy_table;



-- Cannot insert duplicate key in object 'dbo.dummy_table'.
-- The duplicate key value is (<NULL>)
INSERT INTO dummy_table
(
	friend_name
	,friend_house
)VALUES
	(
		'Shekhar Kumar'
		,'Bengaluru, Karnataka'
	);



	

CREATE TABLE shopping_list_items
(
	item_number INT IDENTITY(1,1)  -- the seed value is 1 and increment is 1
	,item_name VARCHAR(50) NOT NULL
	,item_quantity INT NOT NULL
);

INSERT INTO shopping_list_items
(
	item_name
	,item_quantity
)
VALUES
(
	'Mustard Oil'
	,2
);


SELECT * FROM shopping_list_items;



INSERT INTO shopping_list_items
(
	item_name
	,item_quantity
)
VALUES
(
	'Rice'
	,15
);


SELECT * FROM shopping_list_items;


--- user info

DROP TABLE IF EXISTS user_info;
CREATE TABLE user_info
(
	usr_id INT PRIMARY KEY IDENTITY(1,1)  --- ONLY PRIMARY KEYS CAN be referenced as FOREIGN KEY
	,user_name VARCHAR(60) NOT NULL  UNIQUE
	,psswrd varchar(60) NOT NULL UNIQUE
);


DROP TABLE IF EXISTS scores_info;
CREATE TABLE scores_info
(
	game_user_id INT IDENTITY(1,1),
	game_1_score INT ,
	game_2_score INT,
	--- CREATE A FOREIGN KEY
	FOREIGN KEY(game_user_id) REFERENCES user_info(usr_id)
);


SELECT * FROM scores_info


SELECT MAX(game_user_id) FROM scores_info;


INSERT INTO scores_info (game_1_score, game_2_score) VALUES  (38, 16);






SELECT * FROM user_info
WHERE
	[user_name] LIKE '%Mithila%';


--- How do I check if the user_name is UNIQUE

SELECT
	[user_name],
	COUNT(*)
FROM
	user_info
GROUP BY
	[user_name]
HAVING 
	COUNT(*) > 1 
;


SELECT psswrd, COUNT(*)
FROM
	user_info
GROUP BY
	psswrd
HAVING
	COUNT(*) > 1;



DROP TABLE IF EXISTS dummy_table
CREATE TABLE dummy_table
	(
		friend_name VARCHAR(60) NOT NULL
		,friend_phone CHAR(10)  NOT NULL
	);


INSERT INTO dummy_table
VALUES
('Adithya', '9898989898'),
('Vinodh', '8888888888'),
('Sumanth', '7878787878');

SELECT * FROM dummy_table;


SELECT friend_name, COUNT(*)
FROM
	dummy_table
GROUP BY friend_name
HAVING
	count(*) > 1

INSERT INTO dummy_table
VALUES
('Shekhar', '4545454545'),
('Shekhar', '4545454545'),
('Shekhar', '4545454545'),
('Shekhar', '4545454545');



--- Additional explanation on FOREIGN KEY
CREATE TABLE subjects
(
	subject_id VARCHAR(40) PRIMARY KEY
	, subject_name VARCHAR(60)
);


INSERT INTO subjects
VALUES
('CPROG', 'C Programming Theory'),
('MATH01', 'Elementary Mathematics');



--- This is the teachers table
---- This table references the subjects table
CREATE TABLE teachers
(
	teacher_id INT PRIMARY KEY IDENTITY(1,1)
	,teacher_name VARCHAR(100) NOT NULL
	,subject_teach VARCHAR(40)
	,FOREIGN KEY (subject_teach) REFERENCES subjects(subject_id)
);


INSERT INTO teachers
(
	teacher_name
	,subject_teach
)VALUES
	(
		'Mithila Kumari'
		,'MATH01'
		);

--- FOREIGN KEY constraint is violated hence not able to insert record
INSERT INTO teachers
(
	teacher_name
	,subject_teach
)VALUES
	(
		'Aiyappa Senthil'
		,'CHEM05'
		);



INSERT INTO subjects
VALUES
('CHEM05', 'Advance Chemistry'),
('ECON01', 'Elementary Economics');

SELECT * FROM subjects;

DELETE FROM subjects
WHERE
subject_id = 'CHEM05';