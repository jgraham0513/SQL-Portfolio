/* This SQL code below is to analyze data from WSDA Music and investigate how they have money missing, and who it could possibly be tracked back to */

/*
Challenge #1
1. How many transactions took place between the years 2011 and 2012?
    -167 invoices
2. How much money did WSDA Music make during the same period?
    -$1947.97
*/

SELECT
    COUNT(Total) AS [Number Of Invoices],
    SUM(Total) AS [Total Money]
FROM
    invoice
WHERE
    Date(invoicedate) BETWEEN '2011-01-01' AND '2012-12-31';

/*
Challenge #2
More targeted questions that query tables containing data about customers and employees
1. Get a list of customers who made purchases between 2011 and 2012.
2. Get a list of customers, sales reps, and total transaction amounts for each customer between 2011 and 2012.
3. How many transactions are above the average transaction amount during the same time period?
4. What is the average transaction amount for each year that WSDA Music has been in business?
*/

SELECT
    c.FirstName,
    c.LastName,
    i.InvoiceDate
FROM
    Invoice i
INNER JOIN
    Customer c
ON
    i.CustomerId = c.CustomerId
WHERE
    InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31'
ORDER BY
    i.InvoiceDate;

/* 2. Get a list of customers, sales reps, and total transaction amounts for each customer between 2011 and 2012. */

SELECT
    c.FirstName AS [Customer First Name],
    c.LastName AS [Customer Last Name],
    e.FirstName AS [Sales Rep First Name],
    e.LastName AS [Sales Rep Last Name],
    i.InvoiceDate,
    i.Total
FROM
    Employee e
INNER JOIN
    Customer c
ON
    e.EmployeeId = c.SupportRepId
INNER JOIN
    Invoice i
ON
    i.CustomerId = c.CustomerId
WHERE
    InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31'
ORDER BY
    i.Total DESC;
    
/* 3. How many transactions are above the average transaction amount during the same time period? 
        -Average transaction amount = 11.67
*/

SELECT
    AVG(Total) AS [Average Transaction Amount]
FROM
    Invoice
WHERE
    InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31';
    
--Total transactions above the average = 26

SELECT
    COUNT(Total) AS [Total Above Average]
FROM
    Invoice
WHERE
    Total >
        (SELECT
            AVG(Total)
        FROM
            Invoice
        WHERE
            InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31')
AND
    InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31';
    

/* 4. What is the average transaction amount for each year that WSDA Music has been in business? 
    -2009: 5.42
    -2010: 5.80
    -2011: 17.51
    -2012: 5.75
    -2013: 5.63
*/

SELECT
    AVG(Total) AS [Average],
    strftime('%Y',InvoiceDate) AS [Year]
FROM
    Invoice
GROUP BY
    strftime('%Y',InvoiceDate);
    

/*Challenge #3
Queries that perform in-depth analysis with the aim of finding employees who may have been financially motivated to commit a crime
1. Get a list of employees who exceeded the average transaction amount from sales they generated during 2011 and 2012.
2. Create a Commission Payout column that displays each employee’s commission based on 15% of the sales transaction amount.
3. Which employee made the highest commission?
4. List the customers that the employee identified in the last question.
5. Which customer made the highest purchase?
6. Look at this customer record—do you see anything suspicious?
7. Who do you conclude is our primary person of interest? */

--1. Get a list of employees who exceeded the average transaction amount from sales they generated during 2011 and 2012.
    --Steve Johnson

SELECT
    e.FirstName,
    e.LastName,
    SUM(i.Total)
FROM
    Invoice i
INNER JOIN
    Employee e
ON
    e.EmployeeId = c.SupportRepId
INNER JOIN
    Customer c
ON
    i.CustomerId = c.CustomerId
WHERE
    InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31'
AND
    i.Total >
        (SELECT
            AVG(Total) AS [Average Transaction Amount]
        FROM
            Invoice
        WHERE
            InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31');
            
/* 2. Create a Commission Payout column that displays each employee’s commission based on 15% of the sales transaction amount. 
        - Steve Johnson - 43.98
        - Margaret Park - 48.45
        - Jane Peacock - 199.77
   3. Which employee made the highest commission? 
        - Jane Peacock
*/

SELECT
    e.FirstName,
    e.LastName,
    SUM(i.Total),2 AS [Total Sales],
    ROUND(SUM(i.Total)*.15,2) AS [Commission Payout]
FROM
    Invoice i
INNER JOIN
    Customer c
ON
    i.CustomerId = c.CustomerId
INNER JOIN
    Employee e
ON
    e.EmployeeId = c.SupportRepId
WHERE
    InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31'
GROUP BY
    e.FirstName,
    e.LastName
ORDER BY
    e.LastName;

/* 4. List the customers that the employee identified in the last question. 
   5. Which customer made the highest purchase?
       -John Doeein - 1000.86 
*/

--List customers supported by Jane Peacock

SELECT
    c.FirstName AS [Customer First Name],
    c.LastName AS [Customer Last Name],
    e.FirstName AS [Employee First Name],
    e.LastName AS [Employee Last Name],
    SUM(i.Total) AS [Total Sales],
    ROUND(SUM(i.Total)*.15,2) AS [Commission Payout]
FROM
    Invoice i
INNER JOIN
    Customer c
ON
    i.CustomerId = c.CustomerId
INNER JOIN
    Employee e
ON
    e.EmployeeId = c.SupportRepId
WHERE
    InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31' AND e.LastName = 'Peacock'
GROUP BY
    c.FirstName,
    c.LastName,
    e.FirstName,
    e.LastName
ORDER BY
    [Total Sales] DESC;
    
/*6. Look at this customer record—do you see anything suspicious?
        - Yes, there is no information about John Doeein aside from his name
7. Who do you conclude is our primary person of interest? 
        - Jane Peacock is the primary person of interest
*/


SELECT
    *
FROM
    Customer c
WHERE
    c.LastName = 'Doeein';
