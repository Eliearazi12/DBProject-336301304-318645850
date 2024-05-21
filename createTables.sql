
CREATE TABLE Branches(
  BranchID INTEGER PRIMARY KEY,
  City VARCHAR(20),
  EstablishmentDate DATE,
  NumberOfWorkers INTEGER
  );
  
  CREATE TABLE Departments(
  DepartmentID INTEGER PRIMARY KEY,
  NumberOfWorkers INTEGER NOT NULL,
  Name VARCHAR(20)
  );

CREATE TABLE Worker (
    WorkerID INTEGER PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    JoinDate DATE,
    PhoneNumber INTEGER,
    BranchID INTEGER,
    DepartmentID INTEGER,
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Salaries (
    ID INTEGER PRIMARY KEY,
    WorkerID INTEGER,
    Rank VARCHAR(20) DEFAULT 'Junior',
    LastUpdate DATE,
    Gross INTEGER,
    Net INTEGER,
    FOREIGN KEY (WorkerID) REFERENCES Worker(WorkerID)
);






CREATE TABLE Clerk (
    ID INTEGER PRIMARY KEY,
    WorkerID INTEGER,
    DepartmentID INTEGER,
    ShiftHours INTEGER,
    FOREIGN KEY (WorkerID) REFERENCES Worker(WorkerID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Manager (
    ID INTEGER PRIMARY KEY,
    WorkerID INTEGER,
    NumWorkersUHR INTEGER,
    PerformanceRating INTEGER,
    YearsOfExperience INTEGER,
    Education VARCHAR(20) DEFAULT 'High School',
    LevelOfAuthority INTEGER,
    FOREIGN KEY (WorkerID) REFERENCES Worker(WorkerID)
);
