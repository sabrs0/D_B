SELECT AVG(PRODUCT_AMOUNT) FROM DELIVERY WHERE (ROUTE_ID IN (SELECT ID FROM ROUTE WHERE MED_FRIDGE = 1::BOOLEAN)); --СРЕДНЕЕ КОЛИЧЕСТВО ПРОДУКТОВ, ДЛЯ ПЕРЕВОЗКИ КОТОРЫХ НЕОБХОДИМ ХОЛОДИЛЬНИК