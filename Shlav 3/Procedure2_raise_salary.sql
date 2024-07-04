DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `raise_salary`(IN `branch_id` INT)
BEGIN
    DECLARE avg_salary DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;
    DECLARE worker_id INT;
    DECLARE cur CURSOR FOR
        SELECT w.WorkerID
        FROM worker w
        JOIN salaries s ON w.WorkerID = s.WorkerID
        WHERE w.BranchID = branch_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    --  average salary
    SET avg_salary = avg_branch_salary(branch_id);

    -- If the average salary is under 26000, give a 5% raise to all workers in branch
    IF avg_salary < 26000 THEN
        OPEN cur;

        read_loop: LOOP
            FETCH cur INTO worker_id;
            IF done THEN
                LEAVE read_loop;
            END IF;

            BEGIN
               
                DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
                BEGIN
                   
                END;
                UPDATE salaries SET Net = Net * 1.05 WHERE WorkerID = worker_id;
            END;
        END LOOP;

        CLOSE cur;
    END IF;
END$$
DELIMITER ;