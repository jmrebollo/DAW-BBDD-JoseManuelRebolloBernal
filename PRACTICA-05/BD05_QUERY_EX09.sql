INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
SELECT customerNumber + 2000, contactLastName, contactFirstName,'x0000', 'new@company.com', '1', NULL, 'Sales Rep'
FROM customers;