Create Schema SQL_Practice_Hub;
Use SQL_Practice_Hub;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age BETWEEN 18 AND 65),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    join_date DATE
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =====================================================QUESTIONS===================================================

-- SQL Practice Questions

-- 🔹 Basic (10 Questions)

-- 1) Select all employees from the employees table.

SELECT 
    *
FROM
    employees;
    
-- 2) Retrieve the names and salaries of all employees.

SELECT 
    name, salary
FROM
    employees;
    
-- 3) Find the total number of employees.

SELECT 
    COUNT(*)
FROM
    employees;
    
-- 4) Select all customers who joined after 2021.

SELECT 
    *
FROM
    customers
WHERE
    YEAR(join_date) > 2021;
    
-- 5) Retrieve orders placed in 2023.

SELECT 
    *
FROM
    orders
WHERE
    YEAR(order_date) = 2023;
    
-- 6) Find the highest salary in the employees table.

SELECT 
    MAX(salary) AS Highest_salary
FROM
    employees
ORDER BY Highest_salary DESC
LIMIT 1;

-- 7) Get all employees working in the HR department.

SELECT 
    employees.emp_id, employees.name, departments.dept_name
FROM
    employees
        JOIN
    departments ON employees.dept_id = departments.dept_id
WHERE
    departments.dept_name LIKE 'HR';
    
-- 8) Count the number of orders for each customer.

SELECT 
    customers.customer_id, customers.name, COUNT(orders.order_date) AS order_count
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id,customers.name
ORDER BY order_count DESC;

SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;

-- 9) Find customers from Chicago.

SELECT 
    *
FROM
    customers
WHERE
    city = 'Chicago';
    
-- 10) Display the details of employees earning more than 50,000.

SELECT 
    *
FROM
    employees
WHERE
    salary > 50000;
    

-- 🔹 Intermediate (10 Questions)

-- 1) Find the average salary of employees per department.

SELECT 
    departments.dept_name,
    AVG(employees.salary) AS average_salary
FROM
    departments
        JOIN
    employees ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name;

-- 2) List employees sorted by hire date.

SELECT 
    name, hire_date
FROM
    employees
ORDER BY hire_date;

-- 3) Find the total order amount for each customer.

SELECT 
    customer_id, SUM(amount) AS Total_order_amount
FROM
    orders
GROUP BY customer_id
ORDER BY Total_order_amount DESC;

-- 4) Retrieve employees who were hired in the last 5 years.

SELECT 
    *
FROM
    employees
WHERE
    hire_date >= DATE_SUB(CURRENT_DATE(),
        INTERVAL 5 YEAR);
        
-- 5) Find the top 3 highest-paid employees.

SELECT 
    *
FROM
    employees
ORDER BY salary DESC
LIMIT 3;

-- 6) Get the second-highest salary from the employees table.

SELECT 
    *
FROM
    employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

select max(salary) as second_highest_salary
from employees
where salary < (select max(salary) from employees);


-- 7) Display customers who placed an order worth more than 500.

SELECT 
    customers.*
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
WHERE
    orders.amount > 500;
    
    
-- 8) Count the number of employees in each department.

SELECT 
    departments.dept_name,
    COUNT(employees.emp_id) AS number_of_employees
FROM
    employees
        JOIN
    departments ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name;


-- 9) Retrieve orders placed in the last 6 months.

SELECT 
    *
FROM
    orders
WHERE
    order_date >= DATE_SUB(CURRENT_DATE(),
        INTERVAL 6 MONTH);
        

-- 10) Find employees whose names start with 'A' or 'E'.

SELECT 
    *
FROM
    employees
WHERE
    name LIKE 'A%' OR name LIKE 'E%';
    

-- 🔹 Joins (15 Questions)


-- 1) Get all employees along with their department names.

SELECT 
    employees.name, departments.dept_name
FROM
    employees
        JOIN
    departments ON departments.dept_id = employees.dept_id;
    

-- 2) List all orders with the customer names.

SELECT 
    customers.name,
    orders.order_id,
    orders.amount,
    orders.order_date
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id; 


-- 3) Retrieve employees who belong to the IT department.

SELECT 
    employees.emp_id, employees.name, employees.age
FROM
    employees
        JOIN
    departments ON departments.dept_id = employees.dept_id
WHERE
    departments.dept_name LIKE 'IT';
    

-- 4) Show all customers who have placed an order.

SELECT DISTINCT
    customers.*
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id;
    

-- 5) Find orders placed by customers from New York.

