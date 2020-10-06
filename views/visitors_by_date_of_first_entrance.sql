SELECT
	FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(timestamp(q_view_v01.visitor_first_entry_date) , WEEK(MONDAY))) AS visitor_first_entry_week,
	COUNT(DISTINCT q_view_v01.context_id)  AS visitors
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_view`  AS q_view_v01

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -364 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -364 DAY), INTERVAL 365 DAY)))))
GROUP BY 1
ORDER BY 1
