-- ===================================================================
-- 03_Database_SQL_Fundamentals: Sample Queries
-- ===================================================================
-- SQL commands used to initialize and interact with the AWS RDS instance.
-- Skills: DDL (CREATE), DML (INSERT, UPDATE), DQL (SELECT)
-- ===================================================================

-- -------------------------------------------------------------------
-- SECTION 1: DATABASE DEFINITION (DDL)
-- -------------------------------------------------------------------

-- Create database
CREATE DATABASE IF NOT EXISTS auroro_db;

-- Select database
USE auroro_db; 

-- Create students table
CREATE TABLE students ( 
    subject_id INT AUTO_INCREMENT, 
    subject_name VARCHAR(255) NOT NULL, 
    teacher VARCHAR(255), 
    start_date DATE, 
    lesson TEXT, 
    PRIMARY KEY (subject_id)
);

-- -------------------------------------------------------------------
-- SECTION 2: DATA MANIPULATION (DML)
-- -------------------------------------------------------------------

-- Insert records
INSERT INTO students (subject_name, teacher) 
VALUES 
('English', 'John Taylor'), 
('Science', 'Mary Smith'), 
('Maths', 'Ted Miller'), 
('Arts', 'Suzan Carpenter');

-- Update record
UPDATE students
SET start_date = CURDATE()
WHERE subject_name = 'English';

-- -------------------------------------------------------------------
-- SECTION 3: DATA QUERY (DQL)
-- -------------------------------------------------------------------

-- Retrieve all data
SELECT * FROM students;

-- Retrieve specific columns sorted by teacher
SELECT 
    subject_name, 
    teacher
FROM students
ORDER BY teacher ASC;