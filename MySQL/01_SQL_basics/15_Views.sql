SHOW DATABASES;
CREATE DATABASE view_db;

USE view_db;

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

DESCRIBE Employee;

-- Let's say, we want customers to be able to see only Employees First name, last name & email id, & only those employees who are in Delhi, Kolkata & Jaipur.
-- ################    Creating VIEW    ################
CREATE VIEW Customer_view AS SELECT fname, lname, emailID FROM Employee WHERE City IN ("Delhi", "Kolkata", "Jaipur");

-- View behaves similar as table. We can query over it like a table.
SELECT * FROM Customer_view;

-- #################    Updating the View    #################
ALTER VIEW Customer_view AS SELECT CONCAT(fname, " ", lname) AS Name, emailID FROM Employee WHERE City IN ("Delhi", "Kolkata", "Jaipur");

SELECT * FROM Customer_view;

-- #################    Dropping the View    #################
DROP VIEW Customer_view;
