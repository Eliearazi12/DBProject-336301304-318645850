DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_all_branches`()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE branch_id INT;
    DECLARE cur CURSOR FOR SELECT BranchID FROM branches;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO branch_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                
            END;
           
            CALL raise_salary(branch_id);
        END;
    END LOOP;

    CLOSE cur;
END$$
DELIMITER ;