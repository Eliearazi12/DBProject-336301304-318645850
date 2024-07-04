DELIMITER $$
-- Procedure that gives raise in salary to all workers who works in the department 
-- only if the manager have more then 80 PreformanceRating in the specifice department 
CREATE PROCEDURE GiveRaise(branch_id INT, department_name VARCHAR(20), raise_percentage DECIMAL(5,2))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE worker_id INT;
    DECLARE new_salary INT;
    DECLARE cur CURSOR FOR 
        SELECT w.WorkerID, s.Net 
        FROM worker w
        JOIN salaries s ON w.WorkerID = s.WorkerID
        WHERE w.BranchID = branch_id AND w.Department = department_name 
        AND w.Department IN (SELECT Department FROM manager m JOIN worker w ON m.WorkerID = w.WorkerID WHERE PerformanceRating > 80);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Exception handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	    -- Rollback the actions when Exception is caught
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An error occurred while giving raises.';
    END;
	
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO worker_id, new_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate new salary
        SET new_salary = new_salary + (new_salary * raise_percentage / 100);
        
        -- Update the salary
        UPDATE salaries 
        SET Net = new_salary 
        WHERE WorkerID = worker_id;
    END LOOP;
    
    CLOSE cur;
    
    COMMIT;
END$$

DELIMITER ;
