UPDATE products 
SET 
    productName = CONCAT(productName, ' (code ', productCode, ')')
WHERE
    productLine = 'Trains';