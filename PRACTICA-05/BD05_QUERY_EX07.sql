DELETE FROM payments 
WHERE
    customerNumber IN (SELECT 
        customerNumber
    FROM
        customers
    
    WHERE
        salesRepEmployeeNumber IN (SELECT 
            employeeNumber
        FROM
            employees
        
        WHERE
            lastName = 'Patterson'));