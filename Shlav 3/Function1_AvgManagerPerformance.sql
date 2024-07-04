DELIMITER $$
-- Function that calculates the avarage PreformanceRating of managers in specific branch
CREATE FUNCTION AvgManagerPerformance(branch_id INT) 
RETURNS DECIMAL(5,2)
BEGIN
    DECLARE avg_rating DECIMAL(5,2);
    
    SELECT AVG(PreformanceRating) INTO avg_rating 
    FROM manager m
    JOIN worker w ON m.WorkerID = w.WorkerID
    WHERE w.BranchID = branch_id;
    
    RETURN IFNULL(avg_rating, 0);
END$$

DELIMITER ;
