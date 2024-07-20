SHOW DATABASES;

CREATE DATABASE sub_query_db;
USE sub_query_db;

CREATE TABLE Employee (
	id INT NOT NULL PRIMARY KEY,
    fname VARCHAR(255),
    lname VARCHAR(255),
    Age INT,
    emailID VARCHAR(255),
    PhoneNo BIGINT,
    City VARCHAR(255)
);

INSERT INTO Employee VALUES 
	(1, "Aman", "Proto", 32, "aman@gmail.com", 898, "Delhi"),
    (2, "Yagya", "Narayan", 44, "yagya@gmail.com", 222, "Palam"),
    (3, "Rahul", "BD", 22, "rahul@gmail.com", 444, "Kolkata"),
    (4, "Jatin", "Hermit", 31, "jatin@gmail.com", 666, "Raipur"),
    (5, "PK", "Pandey", 21, "pk@gmail.com", 555, "Jaipur")
;

CREATE TABLE Project (
	id INT NOT NULL PRIMARY KEY,
    empID INT,
    FOREIGN KEY(empID) REFERENCES Employee(id),
    name VARCHAR(255),
    startdate DATE,
    clientID int
);

INSERT INTO Project VALUES 
	(1, 1, "A", "2021-04-21", 3),
    (2, 2, "B", "2021-03-12", 1),
    (3, 3, "C", "2021-01-16", 5),
    (4, 3, "D", "2021-04-27", 2),
    (5, 5, "E", "2021-05-01", 4)
;

CREATE TABLE Client (
	id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    age INT,
    emailID VARCHAR(255),
    PhoneNo BIGINT,
    City VARCHAR(255),
    empID INT,
    FOREIGN KEY(empID) REFERENCES Employee(id)
);

INSERT INTO Client VALUES 
	(1, "Mac", "Rogers", 47, "mac@hotmail.com", 333, "Kolkata", 3),
    (2, "Max", "Poirier", 27, "max@gmail.com", 222, "Kolkata", 3),
    (3, "Peter", "Jain", 24, "peter@abc.com", 111, "Delhi", 1),
    (4, "Sushant", "Aggarwal", 23, "sushant@yahoo.com", 45454, "Hyderabad", 5),
    (5, "Pratap", "Singh", 36, "p@xyz.com", 77767, "Mumbai", 2)
;

-- #####################     Sub-Queries     ####################

-- -------------------   Inside a WHERE clause   ----------------------

-- Fetch employee data, whose age are > 30
SELECT * FROM Employee WHERE age in (SELECT age FROM Employee WHERE age > 30);
-- Fetch employee details of employee working in more than 1 project
--    ====>   fetch empId of employees working on multiple projects. Then extract details from Employee.
SELECT * FROM Employee WHERE id in (SELECT empId FROM Project GROUP BY empId HAVING COUNT(empId) > 1);
-- Fetch employees, whose age is more than average age of all employees
SELECT * FROM Employee WHERE age > (SELECT AVG(age) FROM Employee);  -- 30 is avg age

-- -------------------   Inside a FROM clause   -----------------------

-- Fetch maximum age of employee, having "a" in first name
SELECT MAX(Age) FROM (SELECT * FROM Employee WHERE fname LIKE "%a%");


-- #######################    Co-related Sub-queries    ########################

-- Fetch the 3rd oldest employee
SELECT * FROM Employee AS e1 WHERE (SELECT COUNT(e2.age) FROM Employee AS e2 WHERE e1.age<=e2.age) = 3;
-- nested query calculates count of employee, whose age is >= current employee's age of external query
-- outer query will run on all the employees
-- So, it will check for each employee, the count of employees with age >= them. If it is 3, then current employee is 3rd oldest.


-- freeing memory (by erasing db)
DROP DATABASE sub_query_db;
