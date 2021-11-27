SELECT MADE_IN_COUNTRY, AVG(PRICE::NUMERIC)
FROM DRUG
WHERE MADE_IN_COUNTRY LIKE '%United%' = FALSE
GROUP BY MADE_IN_COUNTRY 
HAVING AVG(PRICE::NUMERIC) > (	SELECT AVG(PRICE::NUMERIC )
							FROM DRUG )
-- ГРУППИРУЕМ ПО СТРАНАМ СРЕДНИЕ ЦЕНЫ, ПРИ ЭТОМ НЕ ТРОГАЕМ СТРАНЫ С ПРЕФИКСОМ UNITED, ПРИ ЭТОМ СРЕДНЯЯ ЦЕНА СГРУППИРОВАННЫХ БОЛЬШЕ ОБЩЕЦ СРЕДНЕЙ ЦЕНЫ 