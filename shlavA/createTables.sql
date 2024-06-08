
CREATE TABLE `branches` (
 `BranchID` int(11) NOT NULL AUTO_INCREMENT,
 `City` varchar(20) NOT NULL,
 `EstablishmentDate` date NOT NULL,
 `NumberOfWorkers` int(11) NOT NULL,
 PRIMARY KEY (`BranchID`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `departments` (
 `DepartmentName` varchar(20) NOT NULL,
 `BranchID` int(11) NOT NULL,
 `NumberOfWorkers` int(11) NOT NULL,
 PRIMARY KEY (`DepartmentName`,`BranchID`),
 KEY `BranchID` (`BranchID`),
 CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `worker` (
 `WorkerID` int(11) NOT NULL AUTO_INCREMENT,
 `FirstName` varchar(20) NOT NULL,
 `LastName` varchar(20) NOT NULL,
 `JoinDate` date NOT NULL,
 `PhoneNumber` int(11) NOT NULL,
 `BranchID` int(11) NOT NULL,
 `Department` varchar(20) NOT NULL,
 `Rank` varchar(20) NOT NULL DEFAULT 'Junior',
 PRIMARY KEY (`WorkerID`)
) ENGINE=InnoDB AUTO_INCREMENT=43571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `salaries` (
 `WorkerID` int(11) NOT NULL,
 `LastUpdate` date NOT NULL,
 `Net` int(11) NOT NULL,
 PRIMARY KEY (`WorkerID`),
 CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`WorkerID`) REFERENCES `worker` (`WorkerID`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `manager` (
 `WorkerID` int(11) NOT NULL,
 `NumWorkersUHR` int(11) NOT NULL,
 `PreformanceRating` int(11) NOT NULL,
 `YearsOfExperience` int(11) NOT NULL,
 `Education` varchar(50) NOT NULL,
 `LevelOfAuthority` varchar(50) NOT NULL,
 PRIMARY KEY (`WorkerID`),
 CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`WorkerID`) REFERENCES `worker` (`WorkerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `clerk` (
 `WorkerID` int(11) NOT NULL,
 `Department` varchar(20) NOT NULL,
 `BranchID` int(11) NOT NULL,
 `ShiftHours` int(11) NOT NULL,
 KEY `WorkerID` (`WorkerID`),
 KEY `BranchID` (`BranchID`),
 KEY `Department` (`Department`),
 CONSTRAINT `clerk_ibfk_1` FOREIGN KEY (`WorkerID`) REFERENCES `worker` (`WorkerID`),
 CONSTRAINT `clerk_ibfk_2` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`),
 CONSTRAINT `clerk_ibfk_3` FOREIGN KEY (`Department`) REFERENCES `departments` (`DepartmentName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  