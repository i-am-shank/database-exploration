-- Q. 1

CREATE DATABASE company_employees;
USE company_employees;

DESCRIBE company;
DESCRIBE employees;

ALTER TABLE company MODIFY id INT NOT NULL PRIMARY KEY;

ALTER TABLE employees MODIFY id INT NOT NULL PRIMARY KEY;
ALTER TABLE employees ADD FOREIGN KEY(companyID) REFERENCES company(id) ON DELETE CASCADE;


-- --------------------------------------------------


-- 1. Print the name of the employee and the company he/she works for
SELECT CONCAT(e.first_name, " ", e.last_name) AS Name, c.company  AS Company_name FROM Employees AS e INNER JOIN Company AS c ON e.companyID = c.id;

-- 2. Retrieve the names and countries of all companies along with the total number of employees in each company
SELECT c.company, c.country, COUNT(e.id) AS Employee_count FROM Company AS c, Employees AS e WHERE e.companyID = c.id GROUP BY c.company, c.country;

-- 3. Print the name of the company & the average salary of that company
SELECT c.company, AVG(e.salary) AS Average_Salary FROM Company AS c, Employees AS e WHERE c.id = e.companyID GROUP BY c.company;

-- 4. Print the name of the company and the highest salary of that company
SELECT c.company, MAX(e.salary) AS Highest_salary FROM company AS C INNER JOIN employees AS e ON c.id = e.companyID GROUP BY c.company;

-- 5. Print all the company and all the department in that company
SELECT c.company, e.department FROM company AS c INNER JOIN employees AS e ON c.id = e.companyID GROUP BY c.company, e.department;

-- 6. Print the name of the company and the number of employee in that company
SELECT c.company, COUNT(e.id) AS Number_of_employees FROM company AS c INNER JOIN employees AS e ON c.id = e.companyID GROUP BY c.company;

-- 7. Print the name of the company and the highest salary of each department
SELECT c.company, e.department, MAX(e.salary) AS Highest_salary FROM company AS c INNER JOIN employees AS e ON c.id = e.companyID GROUP BY c.company, e.department;

-- 8. Print the company name who have the highest number of employees whose name starts with the letter "S"
SELECT c.company FROM company AS c INNER JOIN employees AS e ON c.id = e.companyID WHERE c.company LIKE "S%" GROUP BY c.company ORDER BY COUNT(e.id) DESC LIMIT 1;

-- 9. Print all departments and their average salary
SELECT department, AVG(salary) AS Average_salary FROM employees GROUP BY department;

-- 10. Print the company name and the employee's full name. Full name will be like firstName + " " + lastName
SELECT c.company, CONCAT(e.first_name, " ", e.last_name) AS Employee_name FROM company AS c INNER JOIN employees AS e ON c.id = e.companyID;

DESCRIBE employees;
DESCRIBE company;

-- 11. Print the email addresses of all employees.
SELECT email FROM employees;

-- 12. Retrieve the names of employees who are in the "Engineering" department
SELECT CONCAT(first_name, " ", last_name) AS Employee_name FROM employees WHERE department = "Engineering";

-- 13. List all unique job titles (departments) in the company.
SELECT DISTINCT department FROM employees;

-- 14. Display the total number of employees in the "Support" department.
SELECT COUNT(id) AS Number_of_employees FROM employees WHERE department = "Support";

-- 15. Print the names of companies located in the "United States"
SELECT company FROM company WHERE country = "United States";

-- 16. List the first names of employees who have a salary greater than $300,000. 
SELECT first_name FROM employees WHERE salary > 300000;

-- 17. Retrieve the last names of all employees whose company is in "Brazil". 
SELECT e.last_name FROM employees AS e INNER JOIN company AS c ON e.companyID = c.id WHERE c.country = "Brazil";

DESCRIBE employees;
DESCRIBE company;

-- 18. Print the names of employees who have an "Agender" gender.
SELECT CONCAT(first_name, " ", last_name) AS Name FROM employees WHERE gender = "Agender";

-- 19. Display the names of all companies that have employees in the "Human Resources" department. 
SELECT c.company FROM company AS c INNER JOIN employees AS e WHERE e.department = "Human Resources" GROUP BY c.company;

-- 20. List the names of employees and their respective departments who have a salary less than $100,000. 
SELECT CONCAT(first_name, " ", last_name) AS Name, department FROM employees WHERE salary < 100000;

