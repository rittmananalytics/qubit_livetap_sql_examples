WITH
  fitting_page_sessions AS (
  SELECT
    DATE(q_view_v01.property_event_ts) AS session_date,
    q_session_v01.context_id AS context_id,
    q_session_v01.context_sessionNumber AS session_number
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  LEFT JOIN
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_session` AS q_session_v01
  ON
    q_session_v01.session_id = q_view_v01.session_id
  WHERE
    UPPER(q_view_v01.meta_url ) LIKE UPPER('%halfords-fitting-services%')
    AND q_view_v01.property_event_ts BETWEEN TIMESTAMP_SUB(current_timestamp, INTERVAL 30 day)
    AND current_timestamp ),
  bulb_sessions AS (
  SELECT
    DATE(q_view_v01.property_event_ts) AS session_date,
    q_session_v01.context_id AS context_id,
    q_session_v01.context_sessionNumber AS session_number
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  LEFT JOIN
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_session` AS q_session_v01
  ON
    q_session_v01.session_id = q_view_v01.session_id
  WHERE
    UPPER(q_view_v01.page_subtype ) = UPPER('Bulbs')
    AND q_view_v01.property_event_ts BETWEEN TIMESTAMP_SUB(current_timestamp, INTERVAL 30 day)
    AND current_timestamp ),
  bulb_and_fitting_sessions AS (
  SELECT
    f.session_date,
    COUNT(*)
  FROM
    fitting_page_sessions f
  JOIN
    bulb_sessions b
  ON
    f.context_id = b.context_id
    AND f.session_number = b.session_number
  GROUP BY
    1 )
SELECT
  *
FROM
  bulb_and_fitting_sessions
ORDER BY
  1 DESC
LIMIT
  30
