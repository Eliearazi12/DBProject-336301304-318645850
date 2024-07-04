DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `avg_branch_salary`(branch_id INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE avg_salary DECIMAL(10,2);

    SELECT AVG(Net)
    INTO avg_salary
    FROM salaries s
    JOIN worker w ON s.WorkerID = w.WorkerID
    WHERE w.BranchID = branch_id;

    RETURN avg_salary;
END$$
DELIMITER ;