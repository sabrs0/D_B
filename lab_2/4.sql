SELECT * FROM DELIVERY
		WHERE ROUTE_ID IN (SELECT ID FROM ROUTE 
							WHERE MED_FRIDGE = 1::BOOLEAN)
	AND       DRUG_ID  IN (SELECT ID FROM DRUG
							WHERE TRANSPORT_REQS = 'canned')