-- 1	find the unique categories in the data

SELECT
    DISTINCT(CategoryID)
FROM
    expenses;

-- 2	Show the purchase which had the highest cost

SELECT
    *
FROM
    expenses
ORDER BY 
    Cost DESC
LIMIT 1;

--3	Query to show only first 20 rows of data

SELECT
    *
FROM
    expenses
LIMIT
    20;

-- 4	show the unique company names where money has been spent

SELECT
    DISTINCT Company
FROM 
    expenses
WHERE 
    Cost IS NOT NULL;

-- 5	How many unique days has money been spent in each month

SELECT
    EXTRACT(MONTH FROM Date) AS months,
    COUNT(DISTINCT Date) AS unique_count
FROM
    expenses
GROUP BY
    months
ORDER BY
    months;

-- 6	For the above question show it in descending order

SELECT
    EXTRACT(MONTH FROM Date) AS months,
    COUNT(DISTINCT Date) AS unique_count
FROM
    expenses
GROUP BY
    months
ORDER BY
    unique_count DESC;

-- 7	show only data of category id 3,4

SELECT
    *
FROM
    expenses
WHERE categoryid IN (3,4);


-- 8	What is highest categoryid of expense in march

SELECT
    categoryid,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    EXTRACT(MONTH FROM Date) = 3
GROUP BY
    categoryid
ORDER BY
    total_cost DESC
LIMIT 1;


-- 9	Which store had the highest expense in may

SELECT
    Company,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    EXTRACT(MONTH FROM Date) = 5
GROUP BY
    Company
ORDER BY
    total_cost DESC
LIMIT 1;


-- 10	Which category had the lowest total number in february

SELECT
    Category,
    SUM(Cost) AS total_cost
FROM
    expenses JOIN categories
    ON expenses.CategoryId = categories.CategoryId
WHERE
    EXTRACT(MONTH FROM Date) = 2
GROUP BY
    categories.Category
ORDER BY
    total_cost
LIMIT 1;


--11	Show the data only where shop name contains the letter w

SELECT
    *
FROM
    expenses
WHERE
    Company LIKE '%w%';


-- 12	find a way to get the category based on category ID.

SELECT
    DISTINCT tab1.CategoryId,
    tab2.Category
FROM
    expenses AS tab1 JOIN
    categories AS tab2
    ON tab1.CategoryId = tab2.CategoryId
ORDER BY
    tab1.categoryid;

--13	Is there any category ID not present in the data table

SELECT
    *
FROM
    expenses AS tab1 FULL OUTER JOIN
    categories AS tab2 ON
    tab1.CategoryId = tab2.CategoryId
WHERE
    tab2.CategoryId IS NULL OR
    tab1.CategoryId IS NULL;


-- 14	show categories with expense more than 150 for the month of april


SELECT
    Category,
    SUM(Cost) AS total_cost
FROM
    expenses AS tab1 JOIN
    categories AS tab2 ON
    tab1.CategoryId = tab2.CategoryId
WHERE
    EXTRACT(MONTH FROM Date) = 4
GROUP BY
    Category
HAVING
    SUM(Cost) > 150;


-- 15	Any patterns in ticket expenses over time

SELECT
    EXTRACT(MONTH FROM Date) AS months,
    SUM(Cost) AS total_cost
FROM
    expenses AS tab1 LEFT JOIN
    categories AS tab2 ON
    tab1.CategoryId = tab2.CategoryId
WHERE
    Category = 'Ticket'
GROUP BY
    months
ORDER BY
    months;

-- 16	Which restaurant has received the maximum orders based on days


SELECT
    tab1.Company,
    COUNT(Date) AS order_count
FROM
    expenses AS tab1 JOIN
    categories AS tab2 ON
    tab1.CategoryId = tab2.CategoryId
WHERE 
    tab2.Category = 'Restaurant'
GROUP BY
    Company
ORDER BY
    order_count DESC;


-- 17	Calculate average spend per day for restaurants

SELECT
   ROUND(SUM(Cost)/COUNT(Date),2)
FROM
    expenses AS tab1 JOIN
    categories AS tab2 ON
    tab1.CategoryId = tab2.CategoryId
WHERE 
    tab2.Category = 'Restaurant'


-- 18	which day of week saw the highest spend in may

SELECT
    TO_CHAR(Date,'Day') AS day,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE   
    EXTRACT(MONTH FROM Date) = 5
GROUP BY
    day
ORDER BY
    total_cost DESC;


-- 19	calculate total cost for grocery per month and show month in year and month format separated by hyphen

SELECT
    TO_CHAR(Date,'YYYY-MM') AS year_month,
    SUM(Cost) AS total_cost
FROM
    expenses AS tab1 JOIN categories AS tab2 ON
    tab1.CategoryId = tab2.CategoryId
WHERE 
    tab2.Category = 'Grocery'
GROUP BY 
    year_month
ORDER BY
    year_month;


-- 20	Calculate total spend for shops starting with capital letter R

SELECT
    Company,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE 
    Company LIKE 'R%'
GROUP BY
    Company;


-- 21	How many unique companies exist in the shopping category

SELECT
    DISTINCT Company
FROM 
    expenses
WHERE
    CategoryId IN
    (SELECT
    CategoryId
    FROM 
        categories
    WHERE
        Category = 'Shopping');


-- 22	What is the spending pattern at Rewe monthwise and any insights

