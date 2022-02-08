-- list orderNUmber, productCode, quantityOrdered, Avg quantity ordered for that product for those customer orders where the order quantity for a product in that order is greater than the avdrage order quantity of rthat product

SELECT
  orderNumber,
  product_code,
  quantityOrdered,
  avg_quantity
(SELECT
  orderNumber,
  productCode,
  quantityOrdered,
  AVG(quantityOrdered) OVEr (PARTITION BY productCode) as avg_quantity
FROM orderdetails)  t
WHERE quantityOrdered > avg_quantity


-- List customer name, customer number, total amount payable and credit limit for all the customers who have an amount payable greater than their credit limit;

-- tables needed customers, payments, orders , orderdetails



SELECT
  c.customerNumber,
  c.customerName,
  t2.toBePaid - t1.Paid as amountPayable,
  t1.Paid as paid,
  c.creditLimit,
  amountPayable - paid as 'due'
FROM customers c
INNER JOIN (
  SELECT
    customerNumber,
    SUM(amount) as Paid
  FROM payments
  GROUP BY customerNumber) t1 ON  t1.customerNumber = c.customerNumber
INNER JOIN (
  SELECT
    customerNumber,
    SUM(quantityOrdered*priceEach) as toBePaid  
  FROM orders o 
  INNER JOIN orderdetails d ON o.orderNumber = d.orderNUmber
  GROUP BY customerNumber) t2 ON t2.customerNumber = c.customerNumber
GROUP BY customerNumber
HAVING amountPayable > creditLimit

-- display the number of employees being reported to as well as the number of employees working under him

SELECT
  e1.employeeNumber,
  COUNT(DISTINCT e1.employeeNumber)
FROM employee e1
INNER JOIN employee e2 ON e1.reportsTo = e2.employeeNumber
GROUP BY 


CREATE TABLE usageFacts (
  userName varchar(20),
  actionName varchar(50),
  actionDate date not null default current_date
);
INSERT INTO usageFacts values ('michael', 'launch app');
INSERT INTO usageFacts values ('michael', 'share photo');
INSERT INTO usageFacts values ('shaan', 'share photo');
INSERT INTO usageFacts values ('shaan', 'share photo');
INSERT INTO usageFacts values ('daniel', 'share photo');
INSERT INTO usageFacts values ('lucy', 'share photo');
INSERT INTO usageFacts values ('michael', 'share photo', '2022-01-27');
INSERT INTO usageFacts values ('michael', 'share photo', '2022-01-27');
INSERT INTO usageFacts values ('michael', 'share photo', '2022-01-27');
INSERT INTO usageFacts values ('michael', 'share photo', '2022-01-27');
INSERT INTO usageFacts values ('daniel', 'share photo', '2022-01-27');
INSERT INTO usageFacts values ('daniel', 'share photo', '2022-01-27');
INSERT INTO usageFacts values ('martha', 'share photo', '2022-01-27');




-- SELECT *, EXTRACT(week from actionDate) AS week_number FROM usageFacts;
-- SELECT
--   actionDate,
--   COUNT(DISTINCT username) as DUV
-- FROM usageFacts
-- GROUP BY actionDate
-- ORDER BY actionDate ;


WITH week_user AS (
  SELECT
    EXTRACT(week from actionDate) as week_num,
    userName
  FROM usageFacts
  GROUP BY week_num, username
)

--SELECT * FROM last_week_user


SELECT
  EXTRACT(week from curr_month.actionDate) as week_id,
  ROUND(1.0*COUNT(l.userName)/COUNT(curr_month.userName)*100,2) as perc_rentention
  --ROUND(1.0*COUNT(DISTINCT l.userName)/COUNT(DISTINCT u.userName) *100,2) 
FROM usageFacts curr_month
LEFT JOIN week_user l ON curr_month.userName = l.userName AND EXTRACT(week from curr_month.actionDate) -1 = l.week_num
--WHERE EXTRACT(week from actionDate) = EXTRACT(week from current_date)
;
