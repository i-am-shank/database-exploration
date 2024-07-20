SHOW DATABASES;

CREATE DATABASE DML_db;
USE DML_db;

CREATE TABLE Customer (
	id INT PRIMARY KEY,
    cname VARCHAR(225),
    address VARCHAR(225),
    gender CHAR(2),
    city VARCHAR(225),
    pincode INT
);

-- ################  DML - Commands  ################
-- 1. INSERT  (Insert data to table)
-- 2. UPDATE  (Update some rows of a table)
-- 3. DELETE  (Delete some rows of a table)  -->  ON DELETE CASCADE , ON DELETE SET NULL  (F.K. definition)
-- 4. REPLACE

-- INSERT  (Insert data into table) ----------------------------------
-- >   2 different syntax :-
-- !!!!  Syntax - 1  !!!!     -->     enter all attributes in order
INSERT INTO Customer VALUES 
	(1251,  "Ram Kumar",  "Dilbagh Nagar",  "M",  "Jalandhar",  144002),
    (1300,  "Shayam Singh",  "Ludhiana H.O",  "M",  "Ludhiana",  141001)
;
-- !!!!  Syntax - 2  !!!!     -->     enter only specified attributes (all attributes here)
INSERT INTO Customer (id, cname, address, gender, city, pincode) VALUES
	(245,  "Neelabh Shukla",  "Ashok Nagar",  "M",  "Jalandhar",  144003),
    (210,  "Barkha Singh",  "Dilbagh Nagar",  "F",  "Jalandhar",  144002)
;
-- !!!!  Syntax - 3  !!!!     -->     enter only specified attributes (other become NULL)
INSERT INTO Customer (id, cname, address) VALUES
	(500,  "Rohan Arora",  "Ludhiana H.O")
;
SELECT * FROM Customer;

-- UPDATE - SET  (Update some rows of columns specified) ----------------------------------
UPDATE Customer SET city = "Ludhiyana" WHERE id = 500;
SELECT * FROM Customer;
-- For Updating all rows, exclude where (also turn off safe-mode for this)
SET SQL_SAFE_UPDATES = 0;
UPDATE Customer SET pincode = 800008;
SET SQL_SAFE_UPDATES = 1; -- restoring MySQL safety-settings
SELECT * FROM Customer; -- check updates in all rows (of pincode column)

-- DELETE  (Delete some rows of a table) ----------------------------------
DELETE FROM Customer WHERE id = 500;
SELECT * FROM Customer;

