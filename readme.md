# Expense Data Analysis Project

## Overview
This project uses SQL to perform a detailed analysis of expense data. The primary focus is on querying an expense database to extract insightful financial trends and patterns. This analysis can help organizations or individuals to better understand their spending behavior and make informed financial decisions.

## Table Structure
The database consists of two main tables:

### `public.expenses`
- **ExpenseID** (SERIAL, PRIMARY KEY): Unique identifier for each expense.
- **Date** (TIMESTAMP): Date and time the expense was recorded.
- **Company** (TEXT): Name of the company where the expense occurred.
- **CategoryID** (INT): Identifier for the category of the expense.
- **Cost** (NUMERIC): The cost associated with the expense.

### `public.categories`
- **CategoryID** (INT, PRIMARY KEY): Unique identifier for each category.
- **Category** (TEXT): Description of the expense category.

### Relationships
- The `CategoryID` in the `expenses` table references the `CategoryID` in the `categories` table, linking expenses to their respective categories.

## SQL Queries
This project includes the following SQL queries to analyze the expense data:

1. List unique categories.
2. Find the highest cost purchase.
3. Display the first 20 rows of the expenses data.
4. Show unique company names with expenses.
5. Count unique days with expenses per month, displayed in descending order.
6. Filter data for specific categories (IDs 3 and 4).
7. Identify the highest category ID with expenses in March.
8. Determine which store had the highest expense in May.
9. Identify which category had the lowest total in February.
10. Filter data for stores with names containing the letter "w".
11. Retrieve category names based on Category ID.
12. Check for any missing Category IDs in the expenses table.
13. List categories with total expenses over $150 for April.
14. Analyze patterns in ticket expenses over time.
15. Identify restaurants with the maximum orders on different days.
16. Calculate average daily spend for restaurants.
17. Identify the day of the week with the highest spend in May.
18. Compute monthly grocery costs, formatted as year-month.
19. Calculate total spend at shops beginning with "R".
20. Count unique companies in the shopping category.
21. Analyze monthly spending patterns at Rewe and provide insights.
22. Examine trends in eating at Domino's restaurant.
23. Check for any unusual monthly grocery expenses.
24. Display the company with the highest spend in each category for April.
25. Calculate the percentage change in total costs month-over-month and identify the month with the highest change.
26. Perform the same analysis as above but specifically for the restaurant category.
27. Find the date with the highest number of unique categories.
28. Categorize restaurants as Indian or non-Indian using a CASE statement and calculate the total cost for June.
29. Compare the total spend ratio for restaurants versus groceries in April.
30. Determine the average monthly spend at the Inter store.
31. Identify the company in the shopping category with the highest total cost.
32. Use a UNION clause to combine total costs from a kebab shop and Panda.
33. Check for any fully duplicate records in the data.

## Conclusion
This SQL project showcases the power of database querying to uncover detailed insights from raw expense data. By understanding spending patterns and trends, more effective financial decisions can be made.
