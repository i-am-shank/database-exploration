-- to show all the existing databases
SHOW DATABASES;

-- create a database 
CREATE DATABASE temp;

-- to tell MySQL to use a particular database 
USE temp;

-- create a table (with attributes, it's types & primary key specified)
CREATE TABLE student (
id INT PRIMARY KEY,
name VARCHAR(255)
);

-- insert any data into a table
INSERT INTO student VALUES (1, "Adi");

-- fetching all data
SELECT * FROM student;

-- deleting a database, along with checking it's existence
DROP DATABASE IF EXISTS temp;
