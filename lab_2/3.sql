SELECT * FROM DELIVERY JOIN CUSTOMER ON CUSTOMER.ID = DELIVERY.CUSTOMER_ID
WHERE CUSTOMER.NAME LIKE 'David%'  