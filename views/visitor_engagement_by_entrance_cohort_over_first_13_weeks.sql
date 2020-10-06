SELECT
	FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(timestamp(q_view_v01.visitor_first_entry_date) , WEEK(MONDAY))) AS visitor_first_entry_week,
	DATE_DIFF(CAST(q_view_v01.meta_serverTs AS DATE), CAST(TIMESTAMP((CAST(q_view_v01.visitor_first_entry_date  AS DATE))) AS DATE),WEEK)  AS weeks_since_first_entry,
	COUNT(DISTINCT q_view_v01.context_id)  AS unique_visitors
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME__v2.livetap_view`  AS q_view_v01

WHERE (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -364 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -364 DAY), INTERVAL 365 DAY))))) AND (DATE_DIFF(CAST(q_view_v01.meta_serverTs AS DATE), CAST(TIMESTAMP((CAST(q_view_v01.visitor_first_entry_date  AS DATE))) AS DATE),WEEK)  <= 13)
GROUP BY 1,2
ORDER BY 1 DESC,2
