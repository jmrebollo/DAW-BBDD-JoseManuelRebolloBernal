DELIMITER //
CREATE TRIGGER check_product_stock_before_insert
BEFORE INSERT ON orderdetails
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    
    SELECT quantityInStock INTO available_stock
    FROM products
    WHERE productCode = NEW.productCode;
    
    IF available_stock <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock to fulfill the order';
    END IF;
    
    IF NEW.quantityOrdered > available_stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The product must be in stock to place an order';
    END IF;
END //
DELIMITER ;


INSERT INTO orderdetails 
(orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES 
('99999', 'S24_2000', '45', '32.53', '3');