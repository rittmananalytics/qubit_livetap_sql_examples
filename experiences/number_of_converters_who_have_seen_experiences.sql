SELECT experienceName,
	 COUNT(DISTINCT(context_id)) as visitors
FROM qp_bi_transaction_v01 t
LEFT JOIN qp_bi_visitor_first_seen_experience_v01 e
ON t.view_id = e.view_id
GROUP BY 1
