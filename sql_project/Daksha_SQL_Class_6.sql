SELECT
	customer_id 
		,customer_name 
		,customer_age 
		,location 
	,salary
	,purchase_date 
	,cust_id
	,orders.unit_price  
	,orders.quantity_ordered 
	, orders.unit_price * orders.quantity_ordered AS [total bill]
		 --- Calculate the total bill
FROM
	customers
INNER JOIN   --- inner join only gives back matching records
	ORDERS
ON  --- join condition
	customers.customer_id  = ORDERS.cust_id
ORDER BY [total bill] DESC;



-- Sreelekha

SELECT
   customers.customer_name
   ,customers.customer_age
   ,customers.location
   ,customers.salary
   ,ORDERS.purchase_date
   ,ORDERS.unit_price
   ,ORDERS.quantity_ordered
FROM
	customers
INNER JOIN 
	ORDERS
ON 
	customers.customer_id  = ORDERS.cust_id;


--- Find the list of all the customer's who did not make even a single purchase
SELECT
	customers.customer_id
   ,customers.customer_name
   ,customers.customer_age
   ,customers.location
   ,customers.salary
   ,ORDERS.purchase_date
   ,orders.unit_price
   ,orders.quantity_ordered
   ,ORDERS.unit_price*ORDERS.quantity_ordered AS [total bill]
FROM
	customers
LEFT JOIN 
	ORDERS
ON 
	customers.customer_id  = ORDERS.cust_id
WHERE
	orders.purchase_date IS NULL;




SELECT *
FROM
customers
INNER JOIN
orders
ON
customers.customer_id = orders.cust_id
ORDER BY customer_name;


USE [sql_20231201];




SELECT * FROM customers;


SELECT COUNT(*) FROM customers;
SELECT  COUNT(*) FROM orders;


SELECT TOP 10 * FROM customers;
SELECT TOP 10 * FROM orders;



SELECT 
	customers.customer_name
	,customers.customer_age
	,customers.location
	,customers.salary
	,orders.purchase_date
	,orders.unit_price
	,orders.quantity_ordered
	,orders.unit_price * orders.quantity_ordered AS [total bill]
FROM
	customers
INNER JOIN
	orders
ON
	customers.customer_id = orders.cust_id
ORDER BY [total bill] DESC
----------------------------------------------------------------



SELECT * FROM customers;



CREATE TABLE location_info
(
	city_name VARCHAR(60)
	,state_name VARCHAR(60)
	,cost_of_living INT
	,ninety_percentile_income INT
	,PRIMARY KEY(city_name, state_name)--- composite primary key
);


INSERT INTO location_info
VALUES
('Kolkata', 'West Bengal', 85000, 110000),
('Bengaluru', 'Karnataka', 95000, 120000);





INSERT INTO location_info
VALUES
('Durgapur', 'West Bengal', 65000, 100000);


INSERT INTO location_info
VALUES
('Siliguri', 'West Bengal', 65000, 100000);


INSERT INTO location_info
VALUES
('Chennai', 'Tamil Nadu', 95000, 130000);


INSERT INTO location_info
VALUES
('Behrampur', 'Orissa', 75000, 110000);


INSERT INTO location_info
VALUES
('Jamshedpur', 'Jharkhand', 85000, 110000);


INSERT INTO location_info
VALUES
('Panaji', 'Dharwad', 85000, 110000);

INSERT INTO location_info
VALUES
('Mysore', 'Karnataka', 85000, 110000);

INSERT INTO location_info
VALUES
('Bokaro', 'Jharkhand', 85000, 110000);


INSERT INTO location_info
VALUES
('Palamu', 'Jharkhand', 55000, 80000);

INSERT INTO location_info
VALUES
('Ranchi', 'Jharkhand', 85000, 98000);

INSERT INTO location_info
VALUES
('Orccha', 'Madhya Pradesh', 65000, 90000);


INSERT INTO location_info
VALUES
('Bhopal', 'Madhya Pradesh', 90000, 130000);


INSERT INTO location_info
VALUES
('Indore', 'Madhya Pradesh', 88000, 110000);


SELECT  TOP 5 * FROM customers 


SELECT TOP 5 
*,
	city_name +', '+state_name AS city_state
FROM location_info



SELECT *
FROM
	customers
INNER JOIN
	location_info
ON
	customers.location = 
	location_info.city_name +', '+location_info.state_name



--- Salary > cost of living in the city
SELECT *
FROM
	customers
INNER JOIN
	location_info
ON
	customers.location = 
	location_info.city_name +', '+location_info.state_name
AND
	customers.salary > location_info.cost_of_living


SELECT 'Purnendu' +' '+ 'Mukherjee'


--- find the list of people whose city state information is not present




