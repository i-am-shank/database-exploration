SHOW DATABASES;

CREATE DATABASE HealthTrack;
USE HealthTrack;

CREATE TABLE patients (
	visit_id INT PRIMARY KEY,
    patient_id INT,
    patient_name VARCHAR(255),
    age INT,
    gender VARCHAR(255),
    visit_date DATE,
    treatment VARCHAR(255),
    cost INT,
    doctor VARCHAR(255)
);