SELECT 
    orders.*
FROM
    orders
        JOIN
    customers ON customers.customer_id = orders.customer_id
WHERE
    customers.city LIKE 'New York';
    

-- 6) Get the total salary paid per department.

SELECT 
    departments.dept_name, SUM(employees.salary) AS Total_salary
FROM
    departments
        JOIN
    employees ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name;


-- 7) Find customers who have never placed an order.

SELECT 
    customers.*
FROM
    customers
        LEFT JOIN
    orders ON customers.customer_id = orders.customer_id
WHERE
    order_id IS NULL;
    
    
-- 8) List employees along with their department, sorted by salary.

SELECT 
    employees.name, departments.dept_name, employees.salary
FROM
    employees
        JOIN
    departments ON departments.dept_id = departments.dept_id
ORDER BY employees.salary DESC;


-- 9) Find the total number of orders per city.

SELECT 
    customers.city, COUNT(orders.order_id) AS Total_orders
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
GROUP BY customers.city;


-- 10) Show employees working in Finance who earn above 70,000.

SELECT 
    employees.*
FROM
    employees
        JOIN
    departments ON employees.dept_id = departments.dept_id
WHERE
    departments.dept_name LIKE 'Finance'
        AND employees.salary > 70000;
        

-- 11) Find the department with the highest average salary.

SELECT 
    departments.dept_name,
    AVG(employees.salary) AS Average_salary
FROM
    departments
        JOIN
    employees ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name
ORDER BY Average_salary DESC
LIMIT 1;


-- 12) Get customers who placed the most expensive order.

SELECT 
    customers.*, orders.amount
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
WHERE
    orders.amount = (SELECT 
            MAX(amount)
        FROM
            orders);
            

-- 13) Retrieve employees who are earning more than their department’s average salary.

SELECT 
    employees.name, employees.salary, departments.dept_name
FROM
    employees
        JOIN
    departments ON departments.dept_id = employees.dept_id
WHERE
    employees.salary > (SELECT 
            AVG(salary) AS average_salary
        FROM
            employees
        WHERE
            dept_id = employees.dept_id);
            

-- 14) Find the city that generated the most revenue from orders.

SELECT 
    customers.city, SUM(orders.amount) AS Total_revenue
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
GROUP BY customers.city
ORDER BY Total_revenue DESC
LIMIT 1;


-- 15) Display departments with fewer than 2 employees.

SELECT 
    departments.dept_name,
    COUNT(employees.emp_id) AS Num_of_employees
FROM
    departments
        LEFT JOIN
    employees ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name
HAVING Num_of_employees < 2;


-- 🔹 Window Functions

-- 1) Rank employees by salary.

SELECT name,age, salary,
RANK() OVER ( ORDER BY salary DESC) AS rnk
FROM employees;


-- 2) Get the cumulative sum of salaries.

SELECT emp_id,name,age,salary,
sum(salary) OVER (ORDER BY emp_id) AS cumulative_salaries
FROM employees;


-- 3) Find the difference between each employee’s salary and the department average.

SELECT emp_id,name,age,dept_id,salary,
salary - avg(salary) over (partition by dept_id) as Department_avg
from employees;


-- 4) Rank customers by the total order amount.

select customer_id, sum(amount) as total_spent,
rank() over (order by sum(amount)desc) as spending_rank
from orders
group by customer_id;


-- 5) Show each order amount along with the running total.

select order_id, customer_id, amount,
sum(amount) over (order by order_date, order_id) as running_total
from orders;

-- 6) Find employees hired most recently per department.

select emp_id, name, dept_id,hire_date,
rank() over (partition by dept_id order by hire_date desc) as recent_hire_employees
from employees;

-- 7) Calculate a moving average of order amounts .

select order_id, order_date, customer_id, amount,
avg(amount) over (order by order_date
rows between 2 preceding and current row) as moving_avg
from orders;

-- 8) Rank employees based on salary within their department.

select emp_id,name,dept_id,salary,
rank() over (partition by dept_id order by salary desc) as dept_salary_rank
from employees;

-- 9) Find the highest salary in each department without using GROUP BY.

select emp_id, name, dept_id, salary,
max(salary) over (partition by dept_id  ) as max_salary
from employees;

-- 10) Get the difference in days between each order.

select order_id,customer_id, order_date,
datediff(order_date, lag(order_date) over (order by order_date)) as diff_in_days_between_each_order
from orders;


-- 11) Calculate a rolling sum of order amounts over the last 3 orders.

