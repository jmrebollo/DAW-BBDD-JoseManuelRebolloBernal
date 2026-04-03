DELIMITER //
CREATE PROCEDURE customers_sales_report(
    IN office_name VARCHAR(50),
    IN year_param INT,
    OUT sales_report LONGTEXT)
BEGIN
    SELECT 
        CONCAT(e.firstName, ' ', e.lastName) as employee,
        c.customerName as customer,
        ROUND(SUM(od.quantityOrdered * od.priceEach), 2) as total_sales
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN customers c ON o.customerNumber = c.customerNumber
    JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
    JOIN offices f ON e.officeCode = f.officeCode
    WHERE f.city = office_name
    AND YEAR(o.orderDate) = year_param
    GROUP BY e.employeeNumber, c.customerNumber;
END //
DELIMITER ;

CALL customers_sales_report('London', 2005, @report);
SELECT @report;