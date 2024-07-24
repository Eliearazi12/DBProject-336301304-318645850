-- Create the account table
CREATE TABLE `account` (
 `AccountID` int(11) NOT NULL AUTO_INCREMENT,
 `balance` decimal(10,2) NOT NULL,
 `status` varchar(20) NOT NULL,
 `class` varchar(20) NOT NULL,
 `coin` varchar(10) NOT NULL,
 `BranchID` int(11) NOT NULL,
 PRIMARY KEY (`AccountID`),
 KEY `BranchID` (`BranchID`),
 CONSTRAINT `account_ibfk_1` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create the transaction table
CREATE TABLE `transaction` (
 `transactionID` int(11) NOT NULL AUTO_INCREMENT,
 `GiverBranchID` int(11) NOT NULL,
 `ReceiverBranchID` int(11) NOT NULL,
 `GiverAccountID` int(11) NOT NULL,
 `ReceiverAccountID` int(11) NOT NULL,
 `amount` decimal(10,2) NOT NULL,
 `Date` date NOT NULL,
 `Coin` varchar(10) NOT NULL,
 `amountOfPayments` int(11) NOT NULL,
 PRIMARY KEY (`transactionID`),
 KEY `GiverBranchID` (`GiverBranchID`),
 KEY `ReceiverBranchID` (`ReceiverBranchID`),
 KEY `GiverAccountID` (`GiverAccountID`),
 KEY `ReceiverAccountID` (`ReceiverAccountID`),
 CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`GiverBranchID`) REFERENCES `branches` (`BranchID`),
 CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`ReceiverBranchID`) REFERENCES `branches` (`BranchID`),
 CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`GiverAccountID`) REFERENCES `account` (`AccountID`),
 CONSTRAINT `transaction_ibfk_4` FOREIGN KEY (`ReceiverAccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create the creditcard table
CREATE TABLE `creditcard` (
 `CardNumber` varchar(16) NOT NULL,
 `ExpiryDate` date NOT NULL,
 `3SecretDigits` varchar(3) NOT NULL,
 `BranchID` int(11) NOT NULL,
 `AccountID` int(11) NOT NULL,
 PRIMARY KEY (`CardNumber`),
 KEY `BranchID` (`BranchID`),
 KEY `AccountID` (`AccountID`),
 CONSTRAINT `creditcard_ibfk_1` FOREIGN KEY (`BranchID`) REFERENCES `branches` (`BranchID`),
 CONSTRAINT `creditcard_ibfk_2` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create the banker table
CREATE TABLE `banker` (
 `WorkerID` int(11) NOT NULL,
 PRIMARY KEY (`WorkerID`),
 CONSTRAINT `banker_ibfk_1` FOREIGN KEY (`WorkerID`) REFERENCES `worker` (`WorkerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create the person table
CREATE TABLE `person` (
 `PersonID` int(11) NOT NULL AUTO_INCREMENT,
 `firstName` varchar(20) NOT NULL,
 `lastName` varchar(20) NOT NULL,
 `date_of_birth` date NOT NULL,
 `address` varchar(100) NOT NULL,
 `phoneNumber` varchar(15) NOT NULL,
 `email` varchar(50) NOT NULL,
 PRIMARY KEY (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Add the BranchName column to the branches table
ALTER TABLE `branches`
ADD COLUMN `BranchName` varchar(50);

-- Update the BranchName column with the Bank Name data
UPDATE workersandsalaries.branches b
JOIN integrationstep4.bank k ON b.BranchID = k.bankId
SET b.BranchName = k.bank_name;

-- insert the new data:


-- Insert data from integrationstep4.person to workersandsalaries.person
INSERT INTO workersandsalaries.person (firstName, lastName, DateOfBirth, address, phoneNumber, email)
SELECT firstName, lastName, date_of_birth, address, phone_number, email
FROM integrationstep4.person;

-- Insert data from integrationstep4.account to workersandsalaries.account
INSERT INTO workersandsalaries.account (AccountID, balance, status, class, coin, BranchID)
SELECT accountId, balance, status, class, coin, bankid
FROM integrationstep4.account;

-- Insert data from integrationstep4.transaction to workersandsalaries.transaction
INSERT INTO workersandsalaries.transaction (GiverBranchID, ReceiverBranchID, GiverAccountID, ReceiverAccountID, amount, Date, Coin, amountOfPayments)
SELECT giver_bankId , receiver_bankId , giver_accountId , receiver_accountId, amount, Date, Coin, amount_of_payments
FROM integrationstep4.transaction;

-- Insert data from integrationstep4.creditcard to workersandsalaries.creditcard
INSERT INTO workersandsalaries.creditcard (CardNumber, ExpiryDate, 3SecretDigits, BranchID, AccountID)
SELECT card_number, expiry_date , secret_digits , bankId , accountId 
FROM integrationstep4.credit_cards;

-- Insert data from integrationstep4.banker to workersandsalaries.banker
INSERT INTO workersandsalaries.banker (WorkerID)
SELECT employeeId 
FROM integrationstep4.banker;
