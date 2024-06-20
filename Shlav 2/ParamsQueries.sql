
/*1. Query with a Single Parameter (Branch ID)*/


PREPARE stmt FROM '
SELECT w.WorkerID, w.FirstName, w.LastName, w.Department, w.Rank 
FROM worker w WHERE w.BranchID = ?';

SET @branch_id = 101;
EXECUTE stmt USING @branch_id;
DEALLOCATE PREPARE stmt;


/*2. Query with a List Parameter (Department Names)*/


PREPARE stmt FROM '
SELECT w.Department, COUNT(w.WorkerID) AS TotalWorkers FROM worker w 
WHERE w.Department IN (?, ?, ?) 
GROUP BY w.Department';

SET @dept1 = 'Finance', @dept2 = 'HR', @dept3 = 'IT';
EXECUTE stmt USING @dept1, @dept2, @dept3;
DEALLOCATE PREPARE stmt;


/*3. Query with a Date Parameter*/


PREPARE stmt FROM '
SELECT w.WorkerID, w.FirstName, w.LastName, w.JoinDate 
FROM worker w 
WHERE w.JoinDate > ?';

SET @join_date = '2020-01-01';
EXECUTE stmt USING @join_date;
DEALLOCATE PREPARE stmt;


/*4. Query with a Range of Dates Parameter (Start Date and End Date)*/


PREPARE stmt FROM '
SELECT s.WorkerID, s.LastUpdate, s.Net 
FROM salaries s 
WHERE s.LastUpdate BETWEEN ? AND ?';

SET @start_date = '2023-01-01', @end_date = '2023-12-31';
EXECUTE stmt USING @start_date, @end_date;
DEALLOCATE PREPARE stmt;