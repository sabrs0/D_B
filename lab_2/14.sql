SELECT MADE_IN_COUNTRY, AVG(PRICE::NUMERIC)
FROM DRUG
WHERE MADE_IN_COUNTRY LIKE '%United%' = FALSE
GROUP BY MADE_IN_COUNTRY
-- ГРУППИРУЕМ ПО СТРАНАМ СРЕДНИЕ ЦЕНЫ, ПРИ ЭТОМ НЕ ТРОГАЕМ СТРАНЫ С ПРЕФИКСОМ UNITED