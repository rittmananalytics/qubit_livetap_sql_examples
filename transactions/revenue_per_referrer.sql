SELECT referrer_type ,
	SUM(basket_total_baseValue)
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_transaction` t
LEFT JOIN `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_entrance` e
ON t.entrance_id = e.entrance_id
GROUP BY 1
