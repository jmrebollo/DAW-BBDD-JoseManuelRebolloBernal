SET SQL_SAFE_UPDATES = 0;

UPDATE orders 
SET 
    `status` = 'Cancelled',
    shippedDate = CURDATE(),
    comments = 'Order cancelled due to delay'
WHERE
    orderDate = '2003-09-28';