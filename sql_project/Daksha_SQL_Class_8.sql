SELECT TOP 10 * FROM customers;

SELECT TOP 10 * FROM salesman;   --- dimension tables

SELECT TOP 10 * FROM orders;   ---- FACT TABLES

SELECT TOP 10 * FROM discounts


--- Can you join the orders table with the customers;
SELECT *
FROM 
orders
INNER JOIN 
customers 
ON 
orders.customer_id = customers.customer_id
INNER JOIN
salesman
ON
orders.salesman_id = salesman.sales_id



-- Find customers who did not place any orders
SELECT customers.*
FROM
customers
LEFT JOIN
orders
ON
customers.customer_id = orders.customer_id
WHERE
orders.customer_id IS NULL


---
SELECT 
FROM orders
WHERE
customer_id = 115


--- top 10 order based on price

SELECT TOP 10 *, orders.quantity * orders.item_price AS total_bill
FROM
customers
INNER JOIN
orders
ON
customers.customer_id = orders.customer_id
ORDER BY 
total_bill DESC


----Can you help me find the salesman who make the biggest single sale
SELECT TOP 10 customers.*,
salesman.*, 
orders.purchase_date,
orders.quantity * orders.item_price AS total_bill
FROM
orders
INNER JOIN    --- orders is joined with salesman or saleman_id
salesman
ON
salesman.sales_id = orders.salesman_id
INNER JOIN   ---- orders is joined with customers on customer_id
customers
ON orders.customer_id = customers.customer_id
ORDER BY 
total_bill DESC
-----------------

--- join the salesman table with order table and calculate the sales incentive
---- where the sales incentive is 1% of the total bill

SELECT TOP 10 customers.*,
salesman.*, 
orders.purchase_date,
orders.quantity * orders.item_price AS total_bill,
1/100.0 * orders.quantity * orders.item_price AS sales_incentive
FROM
orders
INNER JOIN    --- orders is joined with salesman or saleman_id
salesman
ON
salesman.sales_id = orders.salesman_id
INNER JOIN   ---- orders is joined with customers on customer_id
customers
ON orders.customer_id = customers.customer_id
ORDER BY 
total_bill DESC



SELECT TOP 10
    salesman.sales_id,
    salesman.sales_name,
	(orders.quantity * orders.item_price) AS total_amount,
	 (orders.quantity * orders.item_price)* 0.01 AS INSENTIVE
FROM
    salesman
INNER JOIN
    orders
	ON salesman.sales_id = orders.salesman_id
ORDER BY
    total_amount DESC;
-----------------


SELECT TOP 10 * FROM discounts
SELECT purchase_date FROM orders

EXEC sp_help orders;

SELECT 
purchase_date
,YEAR(orders.purchase_date) AS purchase_year
,MONTH(orders.purchase_date) AS purchase_month
FROM
orders



SELECT
    orders.order_id,
    orders.customer_id,
    orders.purchase_date,
	orders.quantity,
	orders.item_price,
    YEAR(orders.purchase_date) AS purchase_year,
    MONTH(orders.purchase_date) AS purchase_month,
	discounts.disc_perc
FROM
    orders
INNER JOIN
	discounts
	ON
	YEAR(orders.purchase_date) = discounts.disc_year
	AND
	MONTH(orders.purchase_date) = discounts.disc_month

--- get the customer details
--- the purchase date
--- the quantity and price of the transaction
--- the total bill
--- the discount
--- the bill after discount


SELECT
    customers.customer_id,
	customers.customer_name,
    customers.customer_dob,
    orders.purchase_date,
	orders.quantity,
	orders.item_price,
    YEAR(orders.purchase_date) AS purchase_year,
    MONTH(orders.purchase_date) AS purchase_month,
	discounts.disc_perc,
	(orders.item_price*orders.quantity) AS bill,
	 (orders.item_price*orders.quantity)*disc_perc/100.0 AS [discount amount],
	 (orders.item_price * orders.quantity) - 
	 (orders.item_price*orders.quantity)*disc_perc/100.0 AS [bill after discount]
FROM
    orders
INNER JOIN
	discounts
	ON
	YEAR(orders.purchase_date) = discounts.disc_year
	AND
	MONTH(orders.purchase_date) = discounts.disc_month
INNER JOIN
	customers
ON
	orders.customer_id = customers.customer_id;


---- All the DATE FUNCTIONS THAT SQL PROVIDES
SELECT YEAR(GETDATE()) AS current_year;


SELECT MONTH(GETDATE()) AS current_month;


SELECT DAY(GETDATE()) AS current_month;



SELECT *, 
DATEDIFF(YEAR, sales_doj, GETDATE() ),
DATEDIFF(MONTH, sales_doj, GETDATE()),
DATEDIFF(DAY, sales_doj, GETDATE())
FROM salesman

--- IF THE SALESMAN IS WORKING  FOR MORE THAN 15 years the classify the salesman as senior
-- else if the salesman is working for more than 10 years and less than 15 year
--- then classify the salesman as MID Level
--- else anyone who is working for less than 10 years will be classified as Junior?

---- SCALAR VALUED FUNCTIONS Return a single value as Output

---- system functions are functions that SQL PROVIDES TO the users


--- get the date parts like YEAR MONTH DAY HOUR MIN FROM date
CREATE TABLE student_details
	(
		student_id INT PRIMARY KEY,
		student_name VARCHAR(50),
		course_name VARCHAR(100)
	);


INSERT INTO student_details VALUES (1, 'Saroj','MCA 3rd Year'),
(2, 'Manojit','MBA 3rd Year'),
(3, 'Sreelekha','MCA 2nd Year'),
(4, 'Rakesh','MCA 3rd Year')

CREATE TABLE sport_activity
(
	
	sport_name VARCHAR(100)
	,student_id INT
);


INSERT INTO sport_activity
VALUES
('Cricket', 1),

('Badminton', 1),

('Cricket', 3)


INSERT INTO sport_activity
VALUES
('VoleyBall', 5),
('Basket Ball', 6),
('Khokho', 10);


SELECT * FROM student_details;
SELECT * FROM sport_activity;

SELECT *
FROM
student_details
INNER JOIN
sport_activity
ON
student_details.student_id  = sport_activity.student_id