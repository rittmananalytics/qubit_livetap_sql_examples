SELECT referrer_type ,
	SUM(basket_total_baseValue)
FROM `qubit-client-37040.halfords_uk_prod__v2__v2.livetap_transaction` t
LEFT JOIN `qubit-client-37040.halfords_uk_prod__v2__v2.livetap_entrance` e
ON t.entrance_id = e.entrance_id
GROUP BY 1
