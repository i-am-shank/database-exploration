SHOW DATABASES;

CREATE DATABASE set_operation_db;
USE set_operation_db;

CREATE TABLE Dept1 (
	empId INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(255)
);

INSERT INTO Dept1 VALUES 
	(1, "A", "engineer"),
    (2, "B", "salesman"),
    (3, "C", "manager"),
    (4, "D", "salesman"),
    (5, "E", "engineer")
;

CREATE TABLE Dept2 (
	empId INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(255)
);

INSERT INTO Dept2 VALUES
	(3, "C", "manager"),
    (6, "F", "marketing"),
    (7, "G", "salesman")
;

-- SET operations :-
-- 		1. UNION
-- 		2. INTERSECT
-- 		3. MINUS

-- ######################    UNION    #######################
-- List out all employees in the company
SELECT * FROM Dept1
UNION
SELECT * FROM Dept2;

-- List out all the employees in all departments who work as salesman
SELECT * FROM Dept1 WHERE role = "salesman"
UNION
SELECT * FROM Dept2 WHERE role = "salesman";


-- ######################    INTERSECT    ######################
-- List out all the employees who work for both the departments
SELECT Dept1.* FROM Dept1 INNER JOIN Dept2 USING(empId);


-- ######################    MINUS    ######################
-- List out all the employees working in Dept1, but not in Dept2
SELECT Dept1.* FROM Dept1 LEFT JOIN Dept2 ON Dept1.empId = Dept2.empId WHERE Dept2.empId IS NULL;

