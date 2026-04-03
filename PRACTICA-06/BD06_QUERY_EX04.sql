DELIMITER //
CREATE PROCEDURE delete_employee(IN p_employeeNumber INT)
BEGIN
 DECLARE v_supervisor INT;
 DECLARE v_supervisor_name VARCHAR(100);
 DECLARE v_employee_name VARCHAR(100);
 DECLARE employee_exists INT;
 DECLARE customers_updated INT;
 DECLARE employees_updated INT;

 SELECT COUNT(*) INTO employee_exists
 FROM employees
 WHERE employeeNumber = p_employeeNumber;

 IF employee_exists = 0 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Employee does not exist';
 END IF;

 SELECT reportsTo, CONCAT(firstName, ' ', lastName) INTO v_supervisor, v_employee_name
 FROM employees
 WHERE employeeNumber = p_employeeNumber;

 IF v_supervisor IS NULL THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'The employee is the President and cannot be deleted';
 END IF;

 SELECT CONCAT(firstName, ' ', lastName) INTO v_supervisor_name
 FROM employees
 WHERE employeeNumber = v_supervisor;

 UPDATE customers
 SET salesRepEmployeeNumber = v_supervisor
 WHERE salesRepEmployeeNumber = p_employeeNumber;

 SET customers_updated = ROW_COUNT();

 UPDATE employees
 SET reportsTo = v_supervisor
 WHERE reportsTo = p_employeeNumber;

 SET employees_updated = ROW_COUNT();

 DELETE FROM employees
 WHERE employeeNumber = p_employeeNumber;

 SELECT CONCAT(
 'Customers managed by ', v_employee_name, ' (', p_employeeNumber,
 ') are now managed by ', v_supervisor_name, ' (', v_supervisor, '). ',
 'Employees supervised by ', v_employee_name, ' (', p_employeeNumber,
 ') are now supervised by ', v_supervisor_name, ' (', v_supervisor, '). ',
 '---> ', v_employee_name, ' (', p_employeeNumber, ') deleted successfully!'
 ) AS result_message;
END //
DELIMITER ;

CALL delete_employee(1165);