SELECT
	COUNT(DISTINCT v.context_id)  AS unique_visitors
FROM
  qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_view  v

WHERE
	v.property_event_ts > timestamp_sub(current_timestamp,interval 7 day)
