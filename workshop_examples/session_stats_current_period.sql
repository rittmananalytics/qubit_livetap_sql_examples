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
    `qubit-client-37040.halfords_uk_prod__v2.livetap_view` AS q_view_v01
  WHERE
    (q_view_v01.context_viewNumber = 1)
    AND (q_view_v01.context_sessionViewNumber = 1)
    AND q_view_v01.property_event_ts between timestamp_sub(current_timestamp, interval 10 day) and current_timestamp),
  last_view_in_session_current_period AS (
  SELECT
    q_view_v01.context_id AS last_view_context_id,
    q_view_v01.property_event_ts AS last_view_property_event_ts,
    q_view_v01.view_id AS last_view_view_id,
    q_view_v01.context_viewNumber AS last_view_viewNumber,
    q_view_v01.context_sessionNumber AS last_view_session_number,
  FROM
    `qubit-client-37040.halfords_uk_prod__v2.livetap_view` AS q_view_v01
  WHERE
    q_view_v01.last_view_in_session ),
  session_stats_current_period as (
SELECT
  s.property_event_ts as session_start_ts,
  s.views_in_session as hits_in_session,
  1 as sessions,
  timestamp_diff(s.property_event_ts,l.last_view_property_event_ts,SECOND) as session_length_secs,
  timestamp_diff(s.property_event_ts,l.last_view_property_event_ts,SECOND)/s.views_in_session as avg_hit_length_secs
FROM
  session_current_period s
JOIN
  last_view_in_session_current_period l
ON
  s.context_id = l.last_view_context_id
  AND s.session_number = l.last_view_session_number)
select max(date(session_start_ts)) as session_date,
  avg(hits_in_session) as avg_hits_in_session,
  count(sessions) as count_of_sessions,
  avg(session_length_secs) as avg_session_length_secs,
  avg(avg_hit_length_secs) as avg_hit_length_secs
from session_stats_current_period
