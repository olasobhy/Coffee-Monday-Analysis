-- How many people in each city
SELECT 
city_name , 
COUNT(cus.customer_name) customer_counts 
FROM customers cus ,
city c
where c.city_id = cus.city_id
GROUP BY city_name
Order by customer_counts DESC     ---Japipur , Delhi , Pune

--What is the total revenue for each city

SELECT city_name , sum(total) total_sales
FROM  city c , sales s , customers cus
WHERE c.city_id = cus.city_id 
AND cus.customer_id = s.customer_id
GROUP BY city_name
ORDER BY total_sales DESC  --Pune , Chennai , Bangalore

-- What is the sales count for each product in each city
SELECT city_name , 
product_name ,
COUNT(s.product_id) total_counts,
DENSE_RANK() OVER(PARTITION BY city_name ORDER BY COUNT(s.product_id) DESC) AS rank
FROM products p , 
sales s ,city c,
customers cx
WHERE p.product_id = s.product_id
and c.city_id = cx.city_id
and cx.customer_id = s.customer_id
GROUP BY city_name ,product_name 
--ORDER BY total_counts DESC

--What is the Avg sales for each city
SELECT city_name , avg(total) avg_sales
FROM  city c , sales s , customers cus
WHERE c.city_id = cus.city_id 
AND cus.customer_id = s.customer_id
GROUP BY city_name
ORDER BY avg_sales DESC    --- Ahmedabad , indore , kollkata

-- city population and coffee consumers
SELECT city_name ,
population 
FROM city
ORDER BY population DESC  -- Delhi , Kolkata , chennai

--- What is the total sales for each month 
SELECT datename(month , sale_date) month_name ,
COUNT(total) total_sales
FROM sales 
GROUP BY datename(month , sale_date)
ORDER BY total_sales DESC

-- top 3 city has low rent and high total
SELECT  c.city_name , SUM(total)
FROM city c , sales s , customers cu
where c.city_id = cu.city_id
and cu.customer_id = s.customer_id
and c.estimated_rent <= 8100
GROUP BY C.city_name
ORDER BY estimated_rent  --Indore Nagpur Kanpur

-- What is the cities with both low rent and high total sales
 SELECT 
    c.city_name, 
    c.estimated_rent, 
    SUM(s.total) AS total_sales,
	(SUM(s.total)/c.estimated_rent) sales_to_rent_ratio
FROM 
    city c
JOIN 
    customers cu ON c.city_id = cu.city_id
JOIN 
    sales s ON cu.customer_id = s.customer_id
GROUP BY 
    c.city_name, c.estimated_rent
ORDER BY 
     sales_to_rent_ratio DESC  -- pune , jaipur , Chennai

