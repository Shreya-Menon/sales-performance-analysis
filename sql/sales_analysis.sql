CREATE TABLE superstore_sales(
ship_mode VARCHAR(50),
segment VARCHAR(50),
country VARCHAR(50),
city VARCHAR(100),
state VARCHAR(100),
postal_code INT,
region VARCHAR(50),
category VARCHAR(50),
sub_category VARCHAR(50),
sales DECIMAL(10,2),
quantity INT,
discount DECIMAL(4,2),
profit DECIMAL(10,2)
);

SELECT COUNT(*) FROM superstore_sales;
SELECT * FROM superstore_sales LIMIT 5; 

SELECT 
COUNT(*)-COUNT(ship_mode) AS ship_mode_nulls,
COUNT(*)-COUNT(segment) AS segment_nulls,
COUNT(*)-COUNT(city) AS city_nulls,
COUNT(*)-COUNT(sales) AS sales_nulls,
COUNT(*)-COUNT(profit) AS profit_nulls
FROM superstore_sales;

SELECT ship_mode,segment,city,category,sub_category,sales,profit,COUNT(*)
FROM superstore_sales
GROUP BY ship_mode,segment,city,category,sub_category,sales,profit
HAVING COUNT(*)>1;

SELECT 
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2)AS total_profit
FROM superstore_sales;

SELECT 
category,
ROUND(SUM(sales),3) AS total_sales
FROM superstore_sales
GROUP BY category
ORDER BY total_sales DESC;

SELECT 
region,
ROUND(SUM(profit),2) AS total_profit
FROM superstore_sales
GROUP BY region
ORDER BY total_profit DESC;

SELECT 
segment,
ROUND(SUM(sales),3) AS total_sales,
ROUND(SUM(profit),3) AS total_profit
FROM superstore_sales
GROUP BY segment
ORDER BY total_sales DESC;

SELECT
sub_category,
ROUND(SUM(profit),2) AS total_profit
FROM superstore_sales
GROUP BY sub_category
ORDER BY total_profit;

SELECT 
sub_category,
ROUND(SUM(profit),2) AS total_loss
FROM superstore_sales
GROUP BY sub_category
HAVING SUM(profit)<0
ORDER BY total_loss
LIMIT 5;

SELECT 
ROUND(discount,2) AS discount_level,
ROUND(AVG(profit),2) AS avg_profit
FROM superstore_sales
GROUP BY ROUND(discount,2)
ORDER BY discount_level;

SELECT
    category,
    sub_category,
    discount,
    profit
FROM superstore_sales
WHERE discount >= 0.3 AND profit < 0
ORDER BY profit;

SELECT
    ship_mode,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_sales
GROUP BY ship_mode
ORDER BY total_profit DESC;

SELECT
    category,
    ROUND(SUM(profit), 2) AS total_profit,
    RANK() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
FROM superstore_sales
GROUP BY category;

SELECT
    category,
    ROUND(SUM(sales), 2) AS category_sales,
    ROUND(
        SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (),
        2
    ) AS sales_percentage
FROM superstore_sales
GROUP BY category;
