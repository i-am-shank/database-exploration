DROP DATABASE customer_order;

CREATE DATABASE alter_operation_db;
SHOW DATABASES;
USE alter_operation_db;

CREATE TABLE account(
	id INT PRIMARY KEY,
    account_name VARCHAR(255) UNIQUE,
    account_balance INT NOT NULL DEFAULT 0
);

DESCRIBE account;

-- Alter operations *************************************************

-- ADD  (add new column) ---------------------------
ALTER TABLE account ADD interest FLOAT NOT NULL DEFAULT 0;
SELECT * FROM account;

-- MODIFY  (update datatype of attribute) ---------------------------
ALTER TABLE account MODIFY interest DOUBLE NOT NULL DEFAULT 0;
DESCRIBE account;

-- CHANGE COLUMN  (Rename column name)
ALTER TABLE account CHANGE COLUMN interest saving_interest FLOAT NOT NULL DEFAULT 0;
DESCRIBE account;

-- DROP COLUMN  (Drop a column completely)
ALTER TABLE account DROP COLUMN saving_interest;
DESCRIBE account;

-- RENAME TO  (Rename a table)
ALTER TABLE account RENAME TO account_details;
DESCRIBE account_details;

-- ############### SAFE MODE (enable / disable) ###############
SET SQL_SAFE_UPDATES = 1;  -- setting it 0 .. will disable it
-- Just run above command whenever needed. Turning it off from preferences is a bad practice.