SELECT
    EXTRACT(MONTH FROM Date) AS month,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE 
    Company = 'Rewe'
GROUP BY
    month
ORDER BY
    month;

-- 23	Any trends with respect to eating at dominos restaurant.

SELECT
    EXTRACT(MONTH FROM Date) AS month,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    Company = 'Dominos'
GROUP BY
    month
ORDER BY
    month;


--24	Is there any month where grocery expense is bit different

SELECT
    EXTRACT(MONTH FROM Date) AS month,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    CategoryId IN(
        SELECT
            CategoryId
        FROM
            categories
        WHERE
            Category = 'Grocery'
    )
GROUP BY
    month 
ORDER BY
    month;


-- 25	Show only the company with highest spend in each category for april

WITH top_company AS(
SELECT
    Company,
    Category,
    SUM(Cost) AS total_cost
FROM
    expenses JOIN categories ON
    expenses.CategoryId = categories.CategoryId
WHERE
    EXTRACT(MONTH FROM Date) = 4
GROUP BY
    Category, Company
ORDER BY
    total_cost DESC),

ranked_companies AS(
SELECT
    Company,
    Category,
    total_cost,
    RANK() OVER (PARTITION BY Category ORDER BY total_cost DESC) AS ranking
FROM
    top_company
)

SELECT
    Company,
    Category,
    total_cost
FROM
    ranked_companies
WHERE
    ranking = 1;


-- 26	calculate % change in total cost for each month & find the month with highest % change

WITH previous_month_cost AS (
WITH month_cost AS(
SELECT
    EXTRACT(MONTH FROM Date) AS month,
    SUM(Cost) AS total_cost
FROM
    expenses
GROUP BY
    month
ORDER BY
    month)

SELECT
    month,
    total_cost,
    LAG(total_cost) OVER (ORDER BY month) AS previous_month_cost
FROM
    month_cost
)

SELECT
    month,
    total_cost,
    previous_month_cost,
    ROUND(((total_cost - previous_month_cost)/previous_month_cost)*100,2) AS percent_change
FROM
    previous_month_cost
ORDER BY
    percent_change DESC;


-- 27	do the same as above question but only for restaurant category


WITH month_cost AS (
SELECT
    EXTRACT(MONTH FROM Date) AS month,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    CategoryId IN (
        SELECT
            CategoryId
        FROM
            categories
        WHERE
            Category = 'Restaurant'
    )
GROUP BY
    month
ORDER BY
    month)

, previous_months_cost AS (
SELECT
    month,
    total_cost,
    LAG(total_cost) OVER (ORDER BY month) AS previous_month_cost
FROM
    month_cost)

SELECT
    month,
    total_cost,
    previous_month_cost,
    ROUND(((total_cost - previous_month_cost)/previous_month_cost)*100,2) AS percent_change
FROM
    previous_months_cost
ORDER BY
    percent_change DESC;


-- 28	find the date with highest number of unique categories where money was spent


SELECT
    TO_CHAR(Date,'YYYY-MM'),
    COUNT(DISTINCT CategoryId) AS unique_count
FROM
    expenses
GROUP BY
    Date
ORDER BY
    unique_count DESC
LIMIT 1;


-- 29	Use case statement to categorise restaurants as Indian vs non indian based on name and show total cost for June


SELECT  
    Company,
    CASE
        WHEN Company IN ('Panda', 'Dominos', 'Kebab Shop') THEN 'Non Indian'
        ELSE 'Indian'
        END AS restaurant_category
FROM
    expenses
WHERE 
    CategoryId IN(
        SELECT
            CategoryId
        FROM
            categories
        WHERE
            Category = 'Restaurant'
    );


--30 Show the ratio of total spend for restaurants vs grocery for april


SELECT
    SUM(CASE WHEN CategoryId = 4 THEN Cost ELSE 0 END) AS rest_cost,
    SUM(CASE WHEN CategoryId = 2 THEN Cost ELSE 0 END) AS groc_cost,
    SUM(CASE WHEN CategoryId = 4 THEN Cost ELSE 0 END)/
    NULLIF(SUM(CASE WHEN CategoryId = 2 THEN Cost ELSE 0 END),0) AS spent_ratio
    
FROM
    expenses
WHERE
    EXTRACT(MONTH FROM Date) = 4;


--31	what is the average spend per month at inter store

SELECT
    EXTRACT(MONTH FROM Date) AS month,
    ROUND(SUM(Cost)/COUNT(Date),2) AS avg_spent
FROM
    expenses
WHERE
    Company = 'Inter Store'
GROUP BY
    month
ORDER BY
    month;

--32	which company in shopping category had the highest total cost


SELECT
    Company,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    CategoryId IN (
        SELECT
            CategoryId
        FROM
            categories
        WHERE
            Category = 'Shopping'
    )
GROUP BY
    Company
ORDER BY
    total_cost DESC
LIMIT 1;


--33	Use union clause to show total cost for kebab shop and also panda using two different queries


SELECT
    Company,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    Company = 'Kebab Shop'
GROUP BY
    Company

UNION ALL

SELECT
    Company,
    SUM(Cost) AS total_cost
FROM
    expenses
WHERE
    Company = 'Panda'
GROUP BY
    Company;


--34	is there any fully duplicate value in the data

WITH duplicate_row AS(
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY Company, CategoryId, Cost, Date) AS row_number
FROM
    expenses
)

SELECT
    *
FROM
    duplicate_row
WHERE
    row_number > 1;