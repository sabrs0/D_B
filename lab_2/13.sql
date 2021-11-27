SELECT ID, NAME, LOCATION 
FROM CUSTOMER
WHERE ID IN (	SELECT CUSTOMER_ID 
				FROM DELIVERY 
				WHERE DRUG_ID IN (	SELECT ID 
									FROM DRUG 
									WHERE PRICE::NUMERIC >= (SELECT AVG(PRICE::NUMERIC) FROM DRUG
															)
								)
			)
-- Вывести покупателей, которые купили лекарство, чья стоймости больше либо равна средней