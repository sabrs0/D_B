SELECT ID, NAME, BIRTH_DATE
FROM CUSTOMER C JOIN (	SELECT  CUSTOMER_ID
						FROM DELIVERY 
						WHERE DRUG_ID IN(	SELECT ID 
											FROM DRUG 
											WHERE NAME = 'Adderall')) D
ON C.ID = D.CUSTOMER_ID
-- ВЫВЕСТИ ЛЮДЕЙ, КОТОРЫЕ ЗАКАЗАЛИ АДДЕРОЛЛ