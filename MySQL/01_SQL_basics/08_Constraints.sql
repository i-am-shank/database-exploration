CREATE DATABASE customer_order;
SHOW DATABASES;

USE customer_order;
SHOW TABLES;

-- Table definition with Primary key declaration -------------
CREATE TABLE Customer (
	id INT PRIMARY KEY,
    cname VARCHAR(225),
    address VARCHAR(225),
    gender CHAR(2),
    city VARCHAR(225),
    pincode INT
);

-- Insert values into a table -------------
INSERT INTO Customer VALUES
	(1251,  "Ram Kumar",  "Dilbagh Nagar",  "M",  "Jalandhar",  144002),
    (1300,  "Shayam Singh",  "Ludhiana H.O",  "M",  "Ludhiana",  141001),
    (245,  "Neelabh Shukla",  "Ashok Nagar",  "M",  "Jalandhar",  144003),
    (210,  "Barkha Singh",  "Dilbagh Nagar",  "F",  "Jalandhar",  144002),
    (500,  "Rohan Arora",  "Ludhiana H.O",  "M",  "Ludhiana",  141001)
;

-- Insert additional values to a table (same syntax) --------------
INSERT INTO Customer VALUES
	(1262,  "Ram Kumar3",  "Dilbagh Nagar",  "M",  "Jalandhar",  NULL)
;

-- Table definition with Primary Key & Foreign Key --------------
CREATE TABLE Order_details (
	order_id INT,
    delivery_date DATE,
    cust_id INT,
    PRIMARY KEY(order_id), -- another syntax of P.K. definition
    FOREIGN KEY(cust_id) REFERENCES Customer(id) ON DELETE CASCADE
);

-- insert values to this 2nd table
INSERT INTO Order_details VALUES
	(1, "2019-03-11", 245),
    (2, "2018-04-12", 210)
;

TRUNCATE Order_details;

DELETE FROM Customer WHERE id = 210;

SELECT * FROM Customer;

-- UNIQUE, CHECK & DEFAULT --------------
CREATE TABLE account(
	id INT PRIMARY KEY,
    account_name VARCHAR(255) UNIQUE,
    account_balance INT DEFAULT 5000,
    CONSTRAINT balance_check CHECK(account_balance > 1000)
);

DROP TABLE account;

-- Insert operations to check if constraints applied
INSERT INTO account (id, account_name, account_balance) VALUES
	(1, "A", 10000)
;
-- Insert operation to check if DEFAULT applied
INSERT INTO account (id, account_name) VALUES 
	(2, "B")
;
-- Trying to insert a duplicate account_name now  -->  throws error
INSERT INTO account VALUES
	(2, "A", 20000)
;
-- Trying to insert a invalid CHECK attribute-value  -->  throws error
INSERT INTO account VALUES
	(2, "C", 500)
;
-- Now trying to insert a valid attribute  -->  will be successfully inserted
INSERT INTO account VALUES
	(2, "B", 2000)
;

