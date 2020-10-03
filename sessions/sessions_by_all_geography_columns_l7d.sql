WITH q_session_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.CLIENTNAME____v2.livetap_session`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
      )
SELECT
	q_session_v01.ipLocation_area  AS q_session_v01_ip_location_area,
	q_session_v01.ipLocation_city  AS q_session_v01_ip_location_city,
	q_session_v01.ipLocation_country  AS q_session_v01_ip_location_country,
	q_session_v01.ipLocation_country_code  AS q_session_v01_ip_location_country_code,
	q_session_v01.ipLocation_region  AS q_session_v01_ip_location_region,
	COUNT(DISTINCT q_session_v01.session_id)  AS q_session_v01_sessions,
	COUNT(DISTINCT q_session_v01.context_id)  AS q_session_v01_session_visitors
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME____v2.livetap_view`  AS q_view_v01
LEFT JOIN q_session_v01 ON q_session_v01.session_id = q_view_v01.session_id

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1,2,3,4,5
ORDER BY 6 DESC
LIMIT 500
