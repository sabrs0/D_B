DROP TABLE TMP_TAB;
SELECT TRANSPORT, TRANSPORT_TYPE,	(
										SELECT sum(PRODUCT_AMOUNT) 
										FROM DELIVERY
										WHERE ROUTE_ID  IN	(
																SELECT ID 
																FROM ROUTE
																WHERE TRANSPORT = R.TRANSPORT AND TRANSPORT_TYPE = R.TRANSPORT_TYPE
															)
									) AS PRODUCT_AMOUNT
INTO TMP_TAB
FROM ROUTE R;

	--SELECT TRANSPORT, PRODUCT_AMOUNT, ROW_NUMBER() OVER(PARTITION BY TRANSPORT) AS ROW_
	--FROM TMP_TAB
DROP TABLE NEW_TMP_TAB;

SELECT TRANSPORT, TRANSPORT_TYPE, PRODUCT_AMOUNT
INTO NEW_TMP_TAB                              
FROM  (SELECT TRANSPORT, TRANSPORT_TYPE, PRODUCT_AMOUNT, ROW_NUMBER ()            
             OVER (PARTITION BY TRANSPORT, PRODUCT_AMOUNT) AS ROW_NBR 
             FROM TMP_TAB                                                                             
            ) AS FOO                                                  
      WHERE ROW_NBR = 1;
DROP TABLE TMP_TAB; 
SELECT TRANSPORT, PRODUCT_AMOUNT, ROW_NUMBER() OVER(PARTITION BY TRANSPORT) AS ROW_
	FROM new_TMP_TAB;
DROP TABLE new_TMP_TAB;
-- вЫВЕСТИ ОБЩУЮ СТОИМОСТЬ ВСЕГО ИБУПРОФЕНА ПЕРЕВОЗИВШЕГОСЯ ПО ВОЗДУХУ