select order_id, customer_id, order_date, amount,
sum(amount) over (order by order_date rows between 2 preceding and current row) as rolling_sum
from orders;


-- 12) Show employees along with their previous salary.

select emp_id, name, dept_id, hire_date, salary,
lag(salary) over (partition by emp_id order by salary) as previous_salary
from employees;


-- 13) Find employees who got the highest salary increase.

select emp_id, name, age, dept_id, salary,
salary - lag(salary) over (partition by emp_id order by salary) as salary_increase
from employees;


-- 14) Get the difference between each employee's salary and the next highest salary.

select emp_id, name, age, dept_id, salary,
salary - lead(salary) over ( order by salary desc) as next_highest_salary
from employees;


-- 15) Find customers whose spending increased compared to their last order.

select order_id, customer_id, order_date,  amount,
amount > lag(amount) over (partition by customer_id order by order_date) as increased_amount
from orders;


-- 🔹 Subqueries

-- 1) Find employees who earn more than the average salary.

SELECT 
    *
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);
            
            
-- 2) List customers who placed an order worth more than 500.

SELECT DISTINCT
    customer_id
FROM
    orders
WHERE
    amount > 500;
    
    
-- 3) Get employees who work in the largest department.

SELECT 
    *
FROM
    employees
WHERE
    dept_id = (SELECT 
            dept_id
        FROM
            employees
        GROUP BY dept_id
        ORDER BY COUNT(*) DESC
        LIMIT 1);
        

-- 4) Find customers who have never placed an order.

SELECT 
    *
FROM
    customers
WHERE
    customer_id NOT IN (SELECT DISTINCT
            customer_id
        FROM
            orders);
            
-- 5) Get orders that are above the average order amount.

SELECT 
    *
FROM
    orders
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            orders);
            
            
-- 6) Find employees who have the highest salary in their department.

SELECT 
    *
FROM
    employees e
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees
        WHERE
            dept_id = e.dept_id);


-- 7) Get customers who placed more than 2 orders.

SELECT 
    customer_id
FROM
    orders
GROUP BY customer_id
HAVING COUNT(*) > 2;


-- 8) Find the department with the most employees.

SELECT 
    dept_id
FROM
    employees
GROUP BY dept_id
ORDER BY COUNT(*) DESC
LIMIT 1;


-- 9) Retrieve employees who joined before their department head.

SELECT 
    *
FROM
    employees e1
WHERE
    hire_date < (SELECT 
            MIN(hire_date)
        FROM
            employees e2
        WHERE
            e2.dept_id = e1.dept_id);

-- 10) Show the top 3 highest-paid employees without using LIMIT.

SELECT 
    *
FROM
    employees e1
WHERE
    2 >= (SELECT 
            COUNT(*)
        FROM
            employees e2
        WHERE
            e2.salary > e1.salary);

-- 11) Get employees who earn more than their manager.

SELECT 
    e.emp_id, e.name, e.dept_id, e.salary
FROM
    employees e
WHERE
    e.salary > (SELECT 
            m.salary
        FROM
            employees m
        WHERE
            m.emp_id = e.emp_id);


-- 12) Find customers who placed consecutive high-value orders.

select distinct customer_id, amount  from
(select customer_id, order_date, amount,
lag(amount) over (partition by customer_id order by order_date ) as prev_order_value
from orders) t
where amount > 500 and prev_order_value > 500;


-- 13) Retrieve employees who have a salary within 10% of the highest salary.

SELECT 
    emp_id, name, dept_id, salary
FROM
    employees
WHERE
    salary >= (SELECT 
            MAX(salary) * 90 / 100
        FROM
            employees);


-- 14) Find employees whose salary is higher than the department's median salary.

WITH ranked_salaries AS (
  SELECT dept_id, salary,
  row_number() over (partition by dept_id order by salary) as rn,
  count(*) over (partition by dept_id) as cnt
  from employees),
  
  median_salaries as (
  select dept_id, salary
  from ranked_salaries
  where rn = floor(cnt+1)/2 or rn = floor(cnt+2)/2
  )
  
  SELECT e.* FROM employees e
JOIN median_salaries m ON e.dept_id = m.dept_id
where e.salary > m.salary;


-- 15) Get the percentage of total sales contributed by each customer.

SELECT 
    customer_id,
    SUM(amount) AS total_sales,
    ROUND(SUM(amount) * 100 / (SELECT 
                    SUM(amount)
                FROM
                    orders),
            2) AS Sales_percentage
FROM
    orders
GROUP BY customer_id;
















