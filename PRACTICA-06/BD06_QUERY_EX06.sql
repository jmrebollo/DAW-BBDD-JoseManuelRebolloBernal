DELIMITER //
CREATE FUNCTION customer_summary(p_customerNumber INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
 DECLARE order_count INT;
 DECLARE product_count INT;
 DECLARE summary_text VARCHAR(255);

 SELECT COUNT(DISTINCT orderNumber) INTO order_count
 FROM orders
 WHERE customerNumber = p_customerNumber;

 SELECT COUNT(DISTINCT productCode) INTO product_count
 FROM orders o
 JOIN orderdetails od ON o.orderNumber = od.orderNumber
 WHERE o.customerNumber = p_customerNumber;

 IF order_count = 0 OR product_count = 0 THEN
 SET summary_text = 'No orders or products';
 ELSE
 -- Retornar string con resumen
 SET summary_text = CONCAT(order_count, ' order/s and ', product_count, ' product/s');
 END IF;

 RETURN summary_text;
END //
DELIMITER ;

SELECT customer_summary(999);