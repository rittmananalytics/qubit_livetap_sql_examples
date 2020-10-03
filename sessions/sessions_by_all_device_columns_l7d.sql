WITH q_session_v01 AS (SELECT
        *
      FROM
        `qubit-client-CLIENTPROJECTNUM.CLIENTNAME____v2.livetap_session`
      WHERE
        ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
      )
SELECT
	q_session_v01.deviceType  AS q_session_v01_device_type,
	q_session_v01.appType  AS q_session_v01_app_type,
	q_session_v01.appName  AS q_session_v01_app_name,
	q_session_v01.appVersion  AS q_session_v01_app_version,
	q_session_v01.deviceName  AS q_session_v01_device_name,
	q_session_v01.osName  AS q_session_v01_os_name,
	q_session_v01.osVersion  AS q_session_v01_os_version,
	COUNT(DISTINCT q_session_v01.session_id)  AS q_session_v01_sessions
FROM `qubit-client-CLIENTPROJECTNUM.CLIENTNAME____v2.livetap_view`  AS q_view_v01
LEFT JOIN q_session_v01 ON q_session_v01.session_id = q_view_v01.session_id

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1,2,3,4,5,6,7
ORDER BY 8 DESC
LIMIT 500
