UPDATE products 
SET 
    buyPrice = buyPrice * 1.0002,
    MSRP = MSRP * 1.0002
WHERE
    quantityInStock > 500;