SELECT * FROM retail_sales;

-- total sales in the table
SELECT COUNT(*) as total_sales FROM retail_sales;

CREATE DATABASE retail_sales;

CREATE TABLE retail_sales(
     transactions_id INT PRIMARY KEY,
     sale_date DATE,
     sale_time TIME,
     customer_id INT,
     gender VARCHAR(15),
     age INT,
     category VARCHAR(15),
     quantity INT,
     price_per_unit FLOAT,
     cogs FLOAT,
     total_sales FLOAT
     );

-- Data cleaning --
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR 
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- Data Exploration --
SELECT COUNT(*) as total_sales FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) as total_sales FROM retail_sales;


-- Data Analysis & any key business problems and answers
-- 1 Write a SQL query to retrieve all columns for sale on '2022-11-05
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the 'quantity' sold is more than 4 in month of Nov 2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND quantiy >=4;

-- 3. Write an SQL query to calculate total_sales(total_sales) for each category
SELECT category, SUM(total_sale) as net_sale, COUNT(*) AS total_sales FROM retail_sales
GROUP BY 1;

-- 4. Write an SQL query to find the average age of customers who purchased items from 'Beauty'
SELECT AVG(age) AS Average_age FROM retail_sales
WHERE category = 'Beauty';

-- 5. Write an SQL query to find all transactions where total_sale > 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- 6. Write an SQL query to find the total number of transactions(transactions_id) made by each gender in each category
SELECT  category, gender, COUNT(*) AS total_transactions FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- 7. Find the SQL query to find calculate the average sales or each month. Find out the best selling month of the year
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS sale_rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE sale_rank = 1
ORDER BY year;

-- 8 Write an SQL query to find the top customer based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales desc
LIMIT 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category
SELECT  category, COUNT(DISTINCT customer_id) FROM retail_sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (eg Morning <=12, Afternoon btw 12 and 17, Evening > 17
WITH hourly_sales
AS 
(
SELECT *, 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening' 
    END  AS Shift
FROM retail_sales
)
SELECT Shift, COUNT(*) AS total_orders FROM hourly_sales
GROUP BY Shift;
      
-- End of project.





     
     
	