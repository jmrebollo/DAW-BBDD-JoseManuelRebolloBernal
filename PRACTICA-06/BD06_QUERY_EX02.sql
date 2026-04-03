DELIMITER //
CREATE TRIGGER check_max_active_orders_before_insert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
 DECLARE active_order_count INT;

 SELECT COUNT(*) INTO active_order_count
 FROM orders
 WHERE customerNumber = NEW.customerNumber
 AND status IN ('In Process', 'On Hold', 'Shipped');

 IF active_order_count >= 3 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'A customer cannot have more than 3 active orders';
 END IF;
END //
DELIMITER ;

INSERT INTO orders 
(orderNumber, orderDate, requiredDate, shippedDate, `status`, comments, customerNumber)
VALUES 
(99999, '2026-04-03', '2026-04-03', '2026-04-03', 'Shipped', 'No', '103');