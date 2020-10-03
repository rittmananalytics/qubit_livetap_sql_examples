SELECT
	v.page_type  AS page_type,
	v.page_subtype as page_subtype,
	COUNT(DISTINCT v.context_id)  AS unique_visitors
FROM
  qubit-client-XXXXX.YYYYY_uk_prod__v2.livetap_view  v
WHERE
	v.property_event_ts > timestamp_sub(current_timestamp,interval 7 day)
GROUP BY
	1,2
ORDER BY
	3
