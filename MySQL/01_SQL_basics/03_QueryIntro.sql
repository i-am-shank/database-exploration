SHOW DATABASES; -- list databases
USE org; -- shift execution to our database

-- fetch all entries from a table
SELECT * FROM Worker;

-- fetch a column from a table
SELECT FIRST_NAME FROM Worker;

-- fetch particular columns from a table
SELECT FIRST_NAME, SALARY FROM Worker;

-- SELECT statement use .. without FROM
SELECT (4 * 11); -- can do mathematical operations. MySQL returns output in dummy tables.
SELECT (11 % 4);
SELECT (56 / 7);
SELECT now(); -- fetches current date & time
SELECT ucase("Shashank"); -- converts whole string to upper-case
SELECT lcase("ShashaNK"); -- converts whole string to lower-case