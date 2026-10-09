SELECT * FROM pizza_sales;

/*1. Total  Requirement */
SELECT SUM(total_price) FROM pizza_sales

/*2. Total pizzas sold */
SELECT SUM(quantity) FROM pizza_sales

/*3. Total pizzas order */
SELECT COUNT(DISTINCT(order_id)) FROM pizza_sales

/*4. Average Order Value */
SELECT SUM(total_price)/COUNT(DISTINCT order_id) FROM pizza_sales;

/*5. Average pizza per order */
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Average_pizza_per_order
FROM pizza_sales;

/* Daily Trend */
SELECT DATENAME(DW,order_date) AS order_day, 
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

/* Hourly Trend */
SELECT DATEPART(HOUR,order_time) AS order_hours, 
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

/* PERCENTAGE of sales by pizza category */
SELECT pizza_category,SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales)
AS percentage_Total_sales FROM pizza_sales
GROUP BY pizza_category

/* PERCENTAGE of sales by pizza category monthwise*/
SELECT pizza_category,SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales)
AS percentage_Total_sales FROM pizza_sales
WHERE MONTH(order_date) = 6
GROUP BY pizza_category


SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales)
AS DECIMAL(10,2)) AS percentage_Total_sales FROM pizza_sales
GROUP BY pizza_size 
ORDER BY percentage_Total_sales DESC

-- Total Pizza sold by pizza_category --
SELECT pizza_category,SUM(quantity)
AS Total_Pizzas_Sold FROM pizza_sales
GROUP BY pizza_category

-- Top 5 Best sellers by Total pizzas sold --
SELECT TOP 5 pizza_name,SUM(quantity)
AS Total_Pizzas_Sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC