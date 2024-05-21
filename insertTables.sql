

-- Insert data into Branches table
INSERT ALL
 INTO Branches (BranchID, City, EstablishmentDate, NumberOfWorkers) VALUES (1, 'New York', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 100) 
 INTO Branches (BranchID, City, EstablishmentDate, NumberOfWorkers) VALUES (2, 'Los Angeles', TO_DATE('2021-05-20', 'YYYY-MM-DD'), 150)
SELECT * FROM dual
       
COMMIT;
      

--Insert data into Departments table
INSERT INTO Departments (DepartmentID, Name, NumberOfWorkers)
VALUES (1, 'HR', 50);
COMMIT;
--VALUES(2, 'Engineering', 100);

--Insert data into Worker table
INSERT INTO Worker (WorkerID, FirstName, LastName, JoinDate, PhoneNumber, BranchID, DepartmentID)
VALUES
    (1, 'John', 'Doe', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1234567890, 1, 1);
    COMMIT;


-- Insert data into Salaries table
--INSERT INTO Salaries (WorkerID, Rank, LastUpdate, Gross, Net)
--VALUES
--    (1, 'Junior', TO_DATE('2021-06-01', 'YYYY-MM-DD'), 50000, 40000);
 --   COMMIT;
   -- (2, 'Senior', '2021-07-01', 70000, 56000);

-- Insert data into Clerk table
--INSERT INTO Clerk (WorkerID, DepartmentID, ShiftHours)
--VALUES
 --   (1, 1, 40);
--    COMMIT;
  --  (2, 2, 35);

-- Insert data into Manager table
--INSERT INTO Manager (WorkerID, NumWorkersUHR, PerformanceRating, YearsOfExperience, Education, LevelOfAuthority)
--VALUES
 --   (1, 10, 5, 15, 'MBA', 3);
 --   COMMIT;
  --  (2, 20, 4, 10, 'Bachelor', 2);
