DELETE FROM customers 
WHERE
    city = 'Lisboa'
    AND customerNumber NOT IN (SELECT 
        customerNumber
    FROM
        payments);