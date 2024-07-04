DELIMITER $$
-- main program that iterate through each branch, check if the average performance rating of managers in the branch is above a
-- a threshold given in the parameter "threshold_rating" and if it is - call the GiveRaise procedure to give raises of "raise_percentage"
-- parameter to the workers in all good departments of that branch - that have manager with rating above 80.
CREATE PROCEDURE MainProgram(threshold_rating DECIMAL(5,2), raise_percentage DECIMAL(5,2))
BEGIN
    DECLARE branch_id INT;
    DECLARE department_name VARCHAR(20);
    DECLARE avg_performance DECIMAL(5,2);
    DECLARE done INT DEFAULT FALSE;

    -- Cursor to iterate through all branches
    DECLARE cur_branches CURSOR FOR 
        SELECT BranchID FROM branches;

    -- Cursor to iterate through all departments in the current branch
    DECLARE cur_departments CURSOR FOR 
        SELECT DepartmentName FROM departments WHERE BranchID = branch_id;

    -- Handler for the cursors
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Exception handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of error
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An error occurred in the main program.';
    END;

    -- Start the transaction
    START TRANSACTION;

    -- Open the branches cursor
    OPEN cur_branches;

    -- Loop through each branch
    branch_loop: LOOP
        FETCH cur_branches INTO branch_id;

        IF done THEN
            SET done = FALSE; -- Reset the flag for the next loop
            LEAVE branch_loop;
        END IF;

        -- Calculate the average performance rating for the current branch
        SET avg_performance = AvgManagerPerformance(branch_id);

        -- Check if the average performance rating is above the threshold
        IF avg_performance > threshold_rating THEN
            -- Open the departments cursor
            OPEN cur_departments;

            -- Loop through each department in the branch
            department_loop: LOOP
                FETCH cur_departments INTO department_name;

                IF done THEN
                    SET done = FALSE; -- Reset the flag for the next loop
                    LEAVE department_loop;
                END IF;

                -- Call the procedure to give raises to eligible workers in the current department
                CALL GiveRaise(branch_id, department_name, raise_percentage);

            END LOOP department_loop;

            -- Close the departments cursor
            CLOSE cur_departments;
        END IF;

    END LOOP branch_loop;

    -- Close the branches cursor
    CLOSE cur_branches;

    -- Commit the transaction
    COMMIT;
END$$

DELIMITER ;
