

/* SELECT Queries*/

/*1.Query to find the highest-ranking manager with the highest experience and rating and show their branch details:*/
   
   SELECT m.WorkerID, w.FirstName, w.LastName, w.Rank, b.BranchID, b.City, b.EstablishmentDate
   FROM manager m
   JOIN worker w ON m.WorkerID = w.WorkerID
   JOIN branches b ON w.BranchID = b.BranchID
   WHERE w.Rank = 'Director'
   ORDER BY m.YearsOfExperience DESC, m.PreformanceRating DESC
   LIMIT 1;
   

/*2. Query to get the total number of workers in each department for branches established after 2010:*/
   
   SELECT d.DepartmentName, b.City, COUNT(w.WorkerID) AS TotalWorkers
   FROM departments d
   JOIN branches b ON d.BranchID = b.BranchID
   JOIN worker w ON d.DepartmentName = w.Department AND d.BranchID = w.BranchID
   WHERE YEAR(b.EstablishmentDate) > 2010
   GROUP BY d.DepartmentName, b.City
   ORDER BY TotalWorkers DESC;
   

/*3. Query to find the average salary per department, including only departments with more than 5 workers:*/
   
   SELECT w.Department, AVG(s.Net) AS AverageSalary
   FROM worker w
   JOIN salaries s ON w.WorkerID = s.WorkerID
   GROUP BY w.Department
   HAVING COUNT(w.WorkerID) > 5
   ORDER BY AverageSalary DESC;
   

/*4. Query to find the details of all Senior Rank clerks 
who work in a specific city (Ashkelon) and have shifts greater than 30 hours per week:*/
   
   SELECT c.WorkerID, w.FirstName, w.LastName, w.Rank, c.ShiftHoursPW,b.BranchID, b.City
   FROM clerk c
   JOIN worker w ON c.WorkerID = w.WorkerID
   JOIN branches b ON c.BranchID = b.BranchID
   WHERE b.city = 'Ashkelon' AND w.Rank = 'Senior' AND c.ShiftHoursPW > 30;
   

/* DELETE Queries*/

/*1. delete all workers that are ranked junior in the finance department in Lod*/
   
   DELETE w
   FROM worker w
   JOIN branches b ON w.BranchID = b.BranchID
   WHERE w.Rank = 'Junior' AND w.Department = 'Sales' AND b.City = 'Lod';
   

/*2. delete all workers with High School diploma and a ranking below 30:*/
   
   DELETE FROM manager
   WHERE Education = 'High School Diploma' AND PreformanceRating < 30;
   

/* UPDATE Queries*/

/*1.Promote all Junior workers who have been in the company for more than 5 years to Senior:*/
   
 UPDATE worker
   SET Rank = 'Senior'
   WHERE Rank = 'Junior' AND DATEDIFF(CURDATE(), JoinDate) > 5 * 365;


/*2. add 10% to the salaries of the directors of jerusalem branches*/
   
  
   UPDATE salaries s
   JOIN worker w ON s.WorkerID = w.WorkerID
   SET s.Net = s.Net * 1.10
   WHERE w.Rank = 'Director' AND w.BranchID IN (
    SELECT BranchID
    FROM branches
    WHERE City = 'Jerusalem'
);