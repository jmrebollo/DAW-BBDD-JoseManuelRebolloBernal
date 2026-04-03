DELIMITER //
CREATE TRIGGER check_single_sales_manager_before_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
 DECLARE sales_manager_count INT;

 SELECT COUNT(*) INTO sales_manager_count
 FROM employees
 WHERE officeCode = NEW.officeCode
 AND jobTitle LIKE '%Sales Manager%';

 IF sales_manager_count > 0 AND NEW.jobTitle LIKE '%Sales Manager%' THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Only one Sales Manager is allowed per office';
 END IF;
END //
DELIMITER ;

INSERT INTO employees 
(employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES 
(9999, 'TestLast', 'TestFirst', 'x9999', 'test@test.com', '1', 1002, 'Sales Manager');