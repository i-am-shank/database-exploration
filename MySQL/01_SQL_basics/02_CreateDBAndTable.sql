CREATE DATABASE org; -- an organisation database

-- Check if database is created or not
SHOW DATABASES;

-- 3 tables will be there :-
-- 		1. Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
-- 		2. Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
-- 		3. Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM)

-- shift execution to our database
USE org;

-- Creating Worker table :-   (also defining Primary-key)
CREATE TABLE IF NOT EXISTS Worker(
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

-- Insert data into worker table :-
INSERT INTO Worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Archa', '', 1200000, '01-08-22 09.00.00', 'Frontend'),
        (002, 'Bhadra', 'Kombala', 1000000, '01-08-23 09.00.00', 'UI UX'),
        (003, 'Shashank', 'Sinha', 1300000, '01-08-21 09.00.00', 'Backend'),
        (004, 'Aditya', 'Sinha', 1000000, '01-08-22 09.00.00', 'Data');

SELECT * FROM Worker; -- Shows all entries in this table
DESCRIBE Worker; -- Shows the schema of this table

-- Creating Bonus table :-   (also defining Foreign-key & Referential constraints)
CREATE TABLE IF NOT EXISTS Bonus(
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
        -- this will ensure, if Worker table deletes this WORKER_ID, all it's corresponding rows in Bonus are also deleted.
);

-- Insert data into Bonus table :-
INSERT INTO Bonus
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '01-01-23'),
        (002, 4000, '01-01-24'),
        (003, 1000, '01-01-22'),
        (004, 3000, '01-01-23');
        
SELECT * FROM Bonus; -- Show all entries in Bonus table
DESCRIBE Bonus; -- Describe schema of Bonus table

-- Creating Title table :-   (Also defining Foreign-key .. & Referential constraints)
CREATE TABLE IF NOT EXISTS Title(
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
		-- Another option is => ON DELETE NULL  -->  updates all entries of WORKER_REF_ID to NULL, which are deleted from Worker
);

-- Insert data into Title table :-
INSERT INTO Title
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
		(001, 'Developer', '2022-04-01 00:00:00'),
        (002, 'Designer', '2024-04-01 00:00:00'),
        (003, 'Developer', '2022-04-01 00:00:00'),
        (004, 'Analyst', '2024-04-01 00:00:00');

SELECT * FROM Title;
DESCRIBE Title;