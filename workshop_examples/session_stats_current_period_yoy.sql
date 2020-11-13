WITH
  session_current_period AS (
  SELECT
    q_view_v01.context_id AS context_id,
    q_view_v01.property_event_ts AS property_event_ts,
    q_view_v01.views_in_session AS views_in_session,
    q_view_v01.context_sessionNumber AS session_number,
    q_view_v01.view_id AS view_id,
    q_view_v01.context_viewNumber,
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  WHERE
    (q_view_v01.context_viewNumber = 1)
    AND (q_view_v01.context_sessionViewNumber = 1)
    AND q_view_v01.property_event_ts BETWEEN TIMESTAMP_SUB(current_timestamp, INTERVAL 7 day)
    AND current_timestamp),
  last_view_in_session_current_period AS (
  SELECT
    q_view_v01.context_id AS last_view_context_id,
    q_view_v01.property_event_ts AS last_view_property_event_ts,
    q_view_v01.view_id AS last_view_view_id,
    q_view_v01.context_viewNumber AS last_view_viewNumber,
    q_view_v01.context_sessionNumber AS last_view_session_number,
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  WHERE
    q_view_v01.last_view_in_session
    AND q_view_v01.property_event_ts BETWEEN TIMESTAMP_SUB(current_timestamp, INTERVAL 7 day)
    AND current_timestamp ),
  session_stats_current_period AS (
  SELECT
    s.property_event_ts AS session_start_ts,
    s.views_in_session AS hits_in_session,
    1 AS sessions,
    TIMESTAMP_DIFF(s.property_event_ts,l.last_view_property_event_ts,SECOND) AS session_length_secs,
    TIMESTAMP_DIFF(s.property_event_ts,l.last_view_property_event_ts,SECOND)/s.views_in_session AS avg_hit_length_secs
  FROM
    session_current_period s
  JOIN
    last_view_in_session_current_period l
  ON
    s.context_id = l.last_view_context_id
    AND s.session_number = l.last_view_session_number),
  session_yago AS (
  SELECT
    q_view_v01.context_id AS context_id,
    q_view_v01.property_event_ts AS property_event_ts,
    q_view_v01.views_in_session AS views_in_session,
    q_view_v01.context_sessionNumber AS session_number,
    q_view_v01.view_id AS view_id,
    q_view_v01.context_viewNumber,
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  WHERE
    (q_view_v01.context_viewNumber = 1)
    AND (q_view_v01.context_sessionViewNumber = 1)
    AND q_view_v01.property_event_ts BETWEEN TIMESTAMP_SUB(current_timestamp, INTERVAL 375 day)
    AND TIMESTAMP_SUB(current_timestamp, INTERVAL 365 day)),
  last_view_in_session_yago AS (
  SELECT
    q_view_v01.context_id AS last_view_context_id,
    q_view_v01.property_event_ts AS last_view_property_event_ts,
    q_view_v01.view_id AS last_view_view_id,
    q_view_v01.context_viewNumber AS last_view_viewNumber,
    q_view_v01.context_sessionNumber AS last_view_session_number,
  FROM
    `qubit-client-PROJECT_ID.CLIENT_NAME__v2.livetap_view` AS q_view_v01
  WHERE
    q_view_v01.last_view_in_session
    AND q_view_v01.property_event_ts BETWEEN TIMESTAMP_SUB(current_timestamp, INTERVAL 375 day)
    AND TIMESTAMP_SUB(current_timestamp, INTERVAL 365 day) ),
  session_stats_yago AS (
  SELECT
    s.property_event_ts AS session_start_ts,
    s.views_in_session AS hits_in_session,
    1 AS sessions,
    TIMESTAMP_DIFF(s.property_event_ts,l.last_view_property_event_ts,SECOND) AS session_length_secs,
    TIMESTAMP_DIFF(s.property_event_ts,l.last_view_property_event_ts,SECOND)/s.views_in_session AS avg_hit_length_secs
  FROM
    session_yago s
  JOIN
    last_view_in_session_yago l
  ON
    s.context_id = l.last_view_context_id
    AND s.session_number = l.last_view_session_number),
  current_vs_yago_stats AS (
  SELECT
    DATE(c.session_start_ts) AS session_date,
    AVG(c.hits_in_session) AS avg_hits_in_session,
    AVG(y.hits_in_session) AS yoy_avg_hits_in_session,
    COUNT(c.sessions) AS count_of_sessions,
    COUNT(y.sessions) AS yoy_count_of_sessions,
    AVG(c.session_length_secs) AS avg_session_length_secs,
    AVG(y.session_length_secs) AS yoy_avg_session_length_secs,
    AVG(c.avg_hit_length_secs) AS avg_hit_length_secs,
    AVG(y.avg_hit_length_secs) AS yoy_avg_hit_length_secs
  FROM
    session_stats_current_period c
  JOIN
    session_stats_yago y
  ON
    DATE_SUB(DATE(c.session_start_ts), INTERVAL 1 year) = DATE(y.session_start_ts)
  GROUP BY
    1 )
SELECT
  *
FROM
  current_vs_yago_stats
