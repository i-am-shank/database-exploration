-- Q: 6

SHOW DATABASES;

-- 1. Create a database called blogdatabase
CREATE DATABASE blogdatabase;
USE blogdatabase;

-- 2. Create a table called user with the following colums:
-- 		id (int)
-- 		name (int) -- This will be updated later
-- 		email (varchar)
-- 		password (varchar)
CREATE TABLE user (
	id INT,
    name INT,
    email VARCHAR(255),
    password VARCHAR(255)
);

-- 3. Update the data type of the name column from int to varchar(50).
ALTER TABLE user MODIFY name VARCHAR(50);

-- 4. Add a new column called isStudent (Boolean) to the user table.
ALTER TABLE user ADD isStudent BOOLEAN;

-- 5. Insert 5 dummy data entries into the user table.
INSERT INTO user VALUES 
	(1, "Archa", "archa@gmail.com", "password_archa", TRUE),
    (2, "Bhadra", "bhadra@gmail.com", "password_bhadra", TRUE),
    (3, "Aditya", "aditya@gmail.com", "password_aditya", TRUE),
    (4, "Shashank", "shashank@gmail.com", "password_shashank", FALSE),
    (5, "Disha", "disha@gmail.com", "password_disha", FALSE)
;

-- 6. Delete all the data from the user table without deleting the table schema
TRUNCATE user;

-- 7. Delete the user table schema
DROP TABLE user;