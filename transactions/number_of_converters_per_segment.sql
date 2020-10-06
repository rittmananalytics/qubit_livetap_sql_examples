SELECT segmentName,
	 COUNT(DISTINCT(context_id)) as visitors
FROM `qubit-client-37040.halfords_uk_prod__v2__v2.livetap_transaction` t
LEFT JOIN `qubit-client-37040.halfords_uk_prod__v2__v2.livetap_segment` s
ON t.view_id = s.view_id
GROUP BY 1
