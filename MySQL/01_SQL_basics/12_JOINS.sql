CREATE DATABASE project_employee_client;
USE project_employee_client;

-- ##-##-##-##-##-##-##-#######   JOINS IN SQL   #######-##-##-##-##-##-##-##
-- INNER JOIN
		-- Intersection
-- OUTER JOIN
		-- LEFT JOIN
        -- RIGHT JOIN
        -- FULL JOIN
-- CROSS JOIN

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

DESCRIBE Employee;
DESCRIBE Project;

SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Client;

-- ###################### INNER JOIN ########################
-- Fetch Employee ID, Employee names, Project ID, Project names.. on which they are working on.
SELECT e.id, e.fname, e.lname, p.id, p.name FROM Employee AS e INNER JOIN Project AS p ON e.id = p.empID;

-- INNER JOIN without JOIN keyboard   ( INNER JOIN  -->  , )   +   ( ON  -->  WHERE )
SELECT e.id, e.fname, e.lname, p.id, p.name FROM Employee AS e , Project AS p WHERE e.id = p.empID;

-- Fetch all Employee ID, & their contact details .. working from Jaipur with clients in Hyderabad.
SELECT e.id, e.fname, e.lname, e.emailID, e.PhoneNo FROM Employee AS e INNER JOIN Client AS c ON e.id = c.empID 
WHERE e.City = "Jaipur" AND c.City = "Hyderabad";


-- ###################### LEFT JOIN ########################
-- Fetch out each employee details, & projects allocated to them.
SELECT * FROM Employee LEFT JOIN Project ON Employee.id = Project.empID;


-- ###################### RIGHT JOIN ########################
-- List out all the Project names, along with Employee names & their respective email ids.
SELECT p.id, p.name, e.fname, e.lname, e.emailID FROM Project AS p RIGHT JOIN Employee AS e ON p.empID = e.id;


-- ###################### CROSS JOIN ########################
-- List out all the possible combinations of Employee names & Project names.
SELECT e.fname, e.lname, p.name FROM Employee AS e CROSS JOIN Project AS p;


-- Free space (of database) in the end
DROP DATABASE project_employee_client;