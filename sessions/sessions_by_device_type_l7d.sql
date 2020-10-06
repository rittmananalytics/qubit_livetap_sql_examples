WITH q_session_v01 AS (SELECT
        *
      FROM
        `qubit-client-37040.halfords_uk_prod__v2____v2.livetap_session`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
      )
SELECT
	q_session_v01.deviceType  AS q_session_v01_device_type,
	COUNT(DISTINCT q_session_v01.session_id)  AS q_session_v01_sessions
FROM `qubit-client-37040.halfords_uk_prod__v2____v2.livetap_view`  AS q_view_v01
LEFT JOIN q_session_v01 ON q_session_v01.session_id = q_view_v01.session_id

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1
ORDER BY 2 DESC
LIMIT 500
