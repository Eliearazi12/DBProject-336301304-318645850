--view on our original database: give as information on branch
CREATE VIEW BranchOverview AS
SELECT 
    b.BranchID,
    b.City,
    b.EstablishmentDate,
    b.NumberOfWorkers AS TotalWorkersInBranch,
    AVG(s.Net) AS AverageSalary,
    MAX(m.PreformanceRating) AS MaxManagerPerformanceRating,
    AVG(m.PreformanceRating) AS AvgManagerPerformanceRating
FROM 
    branches b
    LEFT JOIN worker w ON b.BranchID = w.BranchID
    LEFT JOIN salaries s ON w.WorkerID = s.WorkerID
    LEFT JOIN manager m ON w.WorkerID = m.WorkerID
GROUP BY 
    b.BranchID;

-- query1: List branches with average salary above a certain threshold (5000) and order by city:
SELECT 
    BranchID, 
    City, 
    AverageSalary
FROM 
    BranchOverview
WHERE 
    AverageSalary > 5000
ORDER BY 
    City;

-- query2: List branches with average manager performance rating above a certain threshold and count of branches in each city
SELECT 
    City, 
    COUNT(BranchID) AS CountOfHighPerformanceBranches
FROM 
    BranchOverview
WHERE 
    AvgManagerPerformanceRating > 80
GROUP BY 
    City;

--view on the other database: give as information on account

CREATE VIEW AccountOverview AS
SELECT 
    a.accountId,
    a.bankId,
    b.bank_name,
    a.class AS AccountClass,
    a.coin AS Currency,
    a.status AS AccountStatus,
    a.balance AS AccountBalance,
    p.firstName AS AccountHolderFirstName,
    p.lastName AS AccountHolderLastName,
    p.email AS AccountHolderEmail,
    e.employeeId AS AccountManagerId,
    e.salary AS AccountManagerSalary
FROM 
    account a
    JOIN bank b ON a.bankId = b.bankId
    JOIN account_of ao ON a.accountId = ao.accountId AND a.bankId = ao.bankId
    JOIN person p ON ao.personID = p.personID
    LEFT JOIN account_manager am ON a.accountId = am.accountId AND a.bankId = am.bankId
    LEFT JOIN employee e ON am.banker_employeeId = e.employeeId;


-- Query 1: List all active accounts with a balance greater than 10,000
SELECT 
    accountId, 
    bank_name, 
    AccountClass, 
    Currency, 
    AccountBalance, 
    AccountHolderFirstName, 
    AccountHolderLastName
FROM 
    AccountOverview
WHERE 
    AccountStatus = 'active' AND 
    AccountBalance > 10000
ORDER BY 
    AccountBalance DESC;

-- Query 2: Find accounts managed by a specific manager and order by account balance
SELECT 
    accountId, 
    bank_name, 
    AccountClass, 
    Currency, 
    AccountBalance, 
    AccountHolderFirstName, 
    AccountHolderLastName, 
    AccountManagerId
FROM 
    AccountOverview
WHERE 
    AccountManagerId = 101
ORDER BY 
    AccountBalance ASC;